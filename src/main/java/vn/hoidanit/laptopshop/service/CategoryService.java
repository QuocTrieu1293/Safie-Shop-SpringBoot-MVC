package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Category;
import vn.hoidanit.laptopshop.repository.CategoryRepository;

@Service
public class CategoryService {
  private final CategoryRepository repo;

  public CategoryService(CategoryRepository repo) {
    this.repo = repo;
  }

  public List<Category> getAll() {
    return repo.findAll();
  }
}
