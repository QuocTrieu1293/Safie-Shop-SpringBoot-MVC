package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.repository.CartRepository;

@Service
public class CartService {
  private final CartRepository cartRepository;

  public CartService(CartRepository cartRepository) {
    this.cartRepository = cartRepository;
  }

  public Cart get(long id) {
    return cartRepository.findById(id).orElse(null);
  }

  public double getTotalPrice(long cartId) {
    Cart cart = cartRepository.findById(cartId).orElse(null);
    if (cart == null)
      return 0;

    List<CartDetail> items = cart.getCartDetails();
    if (items == null)
      return 0;

    double total = 0;
    for (CartDetail item : items) {
      // Product product = item.getProduct();
      // total += product.getPrice() * item.getQuantity();
      total += item.getPrice();
    }

    return total;
  }
}
