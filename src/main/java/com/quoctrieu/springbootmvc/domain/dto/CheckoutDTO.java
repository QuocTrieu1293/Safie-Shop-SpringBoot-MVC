package com.quoctrieu.springbootmvc.domain.dto;

import com.quoctrieu.springbootmvc.domain.Order.PaymentMethod;

import jakarta.validation.Valid;

public class CheckoutDTO {

  @Valid
  AddressDTO receiveInfo;

  private String orderNotes;

  private PaymentMethod paymentMethod;

  public CheckoutDTO() {
    paymentMethod = PaymentMethod.COD;
    receiveInfo = new AddressDTO();
  }

  public CheckoutDTO(AddressDTO receiveInfo) {
    this();
    this.receiveInfo = receiveInfo;
  }

  public AddressDTO getReceiveInfo() {
    return receiveInfo;
  }

  public void setReceiveInfo(AddressDTO receiveInfo) {
    this.receiveInfo = receiveInfo;
  }

  public void setOrderNotes(String orderNotes) {
    this.orderNotes = orderNotes;
  }

  public String getOrderNotes() {
    return orderNotes;
  }

  public PaymentMethod getPaymentMethod() {
    return paymentMethod;
  }

  public void setPaymentMethod(PaymentMethod payment) {
    this.paymentMethod = payment;
  }

}
