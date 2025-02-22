package com.quoctrieu.springbootmvc.controller.client;

import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.VerifyUserToken;
import com.quoctrieu.springbootmvc.domain.dto.ChangePasswordDTO;
import com.quoctrieu.springbootmvc.domain.dto.ResetPasswordDTO;
import com.quoctrieu.springbootmvc.repository.UserRepository;
import com.quoctrieu.springbootmvc.repository.VerifyUserTokenRepository;
import com.quoctrieu.springbootmvc.service.MailService;
import com.quoctrieu.springbootmvc.service.UserService;
import com.quoctrieu.springbootmvc.service.VerifyUserTokenService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/profile/account/password")
public class ChangePasswordController {

  private final PasswordEncoder passwordEncoder;
  private final UserService userService;
  private final UserRepository userRepository;
  private final MailService mailService;
  private final VerifyUserTokenService verifyTokenService;
  private final VerifyUserTokenRepository verifyTokenRepo;

  public ChangePasswordController(PasswordEncoder passwordEncoder, UserService userService,
      UserRepository userRepository, MailService mailService, VerifyUserTokenService verifyTokenService,
      VerifyUserTokenRepository verifyTokenRepo) {
    this.passwordEncoder = passwordEncoder;
    this.userService = userService;
    this.userRepository = userRepository;
    this.mailService = mailService;
    this.verifyTokenService = verifyTokenService;
    this.verifyTokenRepo = verifyTokenRepo;
  }

  @GetMapping("")
  public String getChangePasswordPage(HttpSession session, Model model) {
    Long userId = (Long) session.getAttribute("userId");
    User user = userService.get(userId);
    if (user.getAuthenProvider() != null && !user.getAuthenProvider().equals("Local"))
      return "/client/profile/account/changeOAuth2Password";

    model.addAttribute("changePasswordDTO", new ChangePasswordDTO());
    return "/client/profile/account/changePassword";
  }

  @PostMapping("")
  public String changePassword(@Valid @ModelAttribute ChangePasswordDTO changePasswordDTO,
      BindingResult bindingResult, HttpSession session, RedirectAttributes redirectAttributes) {
    Long userId = (Long) session.getAttribute("userId");
    User user = userService.get(userId);

    if (!passwordEncoder.matches(changePasswordDTO.getPassword(), user.getPassword())) {
      FieldError passwordError = new FieldError("changePasswordDTO", "password", changePasswordDTO.getPassword(), false,
          null, null, "Mật khẩu không chính xác");
      bindingResult.addError(passwordError);
    }

    if (!changePasswordDTO.getNewPassword().equals(changePasswordDTO.getConfirmNewPassword())) {
      FieldError confirmPasswordError = new FieldError("changePasswordDTO", "confirmNewPassword",
          changePasswordDTO.getConfirmNewPassword(), false, null, null, "Mật khẩu xác nhận không khớp");
      bindingResult.addError(confirmPasswordError);
    }

    if (bindingResult.hasErrors()) {
      bindingResult.getFieldErrors().forEach(
          e -> System.out.println(">>> ERR changePassword: " + e.getField() + " - " + e.getDefaultMessage()));
      return "/client/profile/account/changePassword";
    }

    user.setPassword(passwordEncoder.encode(changePasswordDTO.getNewPassword()));
    userRepository.save(user);

    redirectAttributes.addFlashAttribute("successMessage", "Thay đổi mật khẩu thành công");
    return "redirect:/profile/account/password";
  }

  @PostMapping("/sendMail")
  public ResponseEntity<String> sendMailSettingPassword(@RequestBody Map<String, String> body) {
    String email = body.get("email");
    User user = userRepository.findByEmail(email);
    if (user == null) {
      return ResponseEntity.badRequest().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Tài khoản không tồn tại");
    }
    if (!user.isEnabled()) {
      return ResponseEntity.badRequest().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Tài khoản chưa được xác thực");
    }

    VerifyUserToken verifyToken = verifyTokenRepo.findByUserId(user.getId());
    if (verifyToken == null)
      verifyToken = verifyTokenService.createToken(user);

    try {
      mailService.sendSetPasswordMail(verifyToken);
    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.internalServerError().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Gửi mail không thành công");
    }

    return ResponseEntity.ok().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
        .body("Đã gửi mail thiết lập mật khẩu");
  }

  @GetMapping("/reset")
  public String getSetPasswordPage(@RequestParam String token, Model model) {
    ResetPasswordDTO dto = new ResetPasswordDTO();
    dto.setToken(token);
    model.addAttribute("resetPasswordDTO", dto);

    return "/client/auth/resetPassword";
  }

  @PostMapping("/reset")
  public String setPassword(@Valid @ModelAttribute("resetPasswordDTO") ResetPasswordDTO dto,
      BindingResult bindingResult, Model model) {
    if (!dto.getNewPassword().equals(dto.getConfirmNewPassword())) {
      FieldError error = new FieldError("resetPasswordDTO", "confirmNewPassword", "Mật khẩu xác nhận không khớp");
      bindingResult.addError(error);
    }

    if (bindingResult.hasErrors()) {
      bindingResult.getFieldErrors().forEach(
          e -> System.out.println(">>> ERR setPassword: " + e.getField() + " - " + e.getDefaultMessage()));
      return "/client/auth/resetPassword";
    }

    model.addAttribute("title", "Thiết lập mật khẩu");
    try {
      VerifyUserToken verifyToken = verifyTokenRepo.findByToken(dto.getToken());
      String email = verifyToken.getUser().getEmail();
      verifyTokenService.resetPassword(dto.getToken(), dto.getNewPassword());
      model.addAttribute("successMessage",
          String.format("Thiết lập mật khẩu tài khoản <b class'text-primary'>%s</b> thành công", email));
    } catch (Exception e) {
      e.printStackTrace();
      model.addAttribute("errorMessage", "Có lỗi xảy ra khi thiết lập mật khẩu");
    }

    return "/client/auth/verifyTokenResult";
  }
}