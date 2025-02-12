package com.quoctrieu.springbootmvc.domain;

import java.util.List;
import java.util.Set;

import org.hibernate.validator.constraints.Length;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")
public class User {
  // private static long idCounter = 0;

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;

  @Email(message = "Email is not valid", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
  @NotBlank(message = "Email cannot be blank")
  @Column(unique = true, nullable = false)
  private String email;

  @NotBlank(message = "Password cannot be blank")
  @Size(min = 8, message = "Password must be at least 8 characters")
  @NotNull
  private String password;

  @NotBlank(message = "Fullname cannot be blank")
  @NotNull
  @Length(min = 2, max = 30, message = "Name must be from 2 to 30 characters")
  private String fullName;

  // @NotBlank(message = "Phone cannot be blank")
  @Pattern(regexp = "^\\d{10}$", message = "Phone number must be exactly 10 digits")
  private String phone;

  private String avatar;

  private String gender;

  @ManyToOne
  @JoinColumn(name = "role_id") // mặc định Spring tự tạo cột khoá ngoại này, tên mặc định là <tên entity>_id
  private Role role;

  @OneToMany(mappedBy = "user", orphanRemoval = false)
  private Set<Order> orders;

  @OneToOne(mappedBy = "user")
  private Cart cart;

  @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
  private List<Address> addressBook;

  // private synchronized long generateId() {
  // return idCounter++;
  // }

  private String authenProvider;

  @PrePersist
  void prePersist() {
    if (authenProvider == null)
      authenProvider = "Local";
    // if (avatar == null)
    // avatar = "user_placeholder.png";
  }

  public User() {
    System.out.println("User created");
  }

  public User(String email, String password, String fullName, String address, String phone) {
    this.email = email;
    this.password = password;
    this.fullName = fullName;
    this.phone = phone;
    this.id = -1;
  }

  public User(long id) {
    this.id = id;
  }

  public void setId(long id) { // Phải tạo public setter thì jsp form:form mới có thể truy cập, gán giá trị đc
    this.id = id;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public void setFullName(String fullName) {
    this.fullName = fullName;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public long getId() {
    return id;
  }

  public String getPassword() {
    return password;
  }

  public String getEmail() {
    return email;
  }

  public String getFullName() {
    return fullName;
  }

  public String getPhone() {
    return phone;
  }

  public String getAvatar() {
    return avatar;
  }

  public Role getRole() {
    return role;
  }

  public void setRole(Role role) {
    this.role = role;
  }

  public Set<Order> getOrders() {
    return orders;
  }

  public void setOrders(Set<Order> orders) {
    this.orders = orders;
  }

  public Cart getCart() {
    return cart;
  }

  public void setCart(Cart cart) {
    this.cart = cart;
  }

  public String getAuthenProvider() {
    return authenProvider;
  }

  public void setAuthenProvider(String authenProvider) {
    this.authenProvider = authenProvider;
  }

  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }

  public List<Address> getAddressBook() {
    return addressBook;
  }

  public void setAddressBook(List<Address> addressBook) {
    this.addressBook = addressBook;
  }

  @Override
  public String toString() {
    return "User [id=" + id + ", email=" + email + ", password=" + password + ", fullName=" + fullName + ", phone="
        + phone + ", avatar=" + avatar + ", role=" + role + ", orders=" + orders + ", cart=[id="
        + cart.getId() + ", authenProvider=" + authenProvider + ", gender=" + gender + "]]";
  }

}