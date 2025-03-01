package com.quoctrieu.springbootmvc.service;

import java.util.List;
import java.util.stream.Collectors;

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

  public List<AddressDTO> findByUser(Long userId) {
    List<Address> addressList = addressRepo.findByUser(userId); // Nếu không tìm được trả về list rỗng (size = 0)
    List<AddressDTO> dtoList = addressList.stream().map(addr -> new AddressDTO(addr)).collect(Collectors.toList());
    return dtoList;
  }

  public AddressDTO findDefaultByUser(Long userId) {
    Address address = addressRepo.findDefaultByUser(userId);
    AddressDTO addressDTO = new AddressDTO(address);
    return addressDTO;
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

  public boolean existsByUserId(Long userId) {
    boolean isExist = addressRepo.existsByUserId(userId);
    return isExist;
  }

}
