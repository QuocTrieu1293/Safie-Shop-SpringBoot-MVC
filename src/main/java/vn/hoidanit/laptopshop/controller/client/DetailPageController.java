package vn.hoidanit.laptopshop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttributes;

import vn.hoidanit.laptopshop.domain.Category;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.repository.CategoryRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.service.ProductService;

@Controller
@SessionAttributes("categories")
public class DetailPageController {

  private final ProductService productService;
  private final ProductRepository productRepository;
  private final CategoryRepository categoryRepository;

  @ModelAttribute("categories")
  public List<Category> populateCategories() {
    return categoryRepository.findAll();
  }

  public DetailPageController(ProductService productService, ProductRepository productRepository,
      CategoryRepository categoryRepository) {
    this.productService = productService;
    this.productRepository = productRepository;
    this.categoryRepository = categoryRepository;
  }

  @GetMapping("/product/{id}")
  public String getProductPage(@PathVariable long id, Model model) {
    Product product = productService.get(id);
    Category category = product.getCategory();
    Long cateId = category.getId();
    List<Product> featuredProducts = productRepository.findTop5ByIdNotOrderByQuantityDesc(id);
    model.addAttribute("product", product);
    model.addAttribute("relatedProducts",
        productRepository.findByCategoryIdAndIdNot(cateId, id));
    model.addAttribute("featuredProducts", featuredProducts);

    return "client/product/detail";
  }

}
