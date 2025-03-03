package com.quoctrieu.springbootmvc.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.CartDetail;
import com.quoctrieu.springbootmvc.domain.Product;
import com.quoctrieu.springbootmvc.domain.Product_;
import com.quoctrieu.springbootmvc.domain.Size;
import com.quoctrieu.springbootmvc.domain.dto.ProductCriteriaDTO;
import com.quoctrieu.springbootmvc.repository.CartDetailRepository;
import com.quoctrieu.springbootmvc.repository.CartRepository;
import com.quoctrieu.springbootmvc.repository.ProductRepository;
import com.quoctrieu.springbootmvc.repository.SizeRepository;
import com.quoctrieu.springbootmvc.specification.ProductSpecs;

@Service
public class ProductService {

  public static final String CACHE_NAME = "products";

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

  @Caching(evict = {
      @CacheEvict(value = CACHE_NAME, allEntries = true),
      @CacheEvict(value = CategoryService.CACHE_NAME, allEntries = true)
  })
  public Product createProduct(Product product) {
    return productRepository.save(product);
  }

  public List<Product> getAll() {
    return productRepository.findByDeletedFalse();
  }

  @Cacheable(value = CACHE_NAME, key = "'homepage'")
  public List<Product> getProductHomePage() {
    ProductCriteriaDTO criteria = new ProductCriteriaDTO();
    criteria.setPage("0");
    criteria.setPageSize(8);
    Page<Product> pagedProduct = getPageWithSpec(criteria);
    List<Product> products = pagedProduct.getContent();
    return products;
  }

  @Cacheable(CACHE_NAME)
  public Page<Product> getPageWithSpec(ProductCriteriaDTO productCriteria) {
    PageRequest pageRequest = UtilsService.getPageRequest(productCriteria.getPage(), productCriteria.getPageSize());
    Sort sort = switch (productCriteria.getSort()) {
      case "gia-thap", "price-lowest" -> Sort.by(Product_.PRICE).ascending();
      case "gia-cao", "price-highest" -> Sort.by(Product_.PRICE).descending();
      case "noi-bat", "quant-highest" -> Sort.by(Product_.QUANTITY).descending();
      case "quant-lowest" -> Sort.by(Product_.QUANTITY).ascending();
      default -> Sort.unsorted();
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

    String[] brands = productCriteria.getBrands();
    if (productCriteria.getBrand() != null) {
      if (brands != null) {
        brands = Arrays.copyOf(brands, brands.length + 1);
        brands[brands.length - 1] = productCriteria.getBrand();
      } else {
        brands = new String[] { productCriteria.getBrand() };
      }
    }

    Specification<Product> spec = ProductSpecs.filterBy(productCriteria.getCategory(), brands,
        minPrice, maxPrice, productCriteria.getSizes(), productCriteria.getSearch());

    return productRepository.findAll(spec, pageRequest.withSort(sort));
  }

  public Product get(long id) {
    return productRepository.findByIdAndDeletedFalse(id).orElse(null);
  }

  public boolean nameExists(String name, Long id) {
    if (id != null && id > 0)
      return productRepository.existsByNameAndIdNotAndDeletedFalse(name, id);
    return productRepository.existsByNameAndDeletedFalse(name);
  }

  @Caching(evict = {
      @CacheEvict(value = CACHE_NAME, allEntries = true),
      @CacheEvict(value = CategoryService.CACHE_NAME, allEntries = true)
  })
  public Product updateProduct(Product product) throws Exception {
    Product updatedProduct = productRepository.findByIdAndDeletedFalse(product.getId()).orElse(null);
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

  @Caching(evict = {
      @CacheEvict(value = CACHE_NAME, allEntries = true),
      @CacheEvict(value = CategoryService.CACHE_NAME, allEntries = true)
  })
  public void delete(long id) {
    productRepository.deleteById(id);
  }

  public Cart addToCart(long userId, long productId, long sizeId, int quantity) {
    Cart cart = userService.getCart(userId);

    Product product = get(productId);
    if (product.isDeleted())
      return cart;

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

  public Long count() {
    return productRepository.countByDeletedFalse();
  }

  public List<Product> findTop3Search(String search) {
    return productRepository.findTop3ByNameContainingAndDeletedFalseOrderByQuantityDesc(search);
  }

  public List<Product> findFeaturedProducts(Long id) {
    return productRepository.findTop5ByIdNotAndDeletedFalseOrderByQuantityDesc(id);
  }

  public List<Product> findRelatedProducts(Long cateId, Long id) {
    return productRepository.findByCategoryIdAndIdNotAndDeletedFalse(cateId, id);
  }

}
