package com.quoctrieu.springbootmvc.domain;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;

@Entity
public class VerifyUserToken {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(unique = true, nullable = false)
  private String token;

  // @Column(nullable = false)
  // private LocalDateTime expiration;

  @OneToOne
  @JoinColumn(name = "user_id", nullable = false, unique = true)
  private User user;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getToken() {
    return token;
  }

  public void setToken(String token) {
    this.token = token;
  }

  // public LocalDateTime getExpiration() {
  // return expiration;
  // }

  // public void setExpiration(LocalDateTime expiration) {
  // this.expiration = expiration;
  // }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

}
