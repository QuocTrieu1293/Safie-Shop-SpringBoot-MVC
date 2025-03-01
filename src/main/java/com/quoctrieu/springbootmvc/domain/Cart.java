package com.quoctrieu.springbootmvc.domain;

import java.util.Arrays;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "carts")
public class Cart {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;
  // @Min(value = 0)
  private int sum;
  // user_id
  @OneToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "user_id")
  private User user;
  // cart_detail_id
  @OneToMany(mappedBy = "cart", fetch = FetchType.LAZY)
  List<CartDetail> cartDetails;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public int getSum() {
    return sum;
  }

  public void setSum(int sum) {
    this.sum = sum;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public List<CartDetail> getCartDetails() {
    return cartDetails;
  }

  public void setCartDetails(List<CartDetail> cartDetails) {
    this.cartDetails = cartDetails;
  }

}