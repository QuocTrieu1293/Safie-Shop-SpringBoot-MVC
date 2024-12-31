package com.quoctrieu.springbootmvc.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.service.OrderService;
import com.quoctrieu.springbootmvc.service.UtilsService;

@Controller
public class OrderController {
  private final OrderRepository orderRepository;
  private final OrderService orderService;

  OrderController(OrderRepository orderRepository, OrderService orderService) {
    this.orderRepository = orderRepository;
    this.orderService = orderService;
  }

  @GetMapping("/admin/order")
  public String getOrderPage(Model model, @RequestParam(defaultValue = "1") String page) {

    Pageable pageable = UtilsService.getPageRequest(page, 4);
    Page<Order> pagedOrder = orderRepository.findAll(pageable);
    List<Order> orders = pagedOrder.getContent();
    model.addAttribute("orders", orders);
    model.addAttribute("totalPages", pagedOrder.getTotalPages());
    model.addAttribute("currentPage", pageable.getPageNumber() + 1);

    return "admin/order/show";
  }

  @GetMapping("/admin/order/{id}")
  public String getOrderDetailPage(@PathVariable long id, Model model) {

    Order order = orderRepository.findById(id).orElse(null);

    model.addAttribute("order", order);

    return "admin/order/detail";
  }

  @GetMapping("/admin/order/delete/{id}")
  public String getDeleteOrderPage(@PathVariable long id, Model model) {

    Order order = orderRepository.findById(id).orElse(null);

    model.addAttribute("order", order);

    return "admin/order/delete";
  }

  @PostMapping("/admin/order/delete/{id}")
  public String postMethodName(@PathVariable long id, Model model, RedirectAttributes redirectAttributes) {

    orderService.delete(id);
    redirectAttributes.addFlashAttribute("successMessage", "Order deleted successfully!");

    return "redirect:/admin/order";
  }

}
