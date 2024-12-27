package vn.hoidanit.laptopshop.specification;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import vn.hoidanit.laptopshop.domain.Brand_;
import vn.hoidanit.laptopshop.domain.Category_;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;
import vn.hoidanit.laptopshop.domain.Size;
import vn.hoidanit.laptopshop.domain.Size_;

public class ProductSpecs {
    public static Specification<Product> filterBy(String categoryName, String[] brandNames, Double minPrice,
            Double maxPrice, String[] sizeNames) {

        return (root, query, criteriaBuilder) -> {
            query.distinct(true);

            List<Predicate> predicates = new ArrayList<>();

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

            return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
        };
    }
}
