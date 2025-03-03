package com.quoctrieu.springbootmvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.quoctrieu.springbootmvc.domain.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
  List<Category> findAll();

  @Query("select c.id, count(p) from Category c left join c.products p where p.deleted = false group by c.id")
  List<Object[]> countProductsByCategory();
}
