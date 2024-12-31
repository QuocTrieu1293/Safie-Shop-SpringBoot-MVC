package com.quoctrieu.springbootmvc.domain.dto;

public class CheckoutDTO {

  private String email;
  private String fullName;
  private String address;
  private String phone;
  private String orderNotes;
  private String paymentMethod;

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getFullName() {
    return fullName;
  }

  public void setFullName(String fullName) {
    this.fullName = fullName;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getOrderNotes() {
    return orderNotes;
  }

  public void setOrderNotes(String orderNotes) {
    this.orderNotes = orderNotes;
  }

  public String getPaymentMethod() {
    return paymentMethod;
  }

  public void setPaymentMethod(String payment) {
    this.paymentMethod = payment;
  }

}
