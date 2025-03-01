package com.quoctrieu.springbootmvc.service;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Category;
import com.quoctrieu.springbootmvc.repository.CategoryRepository;

@Service
public class CategoryService {
  private final String CACHE_NAME = "categories";
  private final CategoryRepository repo;

  public CategoryService(CategoryRepository repo) {
    this.repo = repo;
  }

  @Cacheable(value = CACHE_NAME, key = "'all'")
  public List<Category> findAll() {
    List<Category> categories = repo.findAll();
    return categories;
  }

}
