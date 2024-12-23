package vn.hoidanit.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
  Order save(Order order);

  List<Order> findByUserId(long userId);

  Order findByPaymentRef(String paymentRef);

  @Query("select o from Order o where cast(o.id as string) = :keyword or exists("
      + "select od from o.orderDetails od where lower(od.product.name) like lower(concat('%', :keyword ,'%'))" + ")")
  List<Order> searchByKeyword(@Param("keyword") String keyword);
}
