package com.quoctrieu.springbootmvc.service;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.repository.CartDetailRepository;

@Service
public class CartDetailService {
  private final CartDetailRepository cartDetailRepository;

  public CartDetailService(CartDetailRepository cartDetailRepository) {
    this.cartDetailRepository = cartDetailRepository;
  }

  public CartDetail updateQuantity(long cartDetailId, int quantity, HttpSession session) {
    CartDetail item = cartDetailRepository.findById(cartDetailId).orElse(null);
    if (item.getProduct().isDeleted()) {
      return item;
    }
    if (item == null || quantity < 0)
      return null;

    int oldQuantity = item.getQuantity();
    item.setQuantity(quantity);
    item = cartDetailRepository.save(item);
    Cart cart = item.getCart();
    cart.setSum(cart.getSum() - oldQuantity + quantity);
    if (session != null) {
      int cartSum = (int) session.getAttribute("cartSum");
      session.setAttribute("cartSum", cartSum - oldQuantity + quantity);
    }

    if (quantity == 0) {
      cartDetailRepository.deleteById(cartDetailId);
      return null;
    }

    return item;

  }

}
