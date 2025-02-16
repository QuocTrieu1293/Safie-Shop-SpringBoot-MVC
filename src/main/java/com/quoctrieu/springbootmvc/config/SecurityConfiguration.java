package com.quoctrieu.springbootmvc.config;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

import com.quoctrieu.springbootmvc.repository.RoleRepository;
import com.quoctrieu.springbootmvc.service.CustomUserDetailsService;
import com.quoctrieu.springbootmvc.service.UserService;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.ServletContext;

@Configuration
@EnableMethodSecurity(securedEnabled = true) // active spring web security
public class SecurityConfiguration {

  @Bean
  PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

  @Bean
  UserDetailsService userDetailsService(UserService userService) {
    return new CustomUserDetailsService(userService);
  }

  @Bean
  OAuth2UserService<OidcUserRequest, OidcUser> customOidcUserService(
      UserService userService,
      RoleRepository roleRepository, ServletContext servletContext) {
    return new CustomOidcUserService(userService, roleRepository, servletContext);
  }

  @Bean
  OAuth2UserService<OAuth2UserRequest, OAuth2User> customOAuth2UserService(
      UserService userService,
      RoleRepository roleRepository, ServletContext servletContext) {
    return new CustomOAuth2UserService(userService, roleRepository, servletContext);
  }

  // @Bean
  // AuthenticationManager authenticationManager(HttpSecurity http,
  // PasswordEncoder passwordEncoder,
  // UserDetailsService userDetailsService) throws Exception {
  // AuthenticationManagerBuilder authenticationManagerBuilder = http
  // .getSharedObject(AuthenticationManagerBuilder.class);
  // authenticationManagerBuilder
  // .userDetailsService(userDetailsService)
  // .passwordEncoder(passwordEncoder);
  // return authenticationManagerBuilder.build();
  // }
  
  @Bean
  DaoAuthenticationProvider authProvider(
      PasswordEncoder passwordEncoder,
      UserDetailsService userDetailsService) {

    DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
    authProvider.setUserDetailsService(userDetailsService);
    authProvider.setPasswordEncoder(passwordEncoder);
    authProvider.setHideUserNotFoundExceptions(false);

    return authProvider;
  }

  @Bean
  AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
    return new CustomAuthenticationSuccessHandler();
  }

  @Bean
  LogoutSuccessHandler customLogoutSuccessHandler() {
    return new CustomLogoutSuccessHandler();
  }

  SpringSessionRememberMeServices rememberMeServices() {
    SpringSessionRememberMeServices rememberMeServices = new SpringSessionRememberMeServices();
    // optionally customize
    rememberMeServices.setAlwaysRemember(true);
    return rememberMeServices;
  }

  @Bean
  AuthenticationEntryPoint customAuthenticationEntryPoint() {
    return new CustomAuthenticationEntryPoint();
  }

  @Bean
  SecurityFilterChain filterChain(HttpSecurity http, AuthenticationSuccessHandler customAuthenticationSuccessHandler,
      LogoutSuccessHandler customLogoutSuccessHandler, AuthenticationEntryPoint customAuthenticationEntryPoint,
      OAuth2UserService<OidcUserRequest, OidcUser> customOidcUserService,
      OAuth2UserService<OAuth2UserRequest, OAuth2User> customOAuth2UserService)
      throws Exception {

    http
        .authorizeHttpRequests(authorize -> authorize
            .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()

            .requestMatchers("/login", "/register", "/", "/product/**", "/products/**", "/api/product/{id}",
                "/api/product/search", "/client/**", "/css/**", "/images/**", "/js/**", "/api/test/**")
            .permitAll()

            .requestMatchers("/admin/**", "/api/order/update").hasRole("Admin")

            .anyRequest().authenticated())

        .formLogin(formLogin -> formLogin
            .loginPage("/login")
            .failureUrl("/login?error")
            // .defaultSuccessUrl("/product/3")
            .successHandler(customAuthenticationSuccessHandler)
            .permitAll())

        .oauth2Login(o -> o
            .loginPage("/login")
            .userInfoEndpoint(u -> u
                .userService(customOAuth2UserService)
                .oidcUserService(customOidcUserService))
            .successHandler(customAuthenticationSuccessHandler)
            .failureHandler(
                (request, response, exception) -> {
                  if (exception.getClass() == OAuth2AuthenticationException.class) {
                    OAuth2AuthenticationException e = (OAuth2AuthenticationException) exception;
                    if (e.getError().getErrorCode().equals("email_notfound"))
                      response
                          .sendRedirect("/login?error=" + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8));
                    else
                      response.sendRedirect("/login?error="
                          + URLEncoder.encode("Đăng nhập thất bại, vui lòng thử lại!", StandardCharsets.UTF_8));

                  } else {
                    response.sendRedirect("/login?error="
                        + URLEncoder.encode("Đăng nhập thất bại, vui lòng thử lại!", StandardCharsets.UTF_8));
                  }
                })
            .permitAll())

        .logout(logout -> logout
            .logoutSuccessHandler(customLogoutSuccessHandler).permitAll()
            .deleteCookies("SESSION").invalidateHttpSession(true))

        .exceptionHandling(ex -> ex.accessDeniedPage("/access-deny")
            .authenticationEntryPoint(customAuthenticationEntryPoint))

        .sessionManagement((sessionManagement) -> sessionManagement
            .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
            /*
             * Khồng dùng .invalidSessionUrl() vì đã dùng CustomAuthenticationEntryPoint để
             * handle AJAX request khi session invalid
             */
            // .invalidSessionUrl("/login?invalid=true")
            .maximumSessions(1)
            .maxSessionsPreventsLogin(false))

        .rememberMe(rememberMe -> rememberMe
            .rememberMeServices(rememberMeServices()));

    return http.build();
  }

}