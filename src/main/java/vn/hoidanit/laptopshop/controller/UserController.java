package vn.hoidanit.laptopshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

  final private UserService userService;

  public UserController(UserService userService) {
    this.userService = userService;
  }

  @RequestMapping("/")
  public String getHomePage() {
    String text = userService.handleHello();
    // return "triu.html"; //loi ne
    // return "trieu.html"; // phai tra ve mot view, la ten cua file html
    return "hello"; // trả về view hello.jsp
  }
}

// @RestController
// public class UserController {

// final private UserService userService;

// // DI: dependency Injection
// public UserController(UserService userService) {
// this.userService = userService;
// }

// @GetMapping("")
// public String getHomePage() {
// return userService.handleHello();
// }
// }