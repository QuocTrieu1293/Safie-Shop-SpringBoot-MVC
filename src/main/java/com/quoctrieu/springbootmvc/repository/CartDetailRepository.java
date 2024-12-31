package com.quoctrieu.springbootmvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.Size;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {

  CartDetail save(CartDetail cartDetail);

  CartDetail findByCartAndProductAndSize(Cart cart, Product product, Size size);

  void delete(CartDetail cartDetail);

}
