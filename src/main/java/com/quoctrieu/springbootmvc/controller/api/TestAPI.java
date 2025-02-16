package com.quoctrieu.springbootmvc.controller.api;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.service.MailService;

@Controller
@RequestMapping("/api/test")
public class TestAPI {

  private final MailService mailService;
  private final OrderRepository orderRepository;

  public TestAPI(MailService mailService, OrderRepository orderRepository) {
    this.mailService = mailService;
    this.orderRepository = orderRepository;
  }

  @GetMapping("/sendMail")
  public String testSendMail(Model model) {

    Order order = orderRepository.findById(11l).orElse(null);
    model.addAttribute("order", order);

    return "template/verifyOrderMail";
  }

}
