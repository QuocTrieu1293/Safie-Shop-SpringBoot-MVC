package com.quoctrieu.springbootmvc.specification;

import org.springframework.data.jpa.domain.Specification;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.User_;

public class UserSpecs {
  public static Specification<User> getBySearch(String search) {
    return (root, query, criteriaBuilder) -> {

      if (search == null || search.isBlank())
        return criteriaBuilder.conjunction();

      String likeSearch = "%" + search.trim().toLowerCase() + "%";
      return criteriaBuilder.or(
          criteriaBuilder.equal(criteriaBuilder.concat("#", root.get(User_.ID).as(String.class)), search.trim()),
          criteriaBuilder.like(criteriaBuilder.lower(root.get(User_.FULL_NAME)), likeSearch),
          criteriaBuilder.like(criteriaBuilder.lower(root.get(User_.EMAIL)), likeSearch));
    };

  }
}
