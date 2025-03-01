package com.quoctrieu.springbootmvc.domain;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.quoctrieu.springbootmvc.domain.dto.CheckoutDTO;

@Entity
@Table(name = "`orders`")
public class Order {

  public enum PaymentMethod {
    COD, VNPAY
  }

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;

  private int sum;

  @Column(scale = 2)
  private double totalPrice;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "user_id", nullable = true)
  private User user;

  @OneToMany(mappedBy = "order", fetch = FetchType.LAZY)
  private List<OrderDetail> orderDetails;

  private String receiverName;

  private String receiverAddress;

  private String receiverPhone;

  private String notes;

  private String status;

  @Enumerated(EnumType.STRING)
  private PaymentMethod paymentMethod;

  private String paymentStatus;

  private String paymentRef;

  @CreationTimestamp
  @Column(nullable = false, updatable = false)
  private LocalDateTime date;

  @UpdateTimestamp
  private LocalDateTime lastModified;

  public Order() {
  }

  public Order(CheckoutDTO checkoutDTO) {
    this.receiverName = checkoutDTO.getReceiveInfo().getFullName();
    this.receiverPhone = checkoutDTO.getReceiveInfo().getPhone();
    this.receiverAddress = String.format("%s, %s, %s, %s",
        checkoutDTO.getReceiveInfo().getStreet(),
        checkoutDTO.getReceiveInfo().getWard(),
        checkoutDTO.getReceiveInfo().getDistrict(),
        checkoutDTO.getReceiveInfo().getCity());
    this.notes = checkoutDTO.getOrderNotes();
    this.paymentMethod = checkoutDTO.getPaymentMethod();
  }

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

  public List<OrderDetail> getOrderDetails() {
    return orderDetails;
  }

  public void setOrderDetails(List<OrderDetail> orderDetails) {
    this.orderDetails = orderDetails;
  }

  public String getReceiverName() {
    return receiverName;
  }

  public void setReceiverName(String receiverName) {
    this.receiverName = receiverName;
  }

  public String getReceiverAddress() {
    return receiverAddress;
  }

  public void setReceiverAddress(String receiverAddress) {
    this.receiverAddress = receiverAddress;
  }

  public String getReceiverPhone() {
    return receiverPhone;
  }

  public void setReceiverPhone(String receiverPhone) {
    this.receiverPhone = receiverPhone;
  }

  public String getNotes() {
    return notes;
  }

  public void setNotes(String notes) {
    this.notes = notes;
  }

  public int getSum() {
    return sum;
  }

  public void setSum(int sum) {
    this.sum = sum;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public PaymentMethod getPaymentMethod() {
    return paymentMethod;
  }

  public void setPaymentMethod(PaymentMethod paymentMethod) {
    this.paymentMethod = paymentMethod;
  }

  public String getPaymentStatus() {
    return paymentStatus;
  }

  public void setPaymentStatus(String paymentStatus) {
    this.paymentStatus = paymentStatus;
  }

  public String getPaymentRef() {
    return paymentRef;
  }

  public void setPaymentRef(String paymentRef) {
    this.paymentRef = paymentRef;
  }

  public LocalDateTime getDate() {
    return date;
  }

  public void setDate(LocalDateTime date) {
    this.date = date;
  }

  public LocalDateTime getLastModified() {
    return lastModified;
  }

  public void setLastModified(LocalDateTime lastModified) {
    this.lastModified = lastModified;
  }

}
