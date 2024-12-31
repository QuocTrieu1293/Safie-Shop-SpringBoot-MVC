package com.quoctrieu.springbootmvc.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.quoctrieu.springbootmvc.domain.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
  Order save(Order order);

  List<Order> findByUserId(long userId);

  Order findByPaymentRef(String paymentRef);

  @Query("select o from Order o where concat('#', cast(o.id as string)) = :keyword or exists("
      + "select od from o.orderDetails od where lower(od.product.name) like lower(concat('%', :keyword ,'%'))" + ")")
  Page<Order> searchByKeyword(@Param("keyword") String keyword, Pageable pageable);

  Page<Order> findAll(Specification<Order> spec, Pageable pageable);

}
