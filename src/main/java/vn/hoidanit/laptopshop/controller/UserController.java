package vn.hoidanit.laptopshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {

  final private UserService userService;

  public UserController(UserService userService) {
    this.userService = userService;
  }

  @RequestMapping("/")
  public String getHomePage(Model model) {
    String test = userService.handleHello();
    // return "triu.html"; //loi ne
    // return "trieu.html"; // phai tra ve mot view, la ten cua file html

    model.addAttribute("test", test);
    model.addAttribute("trieu", "tre tuoi, nhieu tien");

    return "hello"; // trả về view hello.jsp
  }

  @RequestMapping("/admin/user")
  public String getCreateUserPage(Model model) {
    model.addAttribute("newUser", new User());
    return "admin/user/create";
  }

  @RequestMapping(value = "/admin/user", method = RequestMethod.POST)
  public String createUser(Model model, @ModelAttribute("newUser") User user) {
    System.out.println("create user controller: " + user);
    return "hello";
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