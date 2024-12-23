package vn.hoidanit.laptopshop.controller.client;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.Category;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.dto.ProductDTO;
import vn.hoidanit.laptopshop.repository.BrandRepository;
import vn.hoidanit.laptopshop.repository.CategoryRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.SizeRepository;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UtilsService;

@Controller("clientProductController")
public class ProductController {

  private final ProductService productService;
  private final SizeRepository sizeRepository;
  private final ProductRepository productRepository;
  private final CategoryRepository categoryRepository;
  private final BrandRepository brandRepository;
  private final UtilsService utilsService;

  ProductController(ProductService productService, SizeRepository sizeRepository,
      ProductRepository productRepository, CategoryRepository categoryRepository, BrandRepository brandRepository,
      UtilsService utilsService) {
    this.productService = productService;
    this.sizeRepository = sizeRepository;
    this.productRepository = productRepository;
    this.categoryRepository = categoryRepository;
    this.brandRepository = brandRepository;
    this.utilsService = utilsService;
  }

  @GetMapping("/products")
  public String getProductPage(Model model, @RequestParam(defaultValue = "1") String page) {

    Pageable pageable = utilsService.getPageable(page, 9);
    Page<Product> pagedProduct = productService.getPage(pageable);
    List<Product> products = pagedProduct.getContent();
    model.addAttribute("products", products);
    model.addAttribute("totalPages", pagedProduct.getTotalPages());
    model.addAttribute("currentPage", pageable.getPageNumber() + 1);

    model.addAttribute("categories", categoryRepository.findAll());
    model.addAttribute("brands", brandRepository.findAll());
    model.addAttribute("sizes", sizeRepository.findAll());

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

  @GetMapping("/api/product")
  public ResponseEntity<ProductDTO> getProductJson(@RequestParam long id) {
    Product product = productService.get(id);
    if (product == null)
      return ResponseEntity.notFound().build();

    ProductDTO productDTO = new ProductDTO(product);

    return ResponseEntity.ok(productDTO);
  }

  @PostMapping("/add-product-to-cart/{id}")
  public String addProductToCart(@PathVariable("id") long productId, @RequestParam long sizeId,
      @RequestParam(defaultValue = "1") int quantity,
      @RequestHeader(required = false) String referer, HttpServletRequest request,
      RedirectAttributes redirectAttributes) {

    HttpSession session = request.getSession(false);
    long userId = (long) session.getAttribute("userId");

    Cart cart = productService.addToCart(userId, productId, sizeId, quantity);
    session.setAttribute("cartSum", cart.getSum());

    redirectAttributes.addFlashAttribute("addedProduct", productService.get(productId).getName());
    redirectAttributes.addFlashAttribute("addedSize", sizeRepository.findById(sizeId).getName());
    redirectAttributes.addFlashAttribute("addedQuantity", quantity);

    return "redirect:" + (referer != null ? referer : "/");
  }

}
