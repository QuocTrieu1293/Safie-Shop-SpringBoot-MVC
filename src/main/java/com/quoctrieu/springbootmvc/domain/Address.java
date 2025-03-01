package com.quoctrieu.springbootmvc.domain;

import java.sql.Timestamp;

import jakarta.persistence.*;
import org.hibernate.annotations.UpdateTimestamp;

import com.quoctrieu.springbootmvc.domain.dto.AddressDTO;

@Entity
@Table(name = "addresses")
public class Address {

  public enum Type {
    HOME, OFFICE
  }

  public Address() {
  }

  public Address(AddressDTO dto) {
    this.receiverName = dto.getFullName();
    this.receiverPhone = dto.getPhone();
    this.city = dto.getCity();
    this.district = dto.getDistrict();
    this.ward = dto.getWard();
    this.street = dto.getStreet();
    this.cityId = dto.getCityId();
    this.districtId = dto.getDistrictId();
    this.wardId = dto.getWardId();
    this.type = dto.getType();
    this.defaultAddress = dto.isDefaultAddress();
  }

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String city;

  @Column(nullable = false)
  private String district;

  @Column(nullable = false)
  private String ward;

  @Column(nullable = false)
  private String street;

  @Column(name = "city_id", nullable = false)
  private String cityId;

  @Column(name = "district_id", nullable = false)
  private String districtId;

  @Column(name = "ward_id", nullable = false)
  private String wardId;

  @Column(nullable = false)
  private String receiverName;

  @Column(nullable = false)
  private String receiverPhone;

  @Column(nullable = false)
  @Enumerated(EnumType.STRING)
  private Type type;

  @Column(nullable = false)
  private boolean defaultAddress;

  @UpdateTimestamp
  @Column(nullable = false, name = "updated_at")
  private Timestamp updatedAt;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "user_id")
  private User user;

  @PrePersist
  private void prePersist() {
    if (type == null)
      type = Type.HOME;

  }

  @PreUpdate
  private void preUpdate() {
    if (type == null)
      type = Type.HOME;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getCity() {
    return city;
  }

  public void setCity(String city) {
    this.city = city;
  }

  public String getDistrict() {
    return district;
  }

  public void setDistrict(String district) {
    this.district = district;
  }

  public String getWard() {
    return ward;
  }

  public void setWard(String ward) {
    this.ward = ward;
  }

  public String getCityId() {
    return cityId;
  }

  public void setCityId(String cityId) {
    this.cityId = cityId;
  }

  public String getDistrictId() {
    return districtId;
  }

  public void setDistrictId(String districtId) {
    this.districtId = districtId;
  }

  public String getWardId() {
    return wardId;
  }

  public void setWardId(String wardId) {
    this.wardId = wardId;
  }

  public String getReceiverName() {
    return receiverName;
  }

  public void setReceiverName(String receiverName) {
    this.receiverName = receiverName;
  }

  public String getReceiverPhone() {
    return receiverPhone;
  }

  public void setReceiverPhone(String receiverPhone) {
    this.receiverPhone = receiverPhone;
  }

  public Type getType() {
    return type;
  }

  public void setType(Type type) {
    this.type = type;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public boolean isDefaultAddress() {
    return defaultAddress;
  }

  public void setDefaultAddress(boolean defaultAddress) {
    this.defaultAddress = defaultAddress;
  }

  public String getStreet() {
    return street;
  }

  public void setStreet(String street) {
    this.street = street;
  }

  public Timestamp getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Timestamp updatedAt) {
    this.updatedAt = updatedAt;
  }

}
