package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;
import vn.hoidanit.laptopshop.service.FileService;
import vn.hoidanit.laptopshop.service.FileService.Type;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

  final private UserService userService;
  final private FileService fileService;

  public UserController(UserService userService, FileService fileService) {
    this.userService = userService;
    this.fileService = fileService;
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
    return "admin/user/show";
  }

  @RequestMapping("/admin/user/create")
  public String getCreateUserPage(Model model) {
    model.addAttribute("newUser", new User());
    return "admin/user/create";
  }

  @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
  public String createUser(@ModelAttribute("newUser") User user, @RequestParam("avatar_file") MultipartFile file) {
    if (!file.isEmpty()) {
      String savedFile = fileService.saveImage(file, Type.AVATAR);
      user.setAvatar(savedFile);
    }
    User newUser = userService.registerUser(user);
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
  public String updateUser(@ModelAttribute User user,
      @RequestParam("avatar_file") MultipartFile file,
      @RequestParam(defaultValue = "false") boolean isDeleteAvatar,
      RedirectAttributes redirectAttributes) {
    if (isDeleteAvatar) {
      fileService.deleteImage(user.getAvatar(), Type.AVATAR);
      user.setAvatar(null);
    }
    if (!file.isEmpty()) {
      String savedFile = fileService.saveImage(file, Type.AVATAR);
      user.setAvatar(savedFile);
    }
    try {
      User updatedUser = userService.updateUser(user);
      redirectAttributes.addFlashAttribute("successMessage", "User updated successfully!");
    } catch (Exception e) {
      e.printStackTrace();
      redirectAttributes.addFlashAttribute("errorMessage", "Fail to update user. Please try again later.");
    }
    return "redirect:/admin/user/update/" + user.getId();
  }

  @GetMapping("/admin/user/delete/{id}")
  public String getUserDeletePage(@PathVariable long id, Model model) {
    User user = userService.get(id);
    model.addAttribute("user", user);
    return "/admin/user/delete";
  }

  @PostMapping("/admin/user/delete/{id}")
  public String deleteUser(@PathVariable long id) {
    User user = userService.get(id);
    if (user == null)
      return "redirect:/admin/user";

    String fileName = user.getAvatar();
    if (fileName != null && !fileName.isEmpty()) {
      fileService.deleteImage(fileName, Type.AVATAR);
    }
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