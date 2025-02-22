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
import com.quoctrieu.springbootmvc.domain.dto.ResetPasswordDTO;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.repository.UserRepository;
import com.quoctrieu.springbootmvc.repository.VerifyUserTokenRepository;
import com.quoctrieu.springbootmvc.service.MailService;

@Controller
@RequestMapping("/api/test")
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

  @GetMapping("")
  public String getTestPage(Model model) {
    String testPage = "/client/auth/resetPassword";

    ResetPasswordDTO dto = new ResetPasswordDTO();
    dto.setToken("token@123");
    model.addAttribute("resetPasswordDTO", dto);

    return testPage;
  }

}
