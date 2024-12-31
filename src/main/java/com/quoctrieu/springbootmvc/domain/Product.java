package com.quoctrieu.springbootmvc.domain;

import java.util.Arrays;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "products")
public class Product {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;

  @NotBlank(message = "Name cannot be blank")
  @Column(unique = true, nullable = false)
  private String name;

  @DecimalMin(value = "0", inclusive = true, message = "Price must be greater than or equal to 0")
  @Column(scale = 2)
  private double price;
  private String image;

  @Column(columnDefinition = "mediumtext")
  // @Lob
  private String detailDesc;
  private String shortDesc;

  @Min(value = 0, message = "Quantity must be greater than or equal to 0")
  private long quantity;

  @Min(value = 0, message = "Sold must be greater than or equal to 0")
  private long sold;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "category_id")
  @NotNull(message = "Category cannot be null")
  private Category category;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "brand_id")
  @NotNull(message = "Brand cannot be null")
  private Brand brand;

  @ManyToMany(fetch = FetchType.EAGER)
  @JoinTable(name = "product_size", joinColumns = @JoinColumn(name = "product_id"), inverseJoinColumns = @JoinColumn(name = "size_id"))
  @NotEmpty(message = "Product sizes cannot be empty")
  private List<Size> sizes;

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

  public String getDetailDesc() {
    return detailDesc;
  }

  public void setDetailDesc(String detailDesc) {
    this.detailDesc = detailDesc;
  }

  public String getShortDesc() {
    return shortDesc;
  }

  public void setShortDesc(String shortDesc) {
    this.shortDesc = shortDesc;
  }

  public long getQuantity() {
    return quantity;
  }

  public void setQuantity(long quantity) {
    this.quantity = quantity;
  }

  public long getSold() {
    return sold;
  }

  public void setSold(long sold) {
    this.sold = sold;
  }

  public Category getCategory() {
    return category;
  }

  public void setCategory(Category category) {
    this.category = category;
  }

  public Brand getBrand() {
    return brand;
  }

  public void setBrand(Brand brand) {
    this.brand = brand;
  }

  public List<Size> getSizes() {
    return sizes;
  }

  public void setSizes(List<Size> sizes) {
    this.sizes = sizes;
  }

  @Override
  public String toString() {
    return "Product [id=" + id + ", name=" + name + ", price=" + price + ", image=" + image + ", detailDesc="
        + detailDesc + ", shortDesc=" + shortDesc + ", quantity=" + quantity + ", sold=" + sold + ", category=[id="
        + category.getId() + ", name=" + category.getName() + "], brand=[id=" + brand.getId() + ", name="
        + brand.getName() + "], sizes="
        + Arrays.toString(
            sizes.stream().map(size -> "[id=" + size.getId() + ", name=" + size.getName() + "]").toArray())
        + "]";
  }

}
