package com.quoctrieu.springbootmvc.controller.api;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.service.CartDetailService;
import com.quoctrieu.springbootmvc.service.CartService;

@RestController
@RequestMapping("/api/cart")
public class CartAPI {
  private final CartDetailService cartDetailService;
  private final CartService cartService;

  public CartAPI(CartDetailService cartDetailService, CartService cartService) {
    this.cartDetailService = cartDetailService;
    this.cartService = cartService;
  }

  @PostMapping("/update-quantity")
  public ResponseEntity<Map<String, Object>> updateQuantity(@RequestParam Long cartDetailId,
      @RequestParam int quantity, HttpServletRequest request) {

    Map<String, Object> map = new HashMap<>();
    HttpSession session = request.getSession(false);
    CartDetail item = cartDetailService.updateQuantity(cartDetailId, quantity, session);
    if (item != null) {
      map.put("quantity", item.getQuantity());

      Product product = item.getProduct();
      map.put("cartDetailPrice", product.getPrice() * item.getQuantity());

      Cart cart = item.getCart();
      map.put("totalPrice", cartService.getTotalPrice(cart.getId()));

    } else {
      map.put("quantity", 0);
      map.put("cartDetailPrice", 0);
      map.put("totalPrice", 0);
      map.put("totalPrice", cartService.getTotalPrice((long) session.getAttribute("cartId")));
    }

    // Không dùng trực tiếp kiểu Double được, buộc dùng Integer sau đó dùng
    // doubleValue() để chuyển đổi
    Integer cartSum = (Integer) session.getAttribute("cartSum");
    // map.put("cartSum", cartSum.doubleValue());
    map.put("cartSum", cartSum);

    return ResponseEntity.ok(map);
  }
}
