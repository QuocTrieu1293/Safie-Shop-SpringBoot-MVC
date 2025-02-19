package com.quoctrieu.springbootmvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.quoctrieu.springbootmvc.domain.VerifyUserToken;

@Repository
public interface VerifyUserTokenRepository extends JpaRepository<VerifyUserToken, Long> {

  VerifyUserToken findByToken(String token);

  VerifyUserToken findByUserId(Long userId);

}
