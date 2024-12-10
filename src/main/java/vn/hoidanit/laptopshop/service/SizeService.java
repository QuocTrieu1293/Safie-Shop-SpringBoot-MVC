package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Size;
import vn.hoidanit.laptopshop.repository.SizeRepository;

@Service
public class SizeService {
  private final SizeRepository repo;

  public SizeService(SizeRepository repo) {
    this.repo = repo;
  }

  public List<Size> getAll() {
    return repo.findAll();
  }
}
