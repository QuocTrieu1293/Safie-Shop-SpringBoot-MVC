package com.quoctrieu.springbootmvc.controller.client;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.dto.CheckoutDTO;
import com.quoctrieu.springbootmvc.domain.dto.OrderCriteriaDTO;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.service.CartService;
import com.quoctrieu.springbootmvc.service.OrderService;
import com.quoctrieu.springbootmvc.service.VNPayService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller("ClientOrderController")
public class OrderController {

  private final CartService cartService;
  private final OrderRepository orderRepository;
  private final OrderService orderService;
  private final VNPayService vNPayService;

  public OrderController(CartService cartService, OrderRepository orderRepository,
      OrderService orderService, VNPayService vnPayService) {
    this.cartService = cartService;
    this.orderRepository = orderRepository;
    this.orderService = orderService;
    this.vNPayService = vnPayService;
  }

  @GetMapping("/checkout")
  public String getCheckoutPage(HttpServletRequest request, Model model) {
    HttpSession session = request.getSession(false);
    long cartId = (long) session.getAttribute("cartId");
    Cart cart = cartService.get(cartId);

    model.addAttribute("cart", cart);
    model.addAttribute("totalPrice", cartService.getTotalPrice(cart.getId()));
    model.addAttribute("checkoutDTO", new CheckoutDTO());

    return "client/cart/checkout";
  }

  @PostMapping("/checkout")
  public String handleCheckout(@ModelAttribute CheckoutDTO checkoutDTO, HttpServletRequest request)
      throws UnsupportedEncodingException {

    HttpSession session = request.getSession(false);
    long cartId = (long) session.getAttribute("cartId");

    Order newOrder = orderService.create(cartId, checkoutDTO);
    session.setAttribute("cartSum", 0);

    if (!newOrder.getPaymentMethod().equals("COD")) {
      String ip = this.vNPayService.getIpAddress(request);
      String vnpUrl = this.vNPayService.generateVNPayURL(newOrder.getTotalPrice(), newOrder.getPaymentRef(), ip,
          newOrder.getId());

      return "redirect:" + vnpUrl;
    }

    return "redirect:/thankyou?order=" + newOrder.getId();
  }

  @GetMapping("/thankyou")
  public String getMethodName(@RequestParam("order") long orderId, Model model,
      @RequestParam Optional<String> vnp_ResponseCode,
      @RequestParam Optional<String> vnp_TxnRef) {

    if (vnp_ResponseCode.isPresent() && vnp_TxnRef.isPresent()) {
      String paymentRef = vnp_TxnRef.get();
      String responseCode = vnp_ResponseCode.get();
      String paymentStatus = responseCode.equals("00") ? "PAYMENT_SUCCEED" : "PAYMENT_FAILED";
      Order order = orderRepository.findByPaymentRef(paymentRef);
      if (order != null) {
        order.setPaymentStatus(paymentStatus);
        orderRepository.save(order);
      }
    }

    model.addAttribute("orderId", orderId);

    return "client/cart/thankyou";
  }

  @GetMapping("/profile/order-history")
  public String getOrderHistoryPage(Model model, OrderCriteriaDTO orderCriteria, HttpServletRequest request) {

    HttpSession session = request.getSession(false);
    long userId = (long) session.getAttribute("userId");
    orderCriteria.setUserId(userId);
    orderCriteria.setPageSize(3);

    Page<Order> pagedOrder = orderService.getPageWithSpec(orderCriteria);
    List<Order> orders = pagedOrder.getContent();
    model.addAttribute("orders", orders);
    model.addAttribute("totalPages", pagedOrder.getTotalPages());
    model.addAttribute("currentPage", pagedOrder.getNumber() + 1);

    String queryString = request.getQueryString();
    if (queryString != null) {
      queryString = queryString.replace("page=" + (pagedOrder.getNumber() + 1), "");
      if (!queryString.isBlank() && !queryString.startsWith("&"))
        queryString = "&" + queryString;
    }
    model.addAttribute("queryString", queryString);

    return "client/profile/orderHistory";
  }

}
