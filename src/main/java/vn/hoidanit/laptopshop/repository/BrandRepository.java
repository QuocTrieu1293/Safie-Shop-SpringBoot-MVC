package vn.hoidanit.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Brand;

@Repository
public interface BrandRepository extends JpaRepository<Brand, Long> {
  List<Brand> findAll();
}
