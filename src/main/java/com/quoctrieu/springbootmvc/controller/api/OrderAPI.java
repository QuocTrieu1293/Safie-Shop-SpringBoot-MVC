package com.quoctrieu.springbootmvc.controller.api;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.service.MailService;

@RestController
@RequestMapping("/api/order")
public class OrderAPI {
  private final OrderRepository orderRepository;
  private final MailService mailService;

  public OrderAPI(OrderRepository orderRepository, MailService mailService) {
    this.orderRepository = orderRepository;
    this.mailService = mailService;
  }

  @PostMapping("/update")
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

  @PostMapping("/sendVerifyMail")
  public String sendVerifyMail(@RequestBody Map<String, Object> body) {

    try {
      String email = (String) body.get("email");
      Long orderId = Long.parseLong((String) body.get("orderId"));
      Order order = orderRepository.findById(orderId).orElse(null);
      if (order == null || email == null) {
        return "Mail not sent";
      }
      mailService.sendVerifyOrderMail(order);
    } catch (Exception e) {
      e.printStackTrace();
      return "Mail not sent";
    }
    return "Mail sent";
  }
}
