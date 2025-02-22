package com.quoctrieu.springbootmvc.config;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableMethodSecurity(securedEnabled = true) // active spring web security
public class SecurityConfiguration {

  @Bean
  PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

  // @Bean
  // OAuth2UserService<OidcUserRequest, OidcUser> customOidcUserService(
  // UserService userService,
  // RoleRepository roleRepository, ServletContext servletContext) {
  // return new CustomOidcUserService(userService, roleRepository,
  // servletContext);
  // }

  // @Bean
  // OAuth2UserService<OAuth2UserRequest, OAuth2User> customOAuth2UserService(
  // UserService userService,
  // RoleRepository roleRepository, ServletContext servletContext) {
  // return new CustomOAuth2UserService(userService, roleRepository,
  // servletContext);
  // }

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
      CustomUserDetailsService customUserDetailsService) {

    DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
    authProvider.setUserDetailsService(customUserDetailsService);
    authProvider.setPasswordEncoder(passwordEncoder);
    authProvider.setHideUserNotFoundExceptions(false);

    return authProvider;
  }

  @Bean
  AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
    return new CustomAuthenticationSuccessHandler();
  }

  @Bean
  AuthenticationFailureHandler customAuthenticationFailureHandler() {
    return new CustomAuthenticationFailureHandler();
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
      AuthenticationFailureHandler customAuthenticationFailureHandler,
      LogoutSuccessHandler customLogoutSuccessHandler, AuthenticationEntryPoint customAuthenticationEntryPoint,
      CustomOidcUserService customOidcUserService,
      CustomOAuth2UserService customOAuth2UserService)
      throws Exception {

    http
        .authorizeHttpRequests(authorize -> authorize
            .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()

            .requestMatchers("/login", "/register", "/", "/product/**", "/products/**", "/api/product/{id}",
                "/api/product/search", "/client/**", "/css/**", "/images/**", "/js/**", "/api/test/**", "css/**",
                "/verifyRegistration/**", "/profile/account/password/reset", "/forgetPassword",
                "/profile/account/password/sendMail")
            .permitAll()
            // .requestMatchers(HttpMethod.POST, "/verifyRegistration/sendMail").permitAll()
            // vẫn chạy được khi ko explicit include HttpMethod.POST
            .requestMatchers("/admin/**", "/api/order/update").hasRole("Admin")

            .anyRequest().authenticated())

        .formLogin(formLogin -> formLogin
            .loginPage("/login")
            .loginProcessingUrl("/login") // Submit URL khi login
            // .failureUrl("/login?error")
            // .defaultSuccessUrl("/product/3")
            .failureHandler(customAuthenticationFailureHandler)
            .successHandler(customAuthenticationSuccessHandler))

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
                }))

        .logout(logout -> logout
            .logoutSuccessHandler(customLogoutSuccessHandler).permitAll()
            .deleteCookies("SESSION").invalidateHttpSession(true))

        .exceptionHandling(ex -> ex.accessDeniedPage("/access-deny"))

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