package vn.hoidanit.laptopshop.controller.client;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.repository.RoleRepository;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
@RequestMapping("/")
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
  public String getRegisterPage(Model model) {

    model.addAttribute("registerUser", new RegisterDTO());

    return "client/auth/register";
  }

  @PostMapping("/register")
  public String handleRegister(@Valid @ModelAttribute("registerUser") RegisterDTO registerDTO,
      BindingResult bindingResult, RedirectAttributes redirectAttributes) {

    if (bindingResult.hasFieldErrors()) {
      List<FieldError> errors = bindingResult.getFieldErrors();
      errors.forEach(
          (e) -> System.out.println(">>> ERR Validate RegisterDTO: " + e.getField() + " - " + e.getDefaultMessage()));
      return "client/auth/register";
    }

    User user = userService.registerDTOToUser(registerDTO);
    user.setRole(roleRepository.findByName("User"));
    User registeredUser = userService.registerUser(user);

    redirectAttributes.addFlashAttribute("successMessage", "Account registered successfully!");

    return "redirect:/login";
  }

  @GetMapping("/login")
  public String getLoginPage(Model model) {

    return "client/auth/login";
  }

  @GetMapping("/access-deny")
  public String getAccessDenyPage() {
    return "client/auth/deny";
  }

}
