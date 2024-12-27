package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;
import vn.hoidanit.laptopshop.domain.Size;
import vn.hoidanit.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.SizeRepository;
import vn.hoidanit.laptopshop.specification.ProductSpecs;

@Service
public class ProductService {

  private final ProductRepository productRepository;
  private final UserService userService;
  private final CartDetailRepository cartDetailRepository;
  private final CartRepository cartRepository;
  private final SizeRepository sizeRepository;
  private final UtilsService utilsService;

  public ProductService(ProductRepository productRepository, UserService userService,
      CartDetailRepository cartDetailRepository, CartRepository cartRepository, SizeRepository sizeRepository,
      UtilsService utilsService) {
    this.productRepository = productRepository;
    this.userService = userService;
    this.cartDetailRepository = cartDetailRepository;
    this.cartRepository = cartRepository;
    this.sizeRepository = sizeRepository;
    this.utilsService = utilsService;
  }

  public Product createProduct(Product product) {
    return productRepository.save(product);
  }

  public List<Product> getAll() {
    return productRepository.findAll();
  }

  public Page<Product> getPage(Pageable pageable) {
    return productRepository.findAll(pageable);
  }

  public Page<Product> getPageWithSpec(ProductCriteriaDTO productCriteria) {
    PageRequest pageRequest = utilsService.getPageRequest(productCriteria.getPage(), 9);
    Sort sort = switch (productCriteria.getSort()) {
      case "gia-thap" -> Sort.by(Product_.PRICE).ascending();
      case "gia-cao" -> Sort.by(Product_.PRICE).descending();
      default -> Sort.by(Product_.QUANTITY).descending();
    };

    String priceStr = productCriteria.getPrice();
    Double minPrice, maxPrice;
    try {
      minPrice = Double.parseDouble(priceStr.split("-")[0]) * 1000;
    } catch (Exception e) {
      minPrice = null;
    }
    try {
      maxPrice = Double.parseDouble(priceStr.split("-")[1]) * 1000;
    } catch (Exception e) {
      maxPrice = null;
    }
    Specification<Product> spec = ProductSpecs.filterBy(productCriteria.getCategory(), productCriteria.getBrands(),
        minPrice, maxPrice, productCriteria.getSizes());

    return productRepository.findAll(spec, pageRequest.withSort(sort));
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
