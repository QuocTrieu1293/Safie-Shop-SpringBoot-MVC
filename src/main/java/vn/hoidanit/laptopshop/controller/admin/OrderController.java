package vn.hoidanit.laptopshop.controller.admin;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.service.OrderService;

@Controller
public class OrderController {
  private final OrderRepository orderRepository;
  private final OrderService orderService;

  OrderController(OrderRepository orderRepository, OrderService orderService) {
    this.orderRepository = orderRepository;
    this.orderService = orderService;
  }

  @GetMapping("/admin/order")
  public String getOrderPage(Model model) {
    List<Order> orders = orderRepository.findAll();
    model.addAttribute("orders", orders);
    model.addAttribute("localDateTimeFormat", new SimpleDateFormat("dd/MM/yyyy HH:mm"));
    return "admin/order/show";
  }

  @PostMapping("/admin/order/update")
  public ResponseEntity<Map<String, String>> updateOrderStatus(@RequestParam Map<String, String> data) {
    Map<String, String> response = new HashMap<>();
    try {
      Long orderId = Long.parseLong(data.get("orderId"));
      String status = data.get("status");
      Order order = orderRepository.findById(orderId).orElse(null);
      order.setStatus(status);
      order = orderRepository.save(order);
      response.put("orderId", Long.toString(order.getId()));
      response.put("status", order.getStatus());
      return ResponseEntity.ok(response);
    } catch (Exception e) {
      e.printStackTrace();
      response.put("errorMessage", "Failed to update order status");
      return ResponseEntity.badRequest().body(response);
    }
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
