package com.quoctrieu.springbootmvc.controller.api;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.dto.ProductDTO;
import com.quoctrieu.springbootmvc.repository.ProductRepository;
import com.quoctrieu.springbootmvc.repository.SizeRepository;
import com.quoctrieu.springbootmvc.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/product")
public class ProductAPI {

  private final ProductService productService;
  private final SizeRepository sizeRepository;
  private final ProductRepository productRepository;

  public ProductAPI(ProductService productService, SizeRepository sizeRepository, ProductRepository productRepository) {
    this.productService = productService;
    this.sizeRepository = sizeRepository;
    this.productRepository = productRepository;
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

  @GetMapping("/search")
  public List<SearchedProduct> getSearchedProduct(@RequestParam("q") String search) {
    List<Product> products = productRepository.findTop3ByNameContainingOrderByQuantityDesc(search);
    List<SearchedProduct> searchedProducts = products.stream().map(product -> new SearchedProduct(product)).toList();
    return searchedProducts;
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

class SearchedProduct {
  private long id;
  private String productName;
  private double price;
  private String image;
  private long quantity;

  public SearchedProduct(Product product) {
    this.id = product.getId();
    this.productName = product.getName();
    this.price = product.getPrice();
    this.image = product.getImage();
    this.quantity = product.getQuantity();
  }

  public String getProductName() {
    return productName;
  }

  public void setProductName(String productName) {
    this.productName = productName;
  }

  public double getPrice() {
    return price;
  }

  public void setPrice(double price) {
    this.price = price;
  }

  public String getImage() {
    return image;
  }

  public void setImage(String image) {
    this.image = image;
  }

  public long getQuantity() {
    return quantity;
  }

  public void setQuantity(long quantity) {
    this.quantity = quantity;
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

}