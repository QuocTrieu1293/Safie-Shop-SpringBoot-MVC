package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.repository.ProductRepository;

@Service
public class ProductService {

  private final ProductRepository productRepository;

  public ProductService(ProductRepository productRepository) {
    this.productRepository = productRepository;
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

}
