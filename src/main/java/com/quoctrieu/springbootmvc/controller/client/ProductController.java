package com.quoctrieu.springbootmvc.controller.client;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.quoctrieu.springbootmvc.domain.Category;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.dto.ProductCriteriaDTO;
import com.quoctrieu.springbootmvc.repository.BrandRepository;
import com.quoctrieu.springbootmvc.repository.CategoryRepository;
import com.quoctrieu.springbootmvc.repository.ProductRepository;
import com.quoctrieu.springbootmvc.repository.SizeRepository;
import com.quoctrieu.springbootmvc.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;

@Controller("clientProductController")
public class ProductController {

  private final ProductService productService;
  private final SizeRepository sizeRepository;
  private final ProductRepository productRepository;
  private final CategoryRepository categoryRepository;
  private final BrandRepository brandRepository;

  ProductController(ProductService productService, SizeRepository sizeRepository,
      ProductRepository productRepository, CategoryRepository categoryRepository, BrandRepository brandRepository) {
    this.productService = productService;
    this.sizeRepository = sizeRepository;
    this.productRepository = productRepository;
    this.categoryRepository = categoryRepository;
    this.brandRepository = brandRepository;

  }

  @GetMapping("/products")
  public String getProductPage(Model model, ProductCriteriaDTO productCriteria, HttpServletRequest request) {

    Page<Product> pagedProduct = productService.getPageWithSpec(productCriteria);
    model.addAttribute("products", pagedProduct.getContent());
    model.addAttribute("totalPages", pagedProduct.getTotalPages());
    model.addAttribute("currentPage", pagedProduct.getNumber() + 1);
    model.addAttribute("totalProducts", pagedProduct.getTotalElements());

    model.addAttribute("categories", categoryRepository.findAll());
    model.addAttribute("brands", brandRepository.findAll());
    model.addAttribute("sizes", sizeRepository.findAll());

    String queryString = request.getQueryString();
    if (queryString != null) {
      queryString = queryString.replace("page=" + (pagedProduct.getNumber() + 1), "");
      if (!queryString.isBlank() && !queryString.startsWith("&"))
        queryString = "&" + queryString;
    }
    model.addAttribute("queryString", queryString);

    return "client/product/show";
  }

  @GetMapping("/product/{id}")
  public String getProductDetailPage(@PathVariable long id, Model model) {
    Product product = productService.get(id);
    Category category = product.getCategory();
    Long cateId = category.getId();
    List<Product> featuredProducts = productRepository.findTop5ByIdNotOrderByQuantityDesc(id);
    model.addAttribute("product", product);
    model.addAttribute("relatedProducts",
        productRepository.findByCategoryIdAndIdNot(cateId, id));
    model.addAttribute("featuredProducts", featuredProducts);
    model.addAttribute("categories", categoryRepository.findAll());

    return "client/product/detail";
  }

}
