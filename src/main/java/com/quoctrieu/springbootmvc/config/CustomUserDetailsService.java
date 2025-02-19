package com.quoctrieu.springbootmvc.config;

import java.util.Collections;

import javax.naming.AuthenticationException;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.exception.UserNotEnabledException;
import com.quoctrieu.springbootmvc.service.UserService;

@Service
public class CustomUserDetailsService implements UserDetailsService {

  private final UserService userService;

  public CustomUserDetailsService(UserService userService) {
    this.userService = userService;
  }

  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

    com.quoctrieu.springbootmvc.domain.User user = userService.getUserByEmail(username);

    if (user == null || (user.getAuthenProvider() != null && !user.getAuthenProvider().equals("Local")))
      throw new UsernameNotFoundException("User not found");
    if (!user.isEnabled())
      throw new UserNotEnabledException("User not enabled");

    return new User(
        user.getEmail(),
        user.getPassword(),
        Collections.singleton(new SimpleGrantedAuthority("ROLE_" + user.getRole().getName())));
  }

}
