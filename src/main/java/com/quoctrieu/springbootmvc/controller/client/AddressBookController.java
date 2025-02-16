package com.quoctrieu.springbootmvc.controller.client;

import java.util.List;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.dto.AddressDTO;
import com.quoctrieu.springbootmvc.service.AddressService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/profile/account/address")
public class AddressBookController {

  private final AddressService addressService;

  public AddressBookController(AddressService addressService) {
    this.addressService = addressService;
  }

  @InitBinder
  void initBinder(WebDataBinder binder) {
    binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
  }

  @ModelAttribute("addressList")
  List<AddressDTO> getAddressList(HttpSession session) {
    Long userId = (Long) session.getAttribute("userId");
    List<AddressDTO> addressList = addressService.findByUser(userId);
    return addressList;
  }

  @GetMapping("")
  public String getAddressBookPage(Model model) {
    model.addAttribute("addressDto", new AddressDTO());

    return "client/profile/account/addressBook";
  }

  @PostMapping("")
  public String createAddress(@Valid @ModelAttribute("addressDto") AddressDTO dto,
      BindingResult bindingResult, HttpSession session, Model model, RedirectAttributes redirectAttributes) {

    // return "client/profile/account/addressBook";
    if (bindingResult.hasErrors()) {
      boolean shouldRedirect = false;
      for (FieldError error : bindingResult.getFieldErrors()) {
        System.out.println(">>> ERR createAddress: " + error.getField() + " - " + error.getDefaultMessage());
        if (error.getField().equals("cityId") || error.getField().equals("districtId")
            || error.getField().equals("wardId")) {
          shouldRedirect = true;
        }
      }

      if (shouldRedirect) {
        redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại!");
        return "redirect:/profile/account/address";
      }
      return "client/profile/account/addressBook";
    }

    Long userId = (Long) session.getAttribute("userId");
    addressService.create(dto, userId);
    return "redirect:/profile/account/address";
  }

  @PostMapping("/update/{id}")
  public String updateAddress(@PathVariable Long id, @Valid @ModelAttribute("addressDto") AddressDTO dto,
      BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes, HttpSession session) {

    if (bindingResult.hasErrors()) {
      boolean shouldRedirect = false;
      for (FieldError error : bindingResult.getFieldErrors()) {
        System.out.println(">>> ERR createAddress: " + error.getField() + " - " + error.getDefaultMessage());
        if (error.getField().equals("cityId") || error.getField().equals("districtId")
            || error.getField().equals("wardId")) {
          shouldRedirect = true;
        }
      }

      if (shouldRedirect) {
        redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại!");
        return "redirect:/profile/account/address";
      }
      model.addAttribute("formAction", "/profile/account/address/update/" + id);
      return "client/profile/account/addressBook";
    }

    Long userId = (Long) session.getAttribute("userId");
    addressService.update(id, dto, userId);
    return "redirect:/profile/account/address";
  }

  @PostMapping("/delete/{id}")
  public String deleteAddress(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
    Long userId = (Long) session.getAttribute("userId");
    addressService.delete(id, userId);
    return "redirect:/profile/account/address";
  }

}
