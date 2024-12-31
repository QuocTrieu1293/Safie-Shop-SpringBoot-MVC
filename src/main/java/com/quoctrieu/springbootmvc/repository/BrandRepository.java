package com.quoctrieu.springbootmvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.quoctrieu.springbootmvc.domain.Brand;

@Repository
public interface BrandRepository extends JpaRepository<Brand, Long> {
  List<Brand> findAll();
}
