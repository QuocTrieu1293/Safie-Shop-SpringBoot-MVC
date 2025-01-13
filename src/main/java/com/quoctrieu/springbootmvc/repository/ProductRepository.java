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

  List<Product> findAll();

  Optional<Product> findById(Long id);

  boolean existsByNameAndIdNot(String name, Long id);

  boolean existsByName(String name);

  void deleteById(Long id);

  List<Product> findByCategoryIdAndIdNot(Long categoryId, Long id);

  List<Product> findTop5ByIdNotOrderByQuantityDesc(Long id);

  Page<Product> findAll(Pageable pageable);

  Page<Product> findAll(Specification<Product> spec, Pageable pageable);

}
