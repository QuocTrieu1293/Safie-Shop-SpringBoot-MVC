package com.quoctrieu.springbootmvc.controller;

import java.util.Map;

import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quoctrieu.springbootmvc.domain.Category;
import com.quoctrieu.springbootmvc.repository.CategoryRepository;

@Controller
@RequestMapping("/test")
public class TestController {

  private final CacheManager cacheManager;
  private final CategoryRepository categoryRepository;

  public TestController(CacheManager cacheManager, CategoryRepository categoryRepository) {
    this.cacheManager = cacheManager;
    this.categoryRepository = categoryRepository;
  }

  @GetMapping("")
  public void getTestPage(Model model) throws RuntimeException {
    throw new RuntimeException("test error");
  }

  @GetMapping("/cache")
  @ResponseBody
  public Object getCache(@RequestParam String value) {
    Cache cache = cacheManager.getCache(value);
    return cache == null ? "not exist" : "exist";
  }

  @GetMapping("/cate")
  @ResponseBody
  public Category getCategory(@RequestParam Long id) {
    return categoryRepository.findById(id).orElse(null);
  }

  @GetMapping("/form")
  public String getTestForm() {
    return "testForm";
  }

  @PostMapping("/form")
  public String submitTestForm(String inputText, String[] multipleSelect) {

    // return "redirect:/test/form";
    return "testView";
  }

}
