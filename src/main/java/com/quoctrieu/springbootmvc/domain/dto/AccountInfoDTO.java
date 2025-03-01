package com.quoctrieu.springbootmvc.domain.dto;

import org.hibernate.validator.constraints.Length;

import com.quoctrieu.springbootmvc.domain.User;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

public class AccountInfoDTO {

  String email;

  @NotBlank(message = "Họ Tên không được để trống")
  @NotNull
  @Length(min = 2, max = 30, message = "Họ Tên có độ dài tối thiểu 2 và tối đa 30 kí tự")
  private String fullName;

  @Pattern(regexp = "^\\d{10}$", message = "Số điện thoại phải có 10 chữ số")
  private String phone;

  private String avatar;

  private String gender;

  public AccountInfoDTO() {
  };

  public AccountInfoDTO(User user) {
    this.email = user.getEmail();
    this.fullName = user.getFullName();
    this.phone = user.getPhone();
    this.avatar = user.getAvatar();
    this.gender = user.getGender();
  }

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

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getAvatar() {
    return avatar;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }

}
