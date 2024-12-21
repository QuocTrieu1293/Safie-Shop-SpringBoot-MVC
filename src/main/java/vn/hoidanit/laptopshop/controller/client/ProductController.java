package vn.hoidanit.laptopshop.controller.client;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.dto.ProductDTO;
import vn.hoidanit.laptopshop.repository.SizeRepository;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller("clientProductController")
public class ProductController {

  private final UserService userService;
  private final ProductService productService;
  private final SizeRepository sizeRepository;

  ProductController(UserService userService, ProductService productService, SizeRepository sizeRepository) {
    this.userService = userService;
    this.productService = productService;
    this.sizeRepository = sizeRepository;
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
      @RequestHeader(value = "referer", required = false) String referer, HttpServletRequest request,
      RedirectAttributes redirectAttributes) {

    HttpSession session = request.getSession(false);

    String target = "redirect:" + (referer != null ? referer : "/");
    if (session == null)
      return target;

    long userId = (long) session.getAttribute("userId");

    Cart cart = productService.addToCart(userId, productId, sizeId, quantity);
    session.setAttribute("cartSum", cart.getSum());

    redirectAttributes.addFlashAttribute("addedProduct", productService.get(productId).getName());
    redirectAttributes.addFlashAttribute("addedSize", sizeRepository.findById(sizeId).getName());
    redirectAttributes.addFlashAttribute("addedQuantity", quantity);

    return target;
  }

}
