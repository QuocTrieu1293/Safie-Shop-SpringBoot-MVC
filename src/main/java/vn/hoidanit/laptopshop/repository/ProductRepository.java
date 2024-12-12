package vn.hoidanit.laptopshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Category;
import vn.hoidanit.laptopshop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
  Product save(Product product);

  List<Product> findAll();

  Optional<Product> findById(Long id);

  boolean existsByNameAndIdNot(String name, Long id);

  boolean existsByName(String name);

  void deleteById(Long id);

  List<Product> findByCategoryIdAndIdNot(Long categoryId, Long id);

  List<Product> findTop5ByIdNotOrderByQuantityDesc(Long id);

}
