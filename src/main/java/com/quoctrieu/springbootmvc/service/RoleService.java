package com.quoctrieu.springbootmvc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Role;
import com.quoctrieu.springbootmvc.repository.RoleRepository;

@Service
public class RoleService {

  private final RoleRepository repo;

  public RoleService(RoleRepository repo) {
    this.repo = repo;
  }

  public List<Role> getAll() {
    return repo.findAll();
  }

}
