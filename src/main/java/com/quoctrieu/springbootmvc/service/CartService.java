package com.quoctrieu.springbootmvc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.repository.CartRepository;

@Service
public class CartService {
  private final CartRepository cartRepository;

  public CartService(CartRepository cartRepository) {
    this.cartRepository = cartRepository;
  }

  public Cart get(long id) {
    Cart cart = cartRepository.findById(id).orElse(null);
    List<CartDetail> cartDetails = cart.getCartDetails();

    if (cart != null && cartDetails != null) {
      cartDetails.removeIf(cd -> cd.getProduct().isDeleted());
      cart.setSum(cartDetails.size());
    }

    return cart;
  }

  public double getTotalPrice(long cartId) {
    Cart cart = get(cartId);
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
