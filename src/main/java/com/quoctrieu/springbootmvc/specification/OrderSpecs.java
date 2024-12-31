package com.quoctrieu.springbootmvc.specification;

import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Join;
import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.OrderDetail;
import com.quoctrieu.springbootmvc.domain.OrderDetail_;
import com.quoctrieu.springbootmvc.domain.Order_;
import com.quoctrieu.springbootmvc.domain.Product_;
import com.quoctrieu.springbootmvc.domain.User_;

public class OrderSpecs {

  public static Specification<Order> getByUser(Long userId) {
    if (userId == null)
      return null;

    return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Order_.USER).get(User_.ID), userId);
  }

  public static Specification<Order> getBySearch(String search) {
    if (search == null || search.isBlank())
      return null;

    return (root, query, criteriaBuilder) -> {
      query.distinct(true);

      Join<Order, OrderDetail> orderDetailJoin = root.join(Order_.ORDER_DETAILS);

      return criteriaBuilder
          .or(criteriaBuilder.equal(criteriaBuilder.concat("#", root.get(Order_.ID).as(String.class)), search),
              criteriaBuilder.like(criteriaBuilder.lower(orderDetailJoin.get(OrderDetail_.PRODUCT).get(Product_.NAME)),
                  "%" + search.toLowerCase() + "%"));
    };
  }

  public static Specification<Order> getByStatus(String status) {
    if (status == null)
      return null;

    return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Order_.STATUS), status);
  }

}
