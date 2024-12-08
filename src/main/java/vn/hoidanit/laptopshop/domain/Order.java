package vn.hoidanit.laptopshop.domain;

import java.util.Set;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "`orders`")
public class Order {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;

  private double totalPrice;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "user_id")
  private User user;

  @OneToMany(mappedBy = "order")
  private Set<OrderDetail> orderDetails;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public double getTotalPrice() {
    return totalPrice;
  }

  public void setTotalPrice(double totalPrice) {
    this.totalPrice = totalPrice;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public Set<OrderDetail> getOrderDetails() {
    return orderDetails;
  }

  public void setOrderDetails(Set<OrderDetail> orderDetails) {
    this.orderDetails = orderDetails;
  }

  @Override
  public String toString() {
    return "Order [id=" + id + ", totalPrice=" + totalPrice + ", user=" + user + ", orderDetails=" + orderDetails + "]";
  }

}
