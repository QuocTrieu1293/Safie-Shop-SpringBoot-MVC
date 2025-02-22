package com.quoctrieu.springbootmvc.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.dto.OrderCriteriaDTO;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.service.OrderService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class OrderController {
  private final OrderRepository orderRepository;
  private final OrderService orderService;

  OrderController(OrderRepository orderRepository, OrderService orderService) {
    this.orderRepository = orderRepository;
    this.orderService = orderService;
  }

  @GetMapping("/admin/order")
  public String getOrderPage(Model model, OrderCriteriaDTO orderCriteria, HttpServletRequest request) {
    orderCriteria.setPageSize(4);

    Page<Order> pagedOrder = orderService.getPageWithSpec(orderCriteria);
    List<Order> orders = pagedOrder.getContent();
    model.addAttribute("orders", orders);
    model.addAttribute("totalPages", pagedOrder.getTotalPages());
    model.addAttribute("currentPage", pagedOrder.getNumber() + 1);
    model.addAttribute("totalOrders", pagedOrder.getTotalElements());

    String queryString = request.getQueryString();
    if (queryString != null) {
      queryString = queryString.replace("page=" + orderCriteria.getPage(), "");
      if (!queryString.isBlank() && !queryString.startsWith("&"))
        queryString = "&" + queryString;
    }
    model.addAttribute("queryString", queryString);

    return "/admin/order/show";
  }

  @GetMapping("/admin/order/{id}")
  public String getOrderDetailPage(@PathVariable long id, Model model) {

    Order order = orderRepository.findById(id).orElse(null);

    model.addAttribute("order", order);

    return "/admin/order/detail";
  }

  @GetMapping("/admin/order/delete/{id}")
  public String getDeleteOrderPage(@PathVariable long id, Model model) {

    Order order = orderRepository.findById(id).orElse(null);

    model.addAttribute("order", order);

    return "/admin/order/delete";
  }

  @PostMapping("/admin/order/delete/{id}")
  public String deleteOrder(@PathVariable long id, Model model, RedirectAttributes redirectAttributes) {

    orderService.delete(id);
    redirectAttributes.addFlashAttribute("successMessage", "Order deleted successfully!");

    return "redirect:/admin/order";
  }

}
