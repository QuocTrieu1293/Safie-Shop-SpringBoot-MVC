package com.quoctrieu.springbootmvc.service;

import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.VerifyUserToken;
import com.quoctrieu.springbootmvc.repository.UserRepository;
import com.quoctrieu.springbootmvc.repository.VerifyUserTokenRepository;

@Service
public class VerifyUserTokenService {

  // private final int TOKEN_LIFE_TIME_MINUTES = 30;

  private final VerifyUserTokenRepository verifyTokenRepo;
  private final UserRepository userRepository;

  public VerifyUserTokenService(VerifyUserTokenRepository verifyTokenRepo, UserRepository userRepository) {
    this.verifyTokenRepo = verifyTokenRepo;
    this.userRepository = userRepository;
  }

  public VerifyUserToken createToken(User user) {
    if (user == null)
      return null;
    VerifyUserToken verifyToken = new VerifyUserToken();
    verifyToken.setUser(user);

    String token = UUID.randomUUID().toString();
    verifyToken.setToken(token);

    // LocalDateTime expiration =
    // LocalDateTime.now().plusMinutes(TOKEN_LIFE_TIME_MINUTES);
    // verifyToken.setExpiration(expiration);

    verifyToken = verifyTokenRepo.save(verifyToken);

    return verifyToken;
  }

  @Transactional
  public void verifyToken(String token) throws Exception {
    VerifyUserToken verifyToken = verifyTokenRepo.findByToken(token);
    User user = verifyToken.getUser();
    user.setEnabled(true);
    userRepository.save(user);
    verifyTokenRepo.delete(verifyToken);
  }
}
