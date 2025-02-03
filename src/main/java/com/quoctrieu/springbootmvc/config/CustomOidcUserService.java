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
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserRequest;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.oidc.user.DefaultOidcUser;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.util.StringUtils;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.repository.RoleRepository;
import com.quoctrieu.springbootmvc.service.UserService;

import jakarta.servlet.ServletContext;

public class CustomOidcUserService extends OidcUserService {

  private final UserService userService;
  private final RoleRepository roleRepository;
  private final ServletContext servletContext;

  public CustomOidcUserService(UserService userService, RoleRepository roleRepository, ServletContext servletContext) {
    this.userService = userService;
    this.roleRepository = roleRepository;
    this.servletContext = servletContext;
  }

  @Override
  public OidcUser loadUser(OidcUserRequest userRequest) throws OAuth2AuthenticationException {
    OidcUser oidcUser = super.loadUser(userRequest);

    String email = oidcUser.getEmail();
    if (email == null) {
      OAuth2Error error = new OAuth2Error("email_notfound",
          "Không tìm thấy email (Trường hợp đăng nhập bằng Github có thể do chưa set public email cho profile Github)",
          null);
      throw new OAuth2AuthenticationException(error);
    }

    User user = userService.getUserByEmail(email);
    if (user == null) {
      String password = RandomStringUtils.randomAlphanumeric(8);
      user = new User(
          email,
          password,
          Optional.ofNullable(oidcUser.getFullName()).orElse(email),
          null,
          null);
      user.setAuthenProvider(userRequest.getClientRegistration().getClientName());
      user.setRole(roleRepository.findByName("User"));
      try {
        UrlResource avatarResource = new UrlResource(oidcUser.getPicture());
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

      user = userService.registerUser(user);
    }

    Set<GrantedAuthority> authorities = new LinkedHashSet<>(oidcUser.getAuthorities());
    authorities.add(new SimpleGrantedAuthority("ROLE_" + user.getRole().getName()));

    String userNameAttributeName = userRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint()
        .getUserNameAttributeName(); // mặc định với Google là "sub"
    String registrationId = userRequest.getClientRegistration().getRegistrationId();
    if (registrationId.equals("google") || registrationId.equals("github"))
      userNameAttributeName = "email";

    return StringUtils.hasText(userNameAttributeName)
        ? new DefaultOidcUser(authorities, userRequest.getIdToken(),
            oidcUser.getUserInfo(), userNameAttributeName)
        : new DefaultOidcUser(authorities, userRequest.getIdToken(),
            oidcUser.getUserInfo());
  }

}
