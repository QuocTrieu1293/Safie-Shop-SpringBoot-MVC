package com.quoctrieu.springbootmvc.exception;

import org.springframework.security.core.AuthenticationException;

public class UserNotEnabledException extends AuthenticationException {
  public UserNotEnabledException(String msg) {
    super(msg);
  }

  public UserNotEnabledException(String msg, Throwable cause) {
    super(msg, cause);
  }
}
