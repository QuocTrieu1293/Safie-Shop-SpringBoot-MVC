package com.quoctrieu.springbootmvc.config;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.LinkedHashSet;
import java.util.Optional;
import java.util.Set;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.core.io.UrlResource;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.repository.UserRepository;
import com.quoctrieu.springbootmvc.service.RoleService;

import jakarta.servlet.ServletContext;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

  private final UserRepository userRepository;
  private final PasswordEncoder passwordEncoder;
  private final RoleService roleService;
  private final ServletContext servletContext;

  public CustomOAuth2UserService(UserRepository userRepository, PasswordEncoder passwordEncoder,
      RoleService roleService, ServletContext servletContext) {
    this.userRepository = userRepository;
    this.passwordEncoder = passwordEncoder;
    this.roleService = roleService;
    this.servletContext = servletContext;
  }

  @Override
  public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
    OAuth2User oauth2User = super.loadUser(userRequest);
    String registrationId = userRequest.getClientRegistration().getRegistrationId();

    String email = oauth2User.getAttribute("email");
    if (email == null) {
      OAuth2Error error = new OAuth2Error("email_notfound",
          "Không tìm thấy email (Trường hợp đăng nhập bằng Github có thể do chưa set public email cho profile Github)",
          null);
      throw new OAuth2AuthenticationException(error);
    }

    User user = userRepository.findByEmail(email);
    if (user == null) {
      String password = RandomStringUtils.randomAlphanumeric(8, 16);
      String encodedPassword = passwordEncoder.encode(password);

      user = new User(
          email, encodedPassword,
          Optional.ofNullable((String) oauth2User.getAttribute("name"))
              .orElse(registrationId.equals("github") ? oauth2User.getAttribute("login") : email),
          null, null, null, userRequest.getClientRegistration().getClientName());

      user.setRole(roleService.findByName("User"));

      try {
        UrlResource avatarResource = new UrlResource(
            (String) oauth2User.getAttribute(registrationId.equals("github") ? "avatar_url" : "picture"));
        String fileName = StringUtils.cleanPath(avatarResource.getFilename());
        String fileExtension = StringUtils.getFilenameExtension(fileName);
        if (fileExtension == null)
          fileExtension = "png";
        fileName = StringUtils.stripFilenameExtension(fileName);

        File serverFile = new File(servletContext.getRealPath("/resources/images/avatar" + File.separator
            + System.currentTimeMillis() + "-" + fileName + "." + fileExtension));
        serverFile.mkdirs();

        Files.copy(avatarResource.getInputStream(), serverFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        user.setAvatar(serverFile.getName());
      } catch (Exception e) {
        e.printStackTrace();
      }

      user.setEnabled(true);

      user = userRepository.save(user);
    } else if (!user.isEnabled()) {
      user.setEnabled(true);
      user = userRepository.save(user);
    }

    Set<GrantedAuthority> authorities = new LinkedHashSet<>(oauth2User.getAuthorities());
    authorities.add(new SimpleGrantedAuthority("ROLE_" + user.getRole().getName()));

    String userNameAttributeName = userRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint()
        .getUserNameAttributeName();
    if (registrationId.equals("google") || registrationId.equals("github"))
      userNameAttributeName = "email";

    return new DefaultOAuth2User(authorities, oauth2User.getAttributes(), userNameAttributeName);
  }

}
