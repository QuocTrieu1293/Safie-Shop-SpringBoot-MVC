package vn.hoidanit.laptopshop.domain;

import java.util.Set;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
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
  private String avatar;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "role_id") // mặc định Spring tự tạo cột khoá ngoại này, tên mặc định là <tên entity>_id
  private Role role;

  @OneToMany(mappedBy = "user")
  private Set<Order> orders;

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

  public String getAddress() {
    return address;
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

  @Override
  public String toString() {
    return "User [id=" + id + ", email=" + email + ", password=" + password + ", fullName=" + fullName + ", address="
        + address + ", phone=" + phone + ", avatar=" + avatar + ", role=" + role + ", orders=" + orders + "]";
  }

}