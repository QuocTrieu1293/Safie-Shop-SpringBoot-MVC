package com.quoctrieu.springbootmvc.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.quoctrieu.springbootmvc.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long>, JpaSpecificationExecutor<User> {
  User save(User user);

  List<User> findAll();

  Optional<User> findById(Long id);

  void deleteById(Long id);

  boolean existsByEmail(String email);

  User findByEmail(String email);

}
