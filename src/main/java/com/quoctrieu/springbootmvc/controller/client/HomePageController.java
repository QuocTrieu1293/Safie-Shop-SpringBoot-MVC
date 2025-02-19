package com.quoctrieu.springbootmvc.controller.client;

import java.util.List;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.dto.RegisterDTO;
import com.quoctrieu.springbootmvc.repository.RoleRepository;
import com.quoctrieu.springbootmvc.service.ProductService;
import com.quoctrieu.springbootmvc.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomePageController {

  private final ProductService productService;
  private final UserService userService;
  private final RoleRepository roleRepository;

  @InitBinder
  public void initBinder(WebDataBinder binder) {
    binder.registerCustomEditor(String.class, new StringTrimmerEditor(true)); // Converts "" to null
  }

  public HomePageController(ProductService productService, UserService userService, RoleRepository roleRepository) {
    this.productService = productService;
    this.userService = userService;
    this.roleRepository = roleRepository;
  }

  @GetMapping("/")
  public String getHomePage(Model model, HttpServletRequest request) {

    List<Product> products = productService.getPage(PageRequest.of(0, 8)).getContent();
    model.addAttribute("products", products);

    return "client/homepage/show";
  }

  @GetMapping("/register")
  public String getRegisterPage(Model model, HttpServletRequest request) {
    HttpSession session = request.getSession(false);
    if (session.getAttribute("userId") != null) // Trường hợp user đã login thì redirect tới trang chủ
      return "redirect:/";

    model.addAttribute("registerUser", new RegisterDTO());

    return "client/auth/register";
  }

  @PostMapping("/register")
  public String handleRegister(@Valid @ModelAttribute("registerUser") RegisterDTO registerDTO,
      BindingResult bindingResult, RedirectAttributes redirectAttributes, HttpServletRequest request) {

    if (bindingResult.hasFieldErrors()) {
      List<FieldError> errors = bindingResult.getFieldErrors();
      errors.forEach(
          (e) -> System.out.println(">>> ERR Validate RegisterDTO: " + e.getField() + " - " + e.getDefaultMessage()));
      return "client/auth/register";
    }

    User user = registerDTO.toUser();
    user.setRole(roleRepository.findByName("User"));
    User registeredUser = userService.registerUser(user);

    return "redirect:/verifyUser/sendMail?email=" + registeredUser.getEmail();
  }

  @GetMapping("/login")
  public String getLoginPage(Model model, @RequestParam(required = false) boolean invalid, HttpServletRequest request) {
    HttpSession session = request.getSession(false);

    if (invalid) {
      model.addAttribute("errorMessage", "Vui lòng đăng nhập!");
    } else if (session.getAttribute("userId") != null) { // Trường hợp user đã login thì redirect tới trang chủ
      return "redirect:/";
    }

    return "client/auth/login";
  }

  @GetMapping("/access-deny")
  public String getAccessDenyPage() {
    return "client/auth/deny";
  }

}
