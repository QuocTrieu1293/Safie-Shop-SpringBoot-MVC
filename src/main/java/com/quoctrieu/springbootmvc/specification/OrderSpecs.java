package com.quoctrieu.springbootmvc.specification;

import java.time.LocalDateTime;

import org.springframework.data.jpa.domain.Specification;

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.OrderDetail;
import com.quoctrieu.springbootmvc.domain.OrderDetail_;
import com.quoctrieu.springbootmvc.domain.Order_;
import com.quoctrieu.springbootmvc.domain.Product_;
import com.quoctrieu.springbootmvc.domain.User_;

import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;

public class OrderSpecs {

  public static Specification<Order> getByUser(Long userId) {
    return (root, query, criteriaBuilder) -> {
      if (userId == null)
        return criteriaBuilder.conjunction();

      return criteriaBuilder.equal(root.get(Order_.USER).get(User_.ID), userId);
    };
  }

  public static Specification<Order> getBySearch(String search) {
    return (root, query, criteriaBuilder) -> {
      if (search == null || search.isBlank())
        return criteriaBuilder.conjunction();

      query.distinct(true);

      Join<Order, OrderDetail> orderDetailJoin = root.join(Order_.ORDER_DETAILS);
      String likeSearch = "%" + search.toLowerCase().trim() + "%";

      return criteriaBuilder
          .or(criteriaBuilder.equal(criteriaBuilder.concat("#", root.get(Order_.ID).as(String.class)), search.trim()),
              criteriaBuilder.like(criteriaBuilder.lower(orderDetailJoin.get(OrderDetail_.PRODUCT).get(Product_.NAME)),
                  likeSearch),
              criteriaBuilder.like(criteriaBuilder.lower(root.get(Order_.USER).get(User_.FULL_NAME)),
                  likeSearch));
    };
  }

  public static Specification<Order> getByStatus(String status) {

    return (root, query, criteriaBuilder) -> {
      if (status == null || status.toLowerCase().equals("all"))
        return criteriaBuilder.conjunction();

      return criteriaBuilder.equal(root.get(Order_.STATUS), status);
    };
  }

  public static Specification<Order> getByDateBetween(LocalDateTime startDate, LocalDateTime endDate) {

    return (root, query, criteriaBuilder) -> {
      Predicate pre = criteriaBuilder.conjunction();
      if (startDate != null)
        pre = criteriaBuilder.and(pre,
            criteriaBuilder.greaterThanOrEqualTo(root.get(Order_.DATE), startDate));
      if (endDate != null)
        pre = criteriaBuilder.and(pre,
            criteriaBuilder.lessThanOrEqualTo(root.get(Order_.DATE), endDate));
      return pre;
    };

  }

}
