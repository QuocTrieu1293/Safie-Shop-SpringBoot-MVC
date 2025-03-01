package com.quoctrieu.springbootmvc.controller.admin;

import java.util.List;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.Brand;
import com.quoctrieu.springbootmvc.domain.Category;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.Size;
import com.quoctrieu.springbootmvc.domain.dto.ProductCriteriaDTO;
import com.quoctrieu.springbootmvc.service.BrandService;
import com.quoctrieu.springbootmvc.service.CategoryService;
import com.quoctrieu.springbootmvc.service.FileService;
import com.quoctrieu.springbootmvc.service.FileService.Type;
import com.quoctrieu.springbootmvc.service.ProductService;
import com.quoctrieu.springbootmvc.service.SizeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller("adminProductController")
public class ProductController {

  private final ProductService productService;
  private final SizeService sizeService;
  private final CategoryService categoryService;
  private final BrandService brandService;
  private final FileService fileService;

  @InitBinder
  public void initBinder(WebDataBinder binder) {
    binder.registerCustomEditor(String.class, new StringTrimmerEditor(true)); // Converts "" to null
  }

  public ProductController(ProductService productService, SizeService sizeService,
      CategoryService categoryService,
      BrandService brandService,
      FileService fileService) {

    this.productService = productService;
    this.sizeService = sizeService;
    this.categoryService = categoryService;
    this.brandService = brandService;
    this.fileService = fileService;
  }

  @ModelAttribute("categories")
  public List<Category> populateCategories() {
    return categoryService.findAll();
  }

  @ModelAttribute("brands")
  public List<Brand> populateBrand() {
    return brandService.findAll();
  }

  @ModelAttribute("sizes")
  public List<Size> populateSizes() {
    return sizeService.findAll();
  }

  @GetMapping("/admin/product")
  public String getProductPage(Model model, ProductCriteriaDTO productCriteria, HttpServletRequest request) {

    productCriteria.setPageSize(4);
    Page<Product> pagedProduct = productService.getPageWithSpec(productCriteria);
    List<Product> productList = pagedProduct.getContent();
    model.addAttribute("productList", productList);
    model.addAttribute("totalPages", pagedProduct.getTotalPages());
    model.addAttribute("currentPage", pagedProduct.getNumber() + 1);
    model.addAttribute("categories", categoryService.findAll());
    model.addAttribute("brands", brandService.findAll());
    model.addAttribute("totalProducts", pagedProduct.getTotalElements());

    String queryString = request.getQueryString();
    if (queryString != null) {
      queryString = queryString.replace("page=" + productCriteria.getPage(), "");
      if (!queryString.isBlank() && !queryString.startsWith("&"))
        queryString = "&" + queryString;
    }
    model.addAttribute("queryString", queryString);

    return "admin/product/show";
  }

  @GetMapping("/admin/product/create")
  public String getCreateProductPage(Model model) {

    model.addAttribute("newProduct", new Product());

    return "admin/product/create";
  }

  @PostMapping("/admin/product/create")
  public String createProduct(@Valid @ModelAttribute("newProduct") Product product, BindingResult productBindingResult,
      @RequestParam("image_file") MultipartFile file,
      Model model,
      RedirectAttributes redirectAttributes) {

    if (productService.nameExists(product.getName(), null))
      productBindingResult.rejectValue("name", "Unique", "Name already exists");

    if (!file.isEmpty()) {
      String savedFile = fileService.saveImage(file, Type.PRODUCT);
      product.setImage(savedFile);
    } else {
      productBindingResult.rejectValue("image", "Not Empty", "Product image must be uploaded");
    }

    if (productBindingResult.hasFieldErrors()) {
      List<FieldError> errors = productBindingResult.getFieldErrors();
      errors.forEach(
          (e) -> System.out.println(">>> ERR Create Product: " + e.getField() + " - " + e.getDefaultMessage()));

      return "admin/product/create";
    }

    Product newProduct = productService.createProduct(product);
    redirectAttributes.addFlashAttribute("successMessage", "Product created successfully!");
    return "redirect:/admin/product";
  }

  @GetMapping("/admin/product/update/{id}")
  public String getProductUpdatePage(@PathVariable long id, Model model) {
    Product product = productService.get(id);
    model.addAttribute("product", product);

    return "admin/product/update";
  }

  @PostMapping("/admin/product/update")
  public String updateProduct(@Valid @ModelAttribute Product product, BindingResult productBindingResult,
      @RequestParam("image_file") MultipartFile file,
      Model model,
      RedirectAttributes redirectAttributes) {

    if (productService.nameExists(product.getName(), product.getId()))
      productBindingResult.rejectValue("name", "Unique", "Name already exists");

    if (productBindingResult.hasFieldErrors()) {
      List<FieldError> errors = productBindingResult.getFieldErrors();
      errors.forEach(
          (e) -> System.out.println(">>> ERR Update Product: " + e.getField() + " - " + e.getDefaultMessage()));
      return "admin/product/update";
    }

    if (!file.isEmpty()) {
      fileService.deleteImage(product.getImage(), Type.PRODUCT);
      String savedFile = fileService.saveImage(file, Type.PRODUCT);
      product.setImage(savedFile);
    }

    try {
      Product updatedProduct = productService.updateProduct(product);
      redirectAttributes.addFlashAttribute("successMessage", "User updated successfully!");
    } catch (Exception e) {
      e.printStackTrace();
      redirectAttributes.addFlashAttribute("errorMessage", "Fail to update user. Please try again later.");
    }
    return "redirect:/admin/product/update/" + product.getId();
  }

  @GetMapping("/admin/product/delete/{id}")
  public String getProductDeletePage(@PathVariable long id, Model model) {
    Product product = productService.get(id);
    model.addAttribute("product", product);
    return "admin/product/delete";
  }

  @PostMapping("/admin/product/delete/{id}")
  public String deleteProduct(@PathVariable long id, RedirectAttributes redirectAttributes) {
    Product product = productService.get(id);
    if (product == null)
      return "redirect:/admin/product";

    String fileName = product.getImage();
    if (fileName != null && !fileName.isEmpty()) {
      fileService.deleteImage(fileName, Type.PRODUCT);
    }
    productService.delete(id);
    redirectAttributes.addFlashAttribute("successMessage", "Product deleted successfully!");
    return "redirect:/admin/product";
  }

  @GetMapping("/admin/product/{id}")
  public String getProductDetailPage(@PathVariable long id, Model model) {
    model.addAttribute("product", productService.get(id));
    return "admin/product/detail";
  }

}
