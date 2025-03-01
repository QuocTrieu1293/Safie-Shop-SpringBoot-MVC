package com.quoctrieu.springbootmvc.service;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Role;
import com.quoctrieu.springbootmvc.repository.RoleRepository;

@Service
public class RoleService {

  private final String CACHE_NAME = "roles";
  private final RoleRepository repo;

  public RoleService(RoleRepository repo) {
    this.repo = repo;
  }

  @Cacheable(value = CACHE_NAME, key = "'all'")
  public List<Role> getAll() {
    return repo.findAll();
  }

  @Cacheable(CACHE_NAME)
  public Role findByName(String name) {
    return repo.findByName(name);
  }

}
