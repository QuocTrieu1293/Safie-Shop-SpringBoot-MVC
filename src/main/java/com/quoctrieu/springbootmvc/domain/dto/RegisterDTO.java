package com.quoctrieu.springbootmvc.domain.dto;

import org.hibernate.validator.constraints.Length;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.service.validator.RegisterChecked;
import com.quoctrieu.springbootmvc.service.validator.StrongPassword;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@RegisterChecked
public class RegisterDTO {

  @NotBlank(message = "Họ Tên không được để trống")
  @Length(min = 2, max = 30, message = "Họ Tên có độ dài tối thiểu 2 và tối đa 30 kí tự")
  private String fullName;

  @Email(message = "Email không đúng định dạng", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
  @NotBlank(message = "Email không được để trống")
  private String email;

  @StrongPassword
  @NotBlank(message = "Mật khẩu không được để trống")
  private String password;

  private String confirmPassword;

  public User toUser() {
    User user = new User();
    user.setEmail(email);
    user.setFullName(fullName);
    user.setPassword(password);
    return user;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getConfirmPassword() {
    return confirmPassword;
  }

  public void setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
  }

  public String getFullName() {
    return fullName;
  }

  public void setFullName(String fullName) {
    this.fullName = fullName;
  }

}