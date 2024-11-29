package vn.hoidanit.laptopshop.repository;

import org.springframework.data.repository.CrudRepository;

import vn.hoidanit.laptopshop.domain.User;

public interface UserRepository extends CrudRepository<User, Long> {
  // User save(User user);
}
