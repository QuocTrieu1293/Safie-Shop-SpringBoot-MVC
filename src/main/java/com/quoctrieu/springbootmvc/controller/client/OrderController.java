package com.quoctrieu.springbootmvc.controller.client;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.Page;
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

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.Order.PaymentMethod;
import com.quoctrieu.springbootmvc.domain.dto.AddressDTO;
import com.quoctrieu.springbootmvc.domain.dto.CheckoutDTO;
import com.quoctrieu.springbootmvc.domain.dto.OrderCriteriaDTO;
import com.quoctrieu.springbootmvc.repository.OrderRepository;
import com.quoctrieu.springbootmvc.service.AddressService;
import com.quoctrieu.springbootmvc.service.CartService;
import com.quoctrieu.springbootmvc.service.MailService;
import com.quoctrieu.springbootmvc.service.OrderService;
import com.quoctrieu.springbootmvc.service.VNPayService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller("ClientOrderController")
public class OrderController {

  private final CartService cartService;
  private final OrderRepository orderRepository;
  private final OrderService orderService;
  private final VNPayService vNPayService;
  private final MailService mailService;
  private final AddressService addressService;

  public OrderController(CartService cartService, OrderRepository orderRepository,
      OrderService orderService, VNPayService vnPayService, MailService mailService, AddressService addressService) {
    this.cartService = cartService;
    this.orderRepository = orderRepository;
    this.orderService = orderService;
    this.vNPayService = vnPayService;
    this.mailService = mailService;
    this.addressService = addressService;
  }

  @InitBinder
  void initBinder(WebDataBinder binder) {
    binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
  }

  @GetMapping("/checkout")
  public String getCheckoutPage(HttpSession session, Model model) {
    long cartId = (long) session.getAttribute("cartId");
    long userId = (long) session.getAttribute("userId");
    Cart cart = cartService.get(cartId);
    double totalPrice = cartService.getTotalPrice(cartId);
    List<AddressDTO> receiveInfos = addressService.findByUser(userId);
    CheckoutDTO checkoutDTO = new CheckoutDTO(receiveInfos != null ? receiveInfos.get(0) : null);

    model.addAttribute("cart", cart);
    model.addAttribute("totalPrice", totalPrice);
    model.addAttribute("checkoutDTO", checkoutDTO);
    model.addAttribute("receiveInfos", receiveInfos);

    return "client/cart/checkout";
  }

  @PostMapping("/checkout")
  public String handleCheckout(@Valid @ModelAttribute CheckoutDTO checkoutDTO, BindingResult bindingResult,
      HttpServletRequest request, Model model, RedirectAttributes redirectAttributes)
      throws UnsupportedEncodingException {

    HttpSession session = request.getSession(false);
    long cartId = (long) session.getAttribute("cartId");

    if (bindingResult.hasErrors()) {
      String errorMessage = null;
      for (FieldError error : bindingResult.getFieldErrors()) {
        System.out.println(">>> ERR handleCheckout: " + error.getField() + " - " + error.getDefaultMessage());
        if (error.getField().equals("receiveInfo.cityId") || error.getField().equals("receiveInfo.districtId")
            || error.getField().equals("receiveInfo.wardId")) {
          errorMessage = "Có lỗi xảy ra, vui lòng thử lại!";
        }
      }

      Cart cart = cartService.get(cartId);
      double totalPrice = cartService.getTotalPrice(cartId);
      model.addAttribute("cart", cart);
      model.addAttribute("totalPrice", totalPrice);
      if (errorMessage != null)
        model.addAttribute("errorMessage", errorMessage);

      return "client/cart/checkout";
    }

    Order newOrder = orderService.create(cartId, checkoutDTO);
    session.setAttribute("cartSum", 0);

    String email = (String) session.getAttribute("email");
    redirectAttributes.addFlashAttribute("email", email);
    redirectAttributes.addFlashAttribute("orderId", newOrder.getId());

    if (newOrder.getPaymentMethod() == PaymentMethod.VNPAY) {
      String ip = this.vNPayService.getIpAddress(request);
      String vnpUrl = this.vNPayService.generateVNPayURL(newOrder.getTotalPrice(),
          newOrder.getPaymentRef(), ip,
          newOrder.getId());

      return "redirect:" + vnpUrl;
    }

    return "redirect:/thankyou";
  }

  @GetMapping("/thankyou")
  public String getThankYouPage(@RequestParam Optional<String> vnp_ResponseCode,
      @RequestParam Optional<String> vnp_TxnRef,
      RedirectAttributes redirectAttributes, HttpSession session) {

    if (vnp_ResponseCode.isPresent() && vnp_TxnRef.isPresent()) {
      String paymentRef = vnp_TxnRef.get();
      String responseCode = vnp_ResponseCode.get();
      String paymentStatus = responseCode.equals("00") ? "PAYMENT_SUCCEED" : "PAYMENT_FAILED";
      Order order = orderRepository.findByPaymentRef(paymentRef);
      if (order == null)
        return "redirect:/";
      order.setPaymentStatus(paymentStatus);
      order = orderRepository.save(order);
      String email = (String) session.getAttribute("email");
      redirectAttributes.addFlashAttribute("email", email);
      redirectAttributes.addFlashAttribute("orderId", order.getId());
      return "redirect:/thankyou";
    }

    // send verify order mail
    // try {
    // mailService.sendVerifyOrderMail(email, order);
    // } catch (Exception e) {
    // e.printStackTrace();
    // }

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
