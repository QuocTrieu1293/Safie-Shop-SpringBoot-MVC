package com.quoctrieu.springbootmvc.controller.client;

import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.VerifyUserToken;
import com.quoctrieu.springbootmvc.repository.UserRepository;
import com.quoctrieu.springbootmvc.repository.VerifyUserTokenRepository;
import com.quoctrieu.springbootmvc.service.MailService;
import com.quoctrieu.springbootmvc.service.VerifyUserTokenService;

@Controller
@RequestMapping("/verifyRegistration")
public class VerifyRegistrationController {

  private final UserRepository userRepository;
  private final VerifyUserTokenRepository verifyTokenRepo;
  private final VerifyUserTokenService verifyTokenService;
  private final MailService mailService;

  public VerifyRegistrationController(UserRepository userRepository, VerifyUserTokenRepository verifyTokenRepo,
      VerifyUserTokenService verifyTokenService,
      MailService mailService) {
    this.userRepository = userRepository;
    this.verifyTokenRepo = verifyTokenRepo;
    this.verifyTokenService = verifyTokenService;
    this.mailService = mailService;

  }

  @GetMapping("/sendMail")
  public String getSendingVerifyMailPage(@RequestParam String email, Model model) {

    User user = userRepository.findByEmail(email);
    if (user == null || user.isEnabled())
      return "redirect:/login";

    model.addAttribute("title", "Xác thực tài khoản");
    model.addAttribute("message", String.format(
        "Đường dẫn xác thực tài khoản đã được gửi qua địa chỉ email <b class='text-primary'>%s</b>. Bạn vui vòng kiểm tra hòm thư!",
        email));
    model.addAttribute("sendMailAPI", "/verifyRegistration/sendMail");

    return "client/auth/sendVerifyToken";
  }

  @PostMapping("/sendMail")
  public ResponseEntity<String> sendVerifyMail(@RequestBody Map<String, String> body) {

    String email = body.get("email");
    User user = userRepository.findByEmail(email);
    if (user == null) {
      return ResponseEntity.badRequest().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Không tồn tại tài khoản ứng với email " + email);
    } else if (user.isEnabled()) {
      return ResponseEntity.badRequest().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Tài khoản đã được xác thực trước đó rồi");
    }
    VerifyUserToken verifyToken = verifyTokenRepo.findByUserId(user.getId());
    if (verifyToken == null)
      return ResponseEntity.badRequest().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Gửi mail không thành công");
    try {
      mailService.sendVerifyRegistrationMail(verifyToken);
    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.internalServerError().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Gửi mail không thành công");
    }

    return ResponseEntity.ok().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
        .body("Đã gửi mail xác thực");
  }

  @GetMapping("/verify")
  public String verifyRegistration(@RequestParam String token, Model model) {
    model.addAttribute("title", "Xác thực tài khoản");

    VerifyUserToken verifyToken = verifyTokenRepo.findByToken(token);
    try {
      verifyTokenService.verifyRegistration(token);
      model.addAttribute("successMessage", String.format("Xác thực tài khoản <b class='text-primary'>%s</b> thành công",
          verifyToken.getUser().getEmail()));
    } catch (Exception e) {
      e.printStackTrace();
      model.addAttribute("errorMessage", "Có lỗi xảy ra khi xác thực tài khoản");
    }

    return "client/auth/verifyTokenResult";
  }

}
