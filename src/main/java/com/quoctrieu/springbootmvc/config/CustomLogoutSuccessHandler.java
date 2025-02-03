package com.quoctrieu.springbootmvc.config;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

  private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

  protected String determineTargetUrl(HttpServletRequest request) {
    try {
      URL refererURL = new URL(request.getHeader("Referer"));
      if (refererURL.getPath().startsWith("/admin"))
        return "/login?logout";
      else
        return "/?logout";
    } catch (Exception e) {
      e.printStackTrace();
    }

    throw new IllegalStateException();
  }

  protected void handle(
      HttpServletRequest request,
      HttpServletResponse response,
      Authentication authentication) throws IOException {

    String targetUrl = determineTargetUrl(request);

    if (response.isCommitted()) {
      return;
    }

    redirectStrategy.sendRedirect(request, response, targetUrl);
  }

  protected void clearAuthenticationAttributes(HttpServletRequest request) {
    HttpSession session = request.getSession(false);
    if (session == null) {
      return;
    }
    session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
  }

  @Override
  public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
      throws IOException, ServletException {
    handle(request, response, authentication);
    clearAuthenticationAttributes(request);
  }

}
