package vn.hoidanit.laptopshop.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import vn.hoidanit.laptopshop.service.validator.RegisterChecked;
import vn.hoidanit.laptopshop.service.validator.StrongPassword;

@RegisterChecked
public class RegisterDTO {

  @NotBlank(message = "First name must be not blank")
  @Size(min = 3, message = "First name must have at least 3 characters")
  private String firstName;

  private String lastName;

  @Email(message = "Email is not valid", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
  @NotBlank(message = "Email cannot be blank")
  private String email;

  @StrongPassword
  @NotBlank(message = "Password cannot be blank")
  private String password;

  private String confirmPassword;

  public String getFirstName() {
    return firstName;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public String getLastName() {
    return lastName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
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
}