package com.quoctrieu.springbootmvc.service;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Brand;
import com.quoctrieu.springbootmvc.repository.BrandRepository;

@Service
public class BrandService {
  private final String CACHE_NAME = "brands";
  private final BrandRepository repo;

  public BrandService(BrandRepository repo) {
    this.repo = repo;
  }

  @Cacheable(value = CACHE_NAME, key = "'all'")
  public List<Brand> findAll() {
    List<Brand> brands = repo.findAll();
    return brands;
  }
}
