package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Size;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.SizeRepository;

@Service
public class ProductService {

  private final ProductRepository productRepository;
  private final UserService userService;
  private final CartDetailRepository cartDetailRepository;
  private final CartRepository cartRepository;
  private final SizeRepository sizeRepository;

  public ProductService(ProductRepository productRepository, UserService userService,
      CartDetailRepository cartDetailRepository, CartRepository cartRepository, SizeRepository sizeRepository) {
    this.productRepository = productRepository;
    this.userService = userService;
    this.cartDetailRepository = cartDetailRepository;
    this.cartRepository = cartRepository;
    this.sizeRepository = sizeRepository;
  }

  public Product createProduct(Product product) {
    return productRepository.save(product);
  }

  public List<Product> getAll() {
    return productRepository.findAll();
  }

  public Product get(long id) {
    return productRepository.findById(id).orElse(null);
  }

  public boolean nameExists(String name, Long id) {
    if (id != null && id > 0)
      return productRepository.existsByNameAndIdNot(name, id);
    return productRepository.existsByName(name);
  }

  public Product updateProduct(Product product) throws Exception {
    Product updatedProduct = productRepository.findById(product.getId()).orElse(null);
    if (updatedProduct == null)
      throw new Exception("cannot find product with id = " + product.getId());

    updatedProduct.setBrand(product.getBrand());
    updatedProduct.setName(product.getName());
    updatedProduct.setCategory(product.getCategory());
    updatedProduct.setDetailDesc(product.getDetailDesc());
    updatedProduct.setShortDesc(product.getShortDesc());
    updatedProduct.setPrice(product.getPrice());
    updatedProduct.setQuantity(product.getQuantity());
    updatedProduct.setSizes(product.getSizes());
    updatedProduct.setSold(product.getSold());
    updatedProduct.setImage(product.getImage());

    return productRepository.save(updatedProduct);
  }

  public void delete(long id) {
    productRepository.deleteById(id);
  }

  public Cart addToCart(long userId, long productId, long sizeId, int quantity) {
    Cart cart = userService.getCart(userId);
    Product product = get(productId);
    Size size = sizeRepository.findById(sizeId);

    if (cart == null || product == null || size == null)
      return null;

    CartDetail cartItem = cartDetailRepository.findByCartAndProductAndSize(cart, product, size);
    if (cartItem == null) {
      cartItem = new CartDetail();
      cartItem.setCart(cart);
      cartItem.setProduct(product);
      cartItem.setSize(size);
    }
    cartItem.setQuantity(cartItem.getQuantity() + quantity);
    // cartItem.setPrice(cartItem.getPrice() + product.getPrice() * quantity);
    cartDetailRepository.save(cartItem);

    cart.setSum(cart.getSum() + quantity);
    cart = cartRepository.save(cart);

    return cart;
  }

}
