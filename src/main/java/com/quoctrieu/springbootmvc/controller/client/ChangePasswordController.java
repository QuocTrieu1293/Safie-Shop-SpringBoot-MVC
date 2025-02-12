package com.quoctrieu.springbootmvc.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/profile/account/password")
public class ChangePasswordController {

  @GetMapping("")
  public String getChangePasswordPage() {
    return "client/profile/account/changePassword";
  }
}
