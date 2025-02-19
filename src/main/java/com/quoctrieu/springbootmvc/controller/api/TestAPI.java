package com.quoctrieu.springbootmvc.controller.api;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.VerifyUserToken;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.repository.UserRepository;
import com.quoctrieu.springbootmvc.repository.VerifyUserTokenRepository;
import com.quoctrieu.springbootmvc.service.MailService;

@RestController
public class TestAPI {

  private final UserRepository userRepository;
  private final VerifyUserTokenRepository verifyTokenRepo;
  private final MailService mailService;

  public TestAPI(UserRepository userRepository, VerifyUserTokenRepository verifyTokenRepo,
      MailService mailService) {
    this.userRepository = userRepository;
    this.verifyTokenRepo = verifyTokenRepo;
    this.mailService = mailService;
  }

  // @PostMapping("/verifyUser/sendMail")
  // public String testSendMail(@RequestBody Map<String, String> body,
  // RedirectAttributes redirectAttributes) {
  // String email = body.get("email");
  // User user = userRepository.findByEmail(email);
  // if (user == null) {
  // redirectAttributes.addFlashAttribute("errorMessage", "Không tồn tại tài khoản
  // ứng với email " + email);
  // return "redirect:/register";
  // } else if (user.isEnabled()) {
  // redirectAttributes.addFlashAttribute("successMessage", "Tài khoản đã được xác
  // thực");
  // return "redirect:/login";
  // }
  // VerifyUserToken verifyToken = verifyTokenRepo.findByUserId(user.getId());
  // try {
  // mailService.sendVerifyRegistrationMail(verifyToken);
  // } catch (Exception e) {
  // e.printStackTrace();
  // return "Mail sent fail!";
  // }

  // return "Mail sent!";

  // }

}
