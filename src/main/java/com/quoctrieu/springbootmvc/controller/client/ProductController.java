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
import com.quoctrieu.springbootmvc.service.BrandService;
import com.quoctrieu.springbootmvc.service.CategoryService;
import com.quoctrieu.springbootmvc.service.ProductService;
import com.quoctrieu.springbootmvc.service.SizeService;

import jakarta.servlet.http.HttpServletRequest;

@Controller("ClientProductController")
public class ProductController {

  private final ProductService productService;
  private final SizeService sizeService;
  private final CategoryService categoryService;
  private final BrandService brandService;

  ProductController(ProductService productService, SizeService sizeService,
      CategoryService categoryService, BrandService brandService) {
    this.productService = productService;
    this.sizeService = sizeService;
    this.categoryService = categoryService;
    this.brandService = brandService;

  }

  @GetMapping("/products")
  public String getProductPage(Model model, ProductCriteriaDTO productCriteria, HttpServletRequest request) {

    productCriteria.setPageSize(9);
    Page<Product> pagedProduct = productService.getPageWithSpec(productCriteria);
    model.addAttribute("products", pagedProduct.getContent());
    model.addAttribute("totalPages", pagedProduct.getTotalPages());
    model.addAttribute("currentPage", pagedProduct.getNumber() + 1);
    model.addAttribute("totalProducts", pagedProduct.getTotalElements());

    model.addAttribute("categories", categoryService.findAll());
    model.addAttribute("brands", brandService.findAll());
    model.addAttribute("sizes", sizeService.findAll());

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
    List<Product> featuredProducts = productService.findFeaturedProducts(id);
    model.addAttribute("product", product);
    model.addAttribute("relatedProducts",
        productService.findRelatedProducts(cateId, id));
    model.addAttribute("featuredProducts", featuredProducts);
    model.addAttribute("categories", categoryService.findAll());

    return "client/product/detail";
  }

}
