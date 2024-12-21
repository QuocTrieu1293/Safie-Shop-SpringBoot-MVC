package vn.hoidanit.laptopshop.controller.client;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.CartDetailService;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class CartController {

  private final UserService userService;
  private final CartDetailService cartDetailService;
  private final CartService cartService;

  public CartController(UserService userService, CartDetailService cartDetailService, CartService cartService) {
    this.userService = userService;
    this.cartDetailService = cartDetailService;
    this.cartService = cartService;
  }

  @GetMapping("/cart")
  public String getCartDetailPage(HttpServletRequest request, Model model) {
    HttpSession session = request.getSession();

    if (session == null)
      return "redirect:/login";

    Long userId = (Long) session.getAttribute("userId");
    if (userId == null)
      return "redirect:/login";

    Cart cart = userService.getCart(userId);
    List<CartDetail> cartItems = cart.getCartDetails();

    model.addAttribute("cartItems", cartItems);
    model.addAttribute("totalPrice", cartService.getTotalPrice(cart.getId()));

    return "client/cart/show";
  }

  @PostMapping("/api/updateQuantity")
  public ResponseEntity<Map<String, Double>> updateQuantity(@RequestParam Long cartDetailId,
      @RequestParam int quantity, HttpServletRequest request) {

    Map<String, Double> map = new HashMap<>();
    HttpSession session = request.getSession();
    CartDetail item = cartDetailService.updateQuantity(cartDetailId, quantity, session);
    if (item != null) {
      map.put("quantity", (double) item.getQuantity());

      Product product = item.getProduct();
      map.put("cartDetailPrice", product.getPrice() * item.getQuantity());

      Cart cart = item.getCart();
      map.put("totalPrice", cartService.getTotalPrice(cart.getId()));

    } else {
      map.put("quantity", 0d);
      map.put("cartDetailPrice", 0d);
      map.put("totalPrice", 0d);
      map.put("totalPrice", cartService.getTotalPrice((long) session.getAttribute("cartId")));
    }

    // Không dùng trực tiếp kiểu Double được, buộc dùng Integer sau đó dùng
    // doubleValue() để chuyển đổi
    Integer cartSum = (Integer) session.getAttribute("cartSum");
    map.put("cartSum", cartSum.doubleValue());

    return ResponseEntity.ok(map);
  }

}
