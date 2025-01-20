package com.quoctrieu.springbootmvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

import jakarta.servlet.DispatcherType;
import com.quoctrieu.springbootmvc.service.CustomUserDetailsService;
import com.quoctrieu.springbootmvc.service.UserService;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {

  @Bean
  PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

  @Bean
  UserDetailsService userDetailsService(UserService userService) {
    return new CustomUserDetailsService(userService);
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
  AuthenticationSuccessHandler GetCustomAuthenticationSuccessHandler() {
    return new CustomAuthenticationSuccessHandler();
  }

  @Bean
  LogoutSuccessHandler GetCustomLogoutSuccessHandler() {
    return new CustomLogoutSuccessHandler();
  }

  @Bean
  SpringSessionRememberMeServices rememberMeServices() {
    SpringSessionRememberMeServices rememberMeServices = new SpringSessionRememberMeServices();
    // optionally customize
    rememberMeServices.setAlwaysRemember(true);
    return rememberMeServices;
  }

  @Bean
  AuthenticationEntryPoint getCustomAuthenticationEntryPoint() {
    return new CustomAuthenticationEntryPoint();
  }

  @Bean
  SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http
        .authorizeHttpRequests(authorize -> authorize
            .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()

            .requestMatchers("/login", "/register", "/", "/product/**", "/products/**", "/api/product/{id}",
                "/api/product/search", "/client/**", "/css/**", "/images/**", "/js/**")
            .permitAll()

            .requestMatchers("/admin/**", "/api/order/update").hasRole("Admin")

            .anyRequest().authenticated())

        .formLogin(formLogin -> formLogin
            .loginPage("/login")
            .failureUrl("/login?error")
            // .defaultSuccessUrl("/product/3")
            .successHandler(GetCustomAuthenticationSuccessHandler())
            .permitAll())

        .logout(logout -> logout
            .logoutSuccessHandler(GetCustomLogoutSuccessHandler()).permitAll()
            .deleteCookies("JSESSIONID").invalidateHttpSession(true))

        .exceptionHandling(ex -> ex.accessDeniedPage("/access-deny")
            .defaultAuthenticationEntryPointFor(getCustomAuthenticationEntryPoint(),
                new AntPathRequestMatcher("/**")))

        .sessionManagement((sessionManagement) -> sessionManagement
            .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
            /*
             * Khồng dùng .invalidSessionUrl() vì đã dùng CustomAuthenticationEntryPoint để
             * handle AJAX request khi session invalid
             */
            // .invalidSessionUrl("/login?expired")
            .maximumSessions(1)
            .maxSessionsPreventsLogin(false))

        .rememberMe(rememberMe -> rememberMe
            .rememberMeServices(rememberMeServices()));

    return http.build();
  }

}