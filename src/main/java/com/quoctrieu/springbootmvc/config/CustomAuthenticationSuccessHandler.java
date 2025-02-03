package com.quoctrieu.springbootmvc.config;

import java.io.IOException;
import java.net.URL;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.quoctrieu.springbootmvc.domain.Cart;
import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.service.UserService;

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

  @Autowired
  private UserService userService;
  private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

  protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response,
      final Authentication authentication) {

    // redirect user back to referer url
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
      for (Cookie cookie : cookies) {
        if (cookie.getName().equals("referrer")) {
          cookie.setMaxAge(0);
          response.addCookie(cookie);
          try {
            URL refererURL = new URL(cookie.getValue());
            if (refererURL.getPath().equals("/register"))
              break;

            return cookie.getValue();
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
      }
    }

    Map<String, String> roleTargetUrlMap = new HashMap<>();
    roleTargetUrlMap.put("ROLE_User", "/");
    roleTargetUrlMap.put("ROLE_Admin", "/admin");

    final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
    for (final GrantedAuthority grantedAuthority : authorities) {
      String authorityName = grantedAuthority.getAuthority();
      if (roleTargetUrlMap.containsKey(authorityName)) {
        return roleTargetUrlMap.get(authorityName);
      }
    }

    throw new IllegalStateException();
  }

  protected void handle(
      HttpServletRequest request,
      HttpServletResponse response,
      Authentication authentication) throws IOException {

    String targetUrl = determineTargetUrl(request, response, authentication);

    String email = authentication.getName();
    User loggedInUser = userService.getUserByEmail(email);
    HttpSession session = request.getSession(false);

    if (session == null || loggedInUser == null) {
      if (!response.isCommitted())
        redirectStrategy.sendRedirect(request, response, "/login?error");
      return;
    }

    if (!response.isCommitted())
      redirectStrategy.sendRedirect(request, response, targetUrl);

    session.setAttribute("fullName", loggedInUser.getFullName());
    session.setAttribute("avatar", loggedInUser.getAvatar());
    session.setAttribute("email", loggedInUser.getEmail());
    session.setAttribute("userId", loggedInUser.getId());

    Cart cart = userService.getCart(loggedInUser.getId());
    session.setAttribute("cartSum", cart.getSum());
    session.setAttribute("cartId", cart.getId());
  }

  protected void clearAuthenticationAttributes(HttpServletRequest request) {
    HttpSession session = request.getSession(false);
    if (session == null) {
      return;
    }
    session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
  }

  @Override
  public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
      Authentication authentication) throws IOException, ServletException {

    handle(request, response, authentication);
    clearAuthenticationAttributes(request);
  }

}
