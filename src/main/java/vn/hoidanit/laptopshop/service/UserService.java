package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Role;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.RoleRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class UserService {
  private final UserRepository userRepository;
  private final PasswordEncoder passwordEncoder;
  private final RoleRepository roleRepository;

  public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, RoleRepository roleRepository) {
    this.userRepository = userRepository;
    this.passwordEncoder = passwordEncoder;
    this.roleRepository = roleRepository;
  }

  public User registerUser(User user) {
    String roleName = user.getRole().getName();
    Role role = roleRepository.findFirstByName(roleName);
    String hashed_password = passwordEncoder.encode(user.getPassword());
    user.setRole(role);
    user.setPassword(hashed_password);
    return userRepository.save(user);
  }

  public User updateUser(User user) throws Exception {
    User updatedUser = userRepository.findById(user.getId()).orElse(null);

    if (updatedUser == null)
      throw new Exception("cannot find user with id = " + user.getId());

    updatedUser.setPhone(user.getPhone());
    updatedUser.setFullName(user.getFullName());
    updatedUser.setAddress(user.getAddress());

    String roleName = user.getRole().getName();
    Role role = roleRepository.findFirstByName(roleName);
    updatedUser.setRole(role);

    updatedUser.setAvatar(user.getAvatar());

    return userRepository.save(updatedUser);

  }

  public List<User> getAll() {
    List<User> userList = userRepository.findAll();
    return userList;
  }

  public User get(long id) {
    User user = userRepository.findById(id).orElse(null);
    return user;
  }

  public void delete(long id) {
    userRepository.deleteById(id);
  }
}
