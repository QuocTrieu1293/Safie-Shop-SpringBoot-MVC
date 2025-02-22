package com.quoctrieu.springbootmvc.config;

import java.io.IOException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.web.util.UriComponentsBuilder;

import com.quoctrieu.springbootmvc.exception.UserNotEnabledException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

  protected Log logger = LogFactory.getLog(this.getClass());
  private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

  @Override
  public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
      AuthenticationException exception) throws IOException, ServletException {
    if (response.isCommitted()) {
      logger.debug("Response has already been committed. Unable to redirect!");
    } else if (exception.getCause() != null && exception.getCause().getClass() == UserNotEnabledException.class) {
      String email = request.getParameter("username");
      String targetUrl = UriComponentsBuilder.fromPath("/verifyRegistration/sendMail").queryParam("email", email)
          .toUriString();
      redirectStrategy.sendRedirect(request, response, targetUrl);
      HttpSession session = request.getSession();
      session.setAttribute("errorMessage", "Tài khoản chưa được xác thực");
    } else {
      redirectStrategy.sendRedirect(request, response, "/login?error");
    }

    // Clear Authentication attributes
    HttpSession session = request.getSession();
    if (session != null) {
      session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }
  }

}
