package com.quoctrieu.springbootmvc.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "cart_detail")
public class CartDetail {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;
  private int quantity;

  // cart_id: long
  @ManyToOne
  @JoinColumn(name = "cart_id")
  private Cart cart;
  // product_id: long
  @ManyToOne
  @JoinColumn(name = "product_id")
  private Product product;

  @ManyToOne
  @JoinColumn(name = "size_id")
  Size size;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  public Cart getCart() {
    return cart;
  }

  public void setCart(Cart cart) {
    this.cart = cart;
  }

  public Product getProduct() {
    return product;
  }

  public void setProduct(Product product) {
    this.product = product;
  }

  public Size getSize() {
    return size;
  }

  public void setSize(Size size) {
    this.size = size;
  }

  public double getPrice() {
    return quantity * product.getPrice();
  }

  @Override
  public String toString() {
    return "CartDetail [id=" + id + ", quantity=" + quantity + ", price=" + quantity * product.getPrice()
        + ", cart=[id=" + cart.getId()
        + "], product="
        + product + ", size=[id=" + size.getId() + ",name=" + size.getName() + "]]";
  }
}