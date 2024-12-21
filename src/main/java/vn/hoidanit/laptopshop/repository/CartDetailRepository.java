package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Size;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {

  CartDetail save(CartDetail cartDetail);

  CartDetail findByCartAndProductAndSize(Cart cart, Product product, Size size);

  void delete(CartDetail cartDetail);

}
