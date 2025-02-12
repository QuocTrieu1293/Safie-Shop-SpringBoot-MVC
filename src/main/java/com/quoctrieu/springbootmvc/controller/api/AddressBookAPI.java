package com.quoctrieu.springbootmvc.controller.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quoctrieu.springbootmvc.domain.dto.AddressDTO;
import com.quoctrieu.springbootmvc.service.AddressService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/address")
public class AddressBookAPI {

  private final AddressService addressService;

  public AddressBookAPI(AddressService addressService) {
    this.addressService = addressService;
  }

  @GetMapping("/{id}")
  public AddressDTO getAddressJson(@PathVariable Long id, HttpSession session) {
    Long userId = (Long) session.getAttribute("userId");
    AddressDTO dto = addressService.findById(id, userId);
    return dto;
  }
}
