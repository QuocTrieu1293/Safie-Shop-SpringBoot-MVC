package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Role;
import vn.hoidanit.laptopshop.repository.RoleRepository;

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
