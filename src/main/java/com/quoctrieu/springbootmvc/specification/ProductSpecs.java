package com.quoctrieu.springbootmvc.specification;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import com.quoctrieu.springbootmvc.domain.Brand_;
import com.quoctrieu.springbootmvc.domain.Category_;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.Product_;
import com.quoctrieu.springbootmvc.domain.Size;
import com.quoctrieu.springbootmvc.domain.Size_;

public class ProductSpecs {
    public static Specification<Product> filterBy(String categoryName, String[] brandNames, Double minPrice,
            Double maxPrice, String[] sizeNames, String search) {

        return (root, query, criteriaBuilder) -> {
            query.distinct(true); // Do Product có join Sizes và mqh là 1 - n

            List<Predicate> predicates = new ArrayList<>();

            predicates.add(criteriaBuilder.isFalse(root.get(Product_.DELETED)));

            if (categoryName != null) {
                predicates.add(criteriaBuilder.equal(root.get(Product_.CATEGORY).get(Category_.NAME), categoryName));
            }

            if (brandNames != null && brandNames.length > 0) {
                predicates
                        .add(criteriaBuilder.in(root.get(Product_.BRAND).get(Brand_.NAME)).value(List.of(brandNames)));
            }

            if (minPrice != null) {
                predicates.add(criteriaBuilder.ge(root.get(Product_.PRICE), minPrice));
            }

            if (maxPrice != null) {
                predicates.add(criteriaBuilder.le(root.get(Product_.PRICE), maxPrice));
            }

            if (sizeNames != null && sizeNames.length > 0) {
                Join<Product, Size> sizeJoin = root.join(Product_.SIZES);
                predicates.add(criteriaBuilder.in(sizeJoin.get(Size_.NAME)).value(List.of(sizeNames)));
            }

            if (search != null && !search.isBlank()) {
                String likeSearch = "%" + search.toLowerCase().trim() + "%";
                predicates.add(
                        criteriaBuilder.or(
                                criteriaBuilder.equal(
                                        criteriaBuilder.concat("#", root.get(Product_.ID).as(String.class)),
                                        search.trim()),
                                criteriaBuilder.like(criteriaBuilder.lower(root.get(Product_.NAME)), likeSearch)));
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
        };
    }
}
