package com.quoctrieu.springbootmvc.domain.dto;

import com.quoctrieu.springbootmvc.service.validator.StrongPassword;

import jakarta.validation.constraints.NotBlank;

public class ResetPasswordDTO {
  @NotBlank(message = "Vui lòng nhập mật khẩu mới")
  @StrongPassword
  private String newPassword;

  @NotBlank(message = "Vui lòng nhập lại mật khẩu mới")
  private String confirmNewPassword;

  private String token;

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

  public String getToken() {
    return token;
  }

  public void setToken(String token) {
    this.token = token;
  }

}
