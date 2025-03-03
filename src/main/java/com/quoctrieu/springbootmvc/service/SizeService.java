package com.quoctrieu.springbootmvc.service;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Size;
import com.quoctrieu.springbootmvc.repository.SizeRepository;

@Service
public class SizeService {
  public static final String CACHE_NAME = "sizes";
  private final SizeRepository repo;

  public SizeService(SizeRepository repo) {
    this.repo = repo;
  }

  @Cacheable(value = CACHE_NAME, key = "'all'")
  public List<Size> findAll() {
    List<Size> sizes = repo.findAll();
    return sizes;
  }

}
