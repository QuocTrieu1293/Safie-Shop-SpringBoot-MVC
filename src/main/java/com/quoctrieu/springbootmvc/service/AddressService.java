package com.quoctrieu.springbootmvc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.quoctrieu.springbootmvc.domain.Address;
import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.dto.AddressDTO;
import com.quoctrieu.springbootmvc.repository.AddressRepository;

@Service
public class AddressService {

  private AddressRepository addressRepo;

  public AddressService(AddressRepository addressRepo) {
    this.addressRepo = addressRepo;
  }

  public List<AddressDTO> findByUserId(Long userId) {
    List<Address> addressList = addressRepo.findByUser(userId);
    List<AddressDTO> dtoList = addressList.stream().map(addr -> new AddressDTO(addr)).toList();
    return dtoList;
  }

  public AddressDTO findById(Long id, Long userId) {
    Address address = addressRepo.findById(id).orElse(null);
    if (address == null)
      return new AddressDTO();

    User user = address.getUser();
    if (user.getId() != userId)
      return new AddressDTO();

    return new AddressDTO(address);
  }

  public void create(AddressDTO dto, Long userId) {
    User user = new User(userId);
    Address address = new Address(dto);
    address.setUser(user);
    address = addressRepo.save(address);
  }

  public void update(Long id, AddressDTO dto, Long userId) {
    Address address = addressRepo.findById(id).orElse(null);
    if (address == null)
      return;
    User user = address.getUser();
    if (user.getId() != userId)
      return;

    Address updatedAddress = new Address(dto);
    updatedAddress.setId(id);
    updatedAddress.setUser(user);
    updatedAddress = addressRepo.save(updatedAddress);
  }

  public void delete(Long id, Long userId) {
    Address address = addressRepo.findById(id).orElse(null);
    if (address == null)
      return;
    User user = address.getUser();
    if (user.getId() != userId)
      return;
    addressRepo.deleteById(id);
  }

}
