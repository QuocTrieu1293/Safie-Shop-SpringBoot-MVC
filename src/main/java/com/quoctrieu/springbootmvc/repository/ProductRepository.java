package com.quoctrieu.springbootmvc.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.quoctrieu.springbootmvc.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
  Product save(Product product);

  List<Product> findByDeletedFalse();

  Optional<Product> findByIdAndDeletedFalse(Long id);

  boolean existsByNameAndIdNotAndDeletedFalse(String name, Long id);

  boolean existsByNameAndDeletedFalse(String name);

  void deleteById(Long id);

  List<Product> findByCategoryIdAndIdNotAndDeletedFalse(Long categoryId, Long id);

  List<Product> findTop5ByIdNotAndDeletedFalseOrderByQuantityDesc(Long id);

  Page<Product> findAll(Pageable pageable);

  Page<Product> findAll(Specification<Product> spec, Pageable pageable);

  // @Query("select p from Product p where lower(p.name) like lower(concat('%',
  // :name, '%'))")
  Page<Product> findByNameContainingAndDeletedFalse(String name, Pageable pageable);

  List<Product> findTop3ByNameContainingAndDeletedFalseOrderByQuantityDesc(String name);

  Long countByDeletedFalse();

}
