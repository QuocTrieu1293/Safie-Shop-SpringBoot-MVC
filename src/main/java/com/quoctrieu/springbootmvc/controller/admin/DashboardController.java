package com.quoctrieu.springbootmvc.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.repository.UserRepository;
import com.quoctrieu.springbootmvc.service.ProductService;

@Controller
public class DashboardController {

  private final UserRepository userRepository;
  private final ProductService productService;
  private final OrderRepository orderRepository;

  DashboardController(UserRepository userRepository, ProductService productService,
      OrderRepository orderRepository) {
    this.userRepository = userRepository;
    this.productService = productService;
    this.orderRepository = orderRepository;
  }

  @GetMapping("/admin")
  public String getDashboard(Model model) {

    model.addAttribute("userCount", userRepository.count());
    model.addAttribute("productCount", productService.count());
    model.addAttribute("orderCount", orderRepository.count());

    return "admin/dashboard/show";
  }
}
