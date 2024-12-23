package vn.hoidanit.laptopshop.controller.client;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.dto.CheckoutDTO;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.OrderService;
import vn.hoidanit.laptopshop.service.UserService;
import vn.hoidanit.laptopshop.service.VNPayService;

@Controller("clientOrderController")
public class OrderController {

  private final CartService cartService;
  private final OrderRepository orderRepository;
  private final OrderService orderService;
  private final VNPayService vNPayService;
  private final UserService userService;

  public OrderController(CartService cartService, OrderRepository orderRepository,
      OrderService orderService, VNPayService vnPayService, UserService userService) {
    this.cartService = cartService;
    this.orderRepository = orderRepository;
    this.orderService = orderService;
    this.vNPayService = vnPayService;
    this.userService = userService;
  }

  @GetMapping("/checkout")
  public String getCheckoutPage(HttpServletRequest request, Model model) {
    HttpSession session = request.getSession();
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

    HttpSession session = request.getSession();
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
      String reponseCode = vnp_ResponseCode.get();
      String paymentStatus = reponseCode.equals("00") ? "PAYMENT_SUCCEED" : "PAYMENT_FAILED";
      Order order = orderRepository.findByPaymentRef(paymentRef);
      if (order != null) {
        order.setPaymentStatus(paymentStatus);
        orderRepository.save(order);
      }
    }

    model.addAttribute("orderId", orderId);

    return "client/cart/thankyou";
  }

  @GetMapping("/order-history")
  public String getOrderHistoryPage(Model model, HttpServletRequest request) {

    HttpSession session = request.getSession();
    long userId = (long) session.getAttribute("userId");

    List<Order> orders = userService.getOrders(userId);
    model.addAttribute("orders", orders);

    return "client/order/history";
  }

  @GetMapping("/api/order/search")
  public ResponseEntity<List<Long>> getOrderBySearch(@RequestParam String keyword) {

    List<Order> orders = orderRepository.searchByKeyword(keyword);
    List<Long> orderIds = orders.stream().map(order -> order.getId()).toList();

    return ResponseEntity.ok(orderIds);
  }

}
