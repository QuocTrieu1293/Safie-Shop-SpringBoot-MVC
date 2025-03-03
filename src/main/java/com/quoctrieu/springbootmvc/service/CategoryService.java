package com.quoctrieu.springbootmvc.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Category;
import com.quoctrieu.springbootmvc.repository.CategoryRepository;

@Service
public class CategoryService {
  public static final String CACHE_NAME = "categories";
  private final CategoryRepository repo;

  public CategoryService(CategoryRepository repo) {
    this.repo = repo;
  }

  @Cacheable(value = CACHE_NAME, key = "'all'")
  public List<Category> findAll() {
    List<Category> categories = repo.findAll();

    List<Object[]> productsCnt = repo.countProductsByCategory();
    Map<Long, Long> productsCntMap = productsCnt.stream()
        .collect(Collectors.toMap(object -> (Long) object[0], object -> (Long) object[1]));

    categories.forEach(cate -> cate.setProductCount(productsCntMap.get(cate.getId())));

    return categories;
  }

}
