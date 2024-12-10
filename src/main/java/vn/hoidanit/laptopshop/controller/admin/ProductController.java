package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.BrandService;
import vn.hoidanit.laptopshop.service.CategoryService;
import vn.hoidanit.laptopshop.service.SizeService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("adminProductController")
public class ProductController {

  private final CategoryService categoryService;
  private final BrandService brandService;
  private final SizeService sizeService;

  public ProductController(CategoryService categoryService, BrandService brandService, SizeService sizeService) {
    this.categoryService = categoryService;
    this.brandService = brandService;
    this.sizeService = sizeService;
  }

  @GetMapping("/admin/product")
  public String getProductPage() {
    return "admin/product/show";
  }

  @GetMapping("/admin/product/create")
  public String getCreateProductPage(Model model) {

    model.addAttribute("newProduct", new Product());
    model.addAttribute("categories", categoryService.getAll());
    model.addAttribute("brands", brandService.getAll());
    model.addAttribute("sizes", sizeService.getAll());

    return "admin/product/create";
  }

  @PostMapping("/admin/product/create")
  public String postMethodName(@ModelAttribute("newProduct") Product product, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("successMessage", "Product created successfully!");
    return "redirect:/admin/product";
  }

}
