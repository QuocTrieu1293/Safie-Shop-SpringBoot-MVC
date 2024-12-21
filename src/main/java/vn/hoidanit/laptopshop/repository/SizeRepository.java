package vn.hoidanit.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Size;

@Repository
public interface SizeRepository extends JpaRepository<Size, Long> {
  List<Size> findAll();

  Size findById(long id);
}
