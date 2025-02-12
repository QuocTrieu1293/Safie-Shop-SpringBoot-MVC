package com.quoctrieu.springbootmvc.domain.dto;

import org.hibernate.validator.constraints.Length;

import com.quoctrieu.springbootmvc.domain.Address;
import com.quoctrieu.springbootmvc.domain.Address.Type;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

public class AddressDTO {

  Long id;

  @NotBlank(message = "Fullname cannot be blank")
  @NotNull(message = "Fullname cannot be empty")
  @Length(min = 2, max = 30, message = "Name must be from 2 to 30 characters")
  private String fullName;

  @Pattern(regexp = "^\\d{10}$", message = "Phone number must be exactly 10 digits")
  @NotNull(message = "Phone number cannot be empty")
  private String phone;

  @NotNull(message = "City cannot be empty")
  @NotBlank(message = "City cannot be blank")
  private String city;

  @NotNull(message = "District cannot be empty")
  @NotBlank(message = "District cannot be blank")
  private String district;

  @NotNull(message = "Ward cannot be empty")
  @NotBlank(message = "Ward cannot be blank")
  private String ward;

  @NotNull(message = "Street cannot be empty")
  @NotBlank(message = "Street cannot be blank")
  private String street;

  private Address.Type type;

  private boolean defaultAddress;

  @NotNull
  private String cityId;

  @NotNull
  private String districtId;

  @NotNull
  private String wardId;

  public AddressDTO() {
    type = Type.HOME;
  };

  public AddressDTO(Address address) {
    this.id = address.getId();
    this.fullName = address.getReceiverName();
    this.phone = address.getReceiverPhone();
    this.city = address.getCity();
    this.district = address.getDistrict();
    this.ward = address.getWard();
    this.street = address.getStreet();
    this.cityId = address.getCityId();
    this.districtId = address.getDistrictId();
    this.wardId = address.getWardId();
    this.defaultAddress = address.isDefaultAddress();
    this.type = address.getType();
  }

  public String getFullName() {
    return fullName;
  }

  public void setFullName(String fullName) {
    this.fullName = fullName;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
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

  public String getStreet() {
    return street;
  }

  public void setStreet(String street) {
    this.street = street;
  }

  public Address.Type getType() {
    return type;
  }

  public void setType(Address.Type type) {
    this.type = type;
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

  public boolean isDefaultAddress() {
    return defaultAddress;
  }

  public void setDefaultAddress(boolean defaultAddress) {
    this.defaultAddress = defaultAddress;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

}
