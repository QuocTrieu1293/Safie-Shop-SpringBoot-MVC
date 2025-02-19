package com.quoctrieu.springbootmvc.controller.client;

import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.VerifyUserToken;
import com.quoctrieu.springbootmvc.repository.UserRepository;
import com.quoctrieu.springbootmvc.repository.VerifyUserTokenRepository;
import com.quoctrieu.springbootmvc.service.MailService;
import com.quoctrieu.springbootmvc.service.VerifyUserTokenService;

@Controller
@RequestMapping("/verifyUser")
public class VerifyUserController {

  private final UserRepository userRepository;
  private final VerifyUserTokenRepository verifyTokenRepo;
  private final VerifyUserTokenService verifyTokenService;
  private final MailService mailService;

  public VerifyUserController(UserRepository userRepository, VerifyUserTokenRepository verifyTokenRepo,
      VerifyUserTokenService verifyTokenService,
      MailService mailService) {
    this.userRepository = userRepository;
    this.verifyTokenRepo = verifyTokenRepo;
    this.verifyTokenService = verifyTokenService;
    this.mailService = mailService;

  }

  @GetMapping("/sendMail")
  public String getVerifyMailPage(@RequestParam String email) {

    User user = userRepository.findByEmail(email);
    if (user == null || user.isEnabled())
      return "redirect:/login";

    return "client/auth/verifyUser";
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
          .body("Tài khoản đã được xác thực");
    }
    VerifyUserToken verifyToken = verifyTokenRepo.findByUserId(user.getId());
    if (verifyToken == null)
      return ResponseEntity.badRequest().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Gửi mail thất bại");
    try {
      mailService.sendVerifyRegistrationMail(verifyToken);
    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.internalServerError().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
          .body("Gửi mail thất bại");
    }

    return ResponseEntity.ok().contentType(MediaType.valueOf("text/plain; charset=UTF-8"))
        .body("Đã gửi mail xác thực");
  }

  @GetMapping("/verify")
  public String verifyUser(@RequestParam String token, RedirectAttributes redirectAttributes) {
    try {
      verifyTokenService.verifyToken(token);
      redirectAttributes.addFlashAttribute("successMessage", "Xác thực tài khoản thành công");
    } catch (Exception e) {
      e.printStackTrace();
      redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xác thực tài khoản");
    }

    return "redirect:/login";
  }

}
