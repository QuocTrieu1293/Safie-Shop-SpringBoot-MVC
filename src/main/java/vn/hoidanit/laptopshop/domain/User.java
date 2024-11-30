package vn.hoidanit.laptopshop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class User {
  private static long idCounter = 0;

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;

  private String email;
  private String password;
  private String fullName;
  private String address;
  private String phone;

  // private synchronized long generateId() {
  // return idCounter++;
  // }

  public User() {
    System.out.println("User created");
  }

  public User(String email, String password, String fullName, String address, String phone) {
    this.email = email;
    this.password = password;
    this.fullName = fullName;
    this.address = address;
    this.phone = phone;
    this.id = -1;
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

  public void setAddress(String address) {
    this.address = address;
  }

  public void setPhone(String phone) {
    this.phone = phone;
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

  public String getAddress() {
    return address;
  }

  public String getPhone() {
    return phone;
  }

  @Override
  public String toString() {
    return String.format("User{id=%d, email=%s, password=%s, fullName=%s, address=%s, phone=%s}",
        id, email, password, fullName, address, phone);
  }

}