package com.quoctrieu.springbootmvc.domain.dto;

import com.quoctrieu.springbootmvc.service.validator.StrongPassword;

import jakarta.validation.constraints.NotBlank;

public class ChangePasswordDTO {
  @NotBlank(message = "Vui lòng nhập mật khẩu")
  private String password;

  @NotBlank(message = "Vui lòng nhập mật khẩu mới")
  @StrongPassword
  private String newPassword;

  @NotBlank(message = "Vui lòng nhập lại mật khẩu mới")
  private String confirmNewPassword;

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getNewPassword() {
    return newPassword;
  }

  public void setNewPassword(String newPassword) {
    this.newPassword = newPassword;
  }

  public String getConfirmNewPassword() {
    return confirmNewPassword;
  }

  public void setConfirmNewPassword(String confirmNewPassword) {
    this.confirmNewPassword = confirmNewPassword;
  }

}
