package com.quoctrieu.springbootmvc.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.service.CartService;
import com.quoctrieu.springbootmvc.service.UserService;

@Controller
public class CartController {

  private final UserService userService;
  private final CartService cartService;

  public CartController(UserService userService, CartService cartService) {
    this.userService = userService;
    this.cartService = cartService;
  }

  @GetMapping("/cart")
  public String getCartDetailPage(HttpServletRequest request, Model model) {

    HttpSession session = request.getSession(false);
    Long userId = (Long) session.getAttribute("userId");

    Cart cart = userService.getCart(userId);
    session.setAttribute("cartSum", cart.getSum());

    List<CartDetail> cartItems = cart.getCartDetails();

    model.addAttribute("cartItems", cartItems);
    model.addAttribute("totalPrice", cartService.getTotalPrice(cart.getId()));

    return "client/cart/show";
  }

}
