package vn.hoidanit.laptopshop.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
    // return "triu.html"; //loi ne
    // return "trieu.html"; // phai tra ve mot view, la ten cua file html

    model.addAttribute("test", "test");
    model.addAttribute("trieu", "tre tuoi, nhieu tien");

    return "hello"; // trả về view hello.jsp
  }

  @RequestMapping("/admin/user")
  public String getUserPage(Model model) {
    List<User> userList = userService.getAll();
    model.addAttribute("userList", userList);
    return "admin/user/table-user";
  }

  @RequestMapping("/admin/user/create")
  public String getCreateUserPage(Model model) {
    model.addAttribute("newUser", new User());
    return "admin/user/create";
  }

  @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
  public String createUser(@ModelAttribute("newUser") User user) {
    // System.out.println("User from form: " + user);
    User saved_user = userService.handleSaveUser(user);
    // System.out.println("Saved user: " + saved_user);
    return "redirect:/admin/user";
  }

  @GetMapping("/admin/user/{id}")
  public String getUserDetailPage(@PathVariable long id, Model model) {
    User user = userService.get(id);
    model.addAttribute("user", user != null ? user
        : new User("None", "None",
            "None", "None",
            "None"));
    return "/admin/user/detail";
  }

  @GetMapping("/admin/user/update/{id}")
  public String getUserUpdatePage(@PathVariable long id, Model model) {
    User user = userService.get(id);
    model.addAttribute("user", user != null ? user
        : new User("None", "None",
            "None", "None",
            "None"));
    return "/admin/user/update";
  }

  @PostMapping("/admin/user/update")
  public String updateUser(@ModelAttribute("user") User updated_user, Model model) {
    User user = userService.get(updated_user.getId());
    if (user != null) {
      user.setAddress(updated_user.getAddress());
      user.setFullName(updated_user.getFullName());
      user.setPhone(updated_user.getPhone());
      userService.handleSaveUser(user);
      return "redirect:/admin/user";
    }
    model.addAttribute("errorMessage", "Update failed");
    return "admin/user/update";
  }

  @GetMapping("/admin/user/delete/{id}")
  public String getUserDeletePage(@PathVariable long id, Model model) {
    model.addAttribute("id", id);
    return "/admin/user/delete";
  }

  @PostMapping("/admin/user/delete/{id}")
  public String deleteUser(@PathVariable long id) {
    userService.delete(id);
    return "redirect:/admin/user";
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