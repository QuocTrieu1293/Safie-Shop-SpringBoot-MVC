package vn.hoidanit.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class UserService {
  private final UserRepository userRepository;

  public UserService(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  public User handleSaveUser(User user) {
    User saved_user = userRepository.save(user);
    return saved_user;
  }

  public List<User> getAll() {
    List<User> userList = userRepository.findAll();
    return userList;
  }

  public User get(long id) {
    User user = userRepository.findById(id).orElse(null);
    return user;
  }
}
