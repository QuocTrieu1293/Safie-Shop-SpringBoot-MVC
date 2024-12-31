package com.quoctrieu.springbootmvc.controller.api;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.dto.ProductDTO;
import com.quoctrieu.springbootmvc.repository.SizeRepository;
import com.quoctrieu.springbootmvc.service.ProductService;

@RestController
@RequestMapping("/api/product")
public class ProductAPI {

  private final ProductService productService;
  private final SizeRepository sizeRepository;

  public ProductAPI(ProductService productService, SizeRepository sizeRepository) {
    this.productService = productService;
    this.sizeRepository = sizeRepository;
  }

  @GetMapping("/{id}")
  public ResponseEntity<ProductDTO> getProductJson(@PathVariable long id) {
    Product product = productService.get(id);
    if (product == null)
      return ResponseEntity.notFound().build();

    ProductDTO productDTO = new ProductDTO(product);

    return ResponseEntity.ok(productDTO);
  }

  @PostMapping("/add-to-cart/{id}")
  public ResponseEntity<AddProductResponse> addProductToCart(@PathVariable("id") long productId,
      @RequestParam long sizeId,
      @RequestParam(defaultValue = "1") int quantity,
      HttpServletRequest request) {

    HttpSession session = request.getSession(false);
    long userId = (long) session.getAttribute("userId");

    Cart cart = productService.addToCart(userId, productId, sizeId, quantity);
    session.setAttribute("cartSum", cart.getSum());

    return ResponseEntity.ok(new AddProductResponse(productService.get(productId).getName(),
        sizeRepository.findById(sizeId).getName(), quantity, cart.getSum()));
  }

}

class AddProductResponse {
  private String productName;
  private String size;
  private int quantity;
  private int cartSum;

  public AddProductResponse(String productName, String size, int quantity, int cartSum) {
    this.productName = productName;
    this.size = size;
    this.quantity = quantity;
    this.cartSum = cartSum;
  }

  public String getProductName() {
    return productName;
  }

  public void setProductName(String productName) {
    this.productName = productName;
  }

  public String getSize() {
    return size;
  }

  public void setSize(String size) {
    this.size = size;
  }

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  public int getCartSum() {
    return cartSum;
  }

  public void setCartSum(int cartSum) {
    this.cartSum = cartSum;
  }

}