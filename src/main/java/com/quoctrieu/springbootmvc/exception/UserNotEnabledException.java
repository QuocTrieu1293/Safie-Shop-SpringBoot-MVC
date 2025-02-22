package com.quoctrieu.springbootmvc.exception;

import org.springframework.security.core.AuthenticationException;

public class UserNotEnabledException extends AuthenticationException {

  private final static String MESSAGE = "Tài khoản chưa được kích hoạt";

  public UserNotEnabledException(String msg) {
    super(msg);
  }

  public UserNotEnabledException(String msg, Throwable cause) {
    super(msg, cause);
  }

  public UserNotEnabledException() {
    super(MESSAGE);
  }
}
