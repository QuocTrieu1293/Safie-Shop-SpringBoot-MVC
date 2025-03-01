package com.quoctrieu.springbootmvc.domain.dto;

import java.util.List;
import java.util.stream.Collectors;

import com.quoctrieu.springbootmvc.domain.Product;

public class ProductDTO {

  long id;
  String name;
  double price;
  String image;
  String brand;
  String category;
  List<SizeDTO> sizes;

  public ProductDTO(Product product) {
    id = product.getId();
    name = product.getName();
    price = product.getPrice();
    image = product.getImage();
    brand = product.getBrand().getName();
    category = product.getCategory().getName();
    sizes = product.getSizes().stream().map(SizeDTO::new).collect(Collectors.toList());
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
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

  public String getBrand() {
    return brand;
  }

  public void setBrand(String brand) {
    this.brand = brand;
  }

  public String getCategory() {
    return category;
  }

  public void setCategory(String category) {
    this.category = category;
  }

  public List<SizeDTO> getSizes() {
    return sizes;
  }

  public void setSizes(List<SizeDTO> sizes) {
    this.sizes = sizes;
  }

}
