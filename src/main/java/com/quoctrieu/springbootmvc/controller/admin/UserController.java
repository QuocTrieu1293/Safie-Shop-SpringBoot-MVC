package com.quoctrieu.springbootmvc.controller.admin;

import java.util.List;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.service.FileService;
import com.quoctrieu.springbootmvc.service.FileService.Type;
import com.quoctrieu.springbootmvc.service.RoleService;
import com.quoctrieu.springbootmvc.service.UserService;
import com.quoctrieu.springbootmvc.service.UtilsService;

@Controller
// @SessionAttributes("roles")
public class UserController {

  final private UserService userService;
  final private FileService fileService;
  final private RoleService roleService;

  @InitBinder
  public void initBinder(WebDataBinder binder) {
    binder.registerCustomEditor(String.class, new StringTrimmerEditor(true)); // Converts "" to null
  }

  // @ModelAttribute("roles")
  // public List<Role> populateRoles() {
  // return roleService.getAll();
  // }

  public UserController(UserService userService, FileService fileService, RoleService roleService) {
    this.userService = userService;
    this.fileService = fileService;
    this.roleService = roleService;
  }

  // @RequestMapping("/")
  // public String getHomePage(Model model) {
  // // return "triu.html"; //loi ne
  // // return "trieu.html"; // phai tra ve mot view, la ten cua file html

  // model.addAttribute("test", "test");
  // model.addAttribute("trieu", "tre tuoi, nhieu tien");

  // return "hello"; // trả về view hello.jsp
  // }

  @RequestMapping("/admin/user")
  public String getUserPage(Model model, @RequestParam(defaultValue = "1") String page) {

    Pageable pageable = UtilsService.getPageRequest(page, 4);
    Page<User> pagedUser = userService.getPage(pageable);
    List<User> userList = pagedUser.getContent();
    model.addAttribute("userList", userList);
    model.addAttribute("totalPages", pagedUser.getTotalPages());
    model.addAttribute("currentPage", pageable.getPageNumber() + 1);

    return "admin/user/show";
  }

  @RequestMapping("/admin/user/create")
  public String getCreateUserPage(Model model) {
    model.addAttribute("newUser", new User());
    // Không cần truyền xuống mỗi lân request nx do đã lưu trong session bằng
    // @SessionAttribute
    model.addAttribute("roles", roleService.getAll());
    return "admin/user/create";
  }

  @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
  public String createUser(@Valid @ModelAttribute("newUser") User user, BindingResult userBindingResult,
      @RequestParam("avatar_file") MultipartFile file,
      RedirectAttributes redirectAttributes,
      Model model) {

    if (userService.emailExists(user.getEmail()))
      userBindingResult.rejectValue("email", "Unique", "Email already exists");

    if (userBindingResult.hasFieldErrors()) {
      List<FieldError> errors = userBindingResult.getFieldErrors();
      errors.forEach((e) -> System.out.println(">>> ERR Create User: " + e.getField() + " - " + e.getDefaultMessage()));
      model.addAttribute("roles", roleService.getAll());
      return "admin/user/create"; // return view -> dữ liệu input vẫn còn lưu
      // return "redirect:/admin/user/create"; // redirect thì như refresh lại vào lại
      // url đó -> dữ liệu input bị mất
    }

    if (!file.isEmpty()) {
      String savedFile = fileService.saveImage(file, Type.AVATAR);
      user.setAvatar(savedFile);
    }
    User newUser = userService.registerUser(user);
    redirectAttributes.addFlashAttribute("successMessage", "User created successfully!");
    return "redirect:/admin/user";
  }

  @GetMapping("/admin/user/{id}")
  public String getUserDetailPage(@PathVariable long id, Model model) {
    User user = userService.get(id);
    model.addAttribute("user", user != null ? user
        : new User("None", "None",
            "None", "None",
            "None"));
    return "admin/user/detail";
  }

  @GetMapping("/admin/user/update/{id}")
  public String getUserUpdatePage(@PathVariable long id, Model model) {
    User user = userService.get(id);
    model.addAttribute("user", user != null ? user
        : new User("None", "None",
            "None", "None",
            "None"));

    // Không cần truyền xuống mỗi lân request nx do đã lưu trong session bằng
    // @SessionAttribute
    model.addAttribute("roles", roleService.getAll());

    return "admin/user/update";
  }

  @PostMapping("/admin/user/update")
  public String updateUser(@Valid @ModelAttribute User user, BindingResult userBindingResult,
      @RequestParam("avatar_file") MultipartFile file,
      @RequestParam(defaultValue = "false") boolean isDeleteAvatar,
      RedirectAttributes redirectAttributes,
      Model model) {

    if (userBindingResult.hasFieldErrors()) {
      List<FieldError> errors = userBindingResult.getFieldErrors();
      errors.forEach((e) -> System.out.println(">>> ERR Update User: " + e.getField() + " - " + e.getDefaultMessage()));
      model.addAttribute("roles", roleService.getAll());
      return "admin/user/update";
    }

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
    return "admin/user/delete";
  }

  @PostMapping("/admin/user/delete/{id}")
  public String deleteUser(@PathVariable long id, RedirectAttributes redirectAttributes) {
    User user = userService.get(id);
    if (user == null)
      return "redirect:/admin/user";

    String fileName = user.getAvatar();
    if (fileName != null && !fileName.isEmpty()) {
      fileService.deleteImage(fileName, Type.AVATAR);
    }
    userService.delete(id);
    redirectAttributes.addFlashAttribute("successMessage", "User deleted successfully!");
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