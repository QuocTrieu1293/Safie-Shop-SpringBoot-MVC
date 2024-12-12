package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Role;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class UserService {
  private final UserRepository userRepository;
  private final PasswordEncoder passwordEncoder;

  public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
    this.userRepository = userRepository;
    this.passwordEncoder = passwordEncoder;
  }

  public User registerUser(User user) {
    String hashed_password = passwordEncoder.encode(user.getPassword());
    user.setPassword(hashed_password);
    return userRepository.save(user);
  }

  public User updateUser(User user) throws Exception {
    User updatedUser = userRepository.findById(user.getId()).orElse(null);
    // Role role1 = user.getRole(); // null
    // Role role2 = updatedUser.getRole(); // null
    // String name1 = role1.getName(); //null
    // String name2 = role2.getName(); //có kết quả do FetchType.LAZY, dữ liệu chỉ
    // được nạp khi được truy cập
    if (updatedUser == null)
      throw new Exception("cannot find user with id = " + user.getId());

    updatedUser.setPhone(user.getPhone());
    updatedUser.setFullName(user.getFullName());
    updatedUser.setAddress(user.getAddress());
    updatedUser.setRole(user.getRole());
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

  public boolean emailExists(String email) {
    return userRepository.existsByEmail(email);
  }

}
