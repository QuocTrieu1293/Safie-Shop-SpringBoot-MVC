package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Brand;
import vn.hoidanit.laptopshop.repository.BrandRepository;

@Service
public class BrandService {
  private final BrandRepository repo;

  public BrandService(BrandRepository repo) {
    this.repo = repo;
  }

  public List<Brand> getAll() {
    return repo.findAll();
  }
}
