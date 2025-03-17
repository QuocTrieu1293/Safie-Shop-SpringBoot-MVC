package com.quoctrieu.springbootmvc.controller.api;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.catalina.connector.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quoctrieu.springbootmvc.domain.dto.AddressDTO;
import com.quoctrieu.springbootmvc.domain.dto.AddressFallbackDTO;
import com.quoctrieu.springbootmvc.service.AddressService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/address")
public class AddressBookAPI {

  static List<AddressFallbackDTO> cities;
  static Map<String, List<AddressFallbackDTO>> districtsMap;
  static Map<String, List<AddressFallbackDTO>> wardsMap;

  static {
    cities = new LinkedList<>(List.of(
        new AddressFallbackDTO("79", "Thành phố Hồ Chí Minh"),
        new AddressFallbackDTO("01", "Thành phố Hà Nội"),
        new AddressFallbackDTO("48", "Thành phố Đà Nẵng")));

    districtsMap = new HashMap<>(Map.of(
        "79", new LinkedList<>(List.of(
            new AddressFallbackDTO("760", "Quận 1"),
            new AddressFallbackDTO("778", "Quận 7"),
            new AddressFallbackDTO("773", "Quận 4"))),

        "01", new LinkedList<>(List.of(
            new AddressFallbackDTO("005", "Quận Cầu Giấy"),
            new AddressFallbackDTO("009", "Quận Thanh Xuân"),
            new AddressFallbackDTO("008", "Quận Hoàng Mai"))),

        "48", new LinkedList<>(List.of(
            new AddressFallbackDTO("493", "Quận Sơn Trà"),
            new AddressFallbackDTO("491", "Quận Thanh Khê"),
            new AddressFallbackDTO("492", "Quận Hải Châu")))));

    wardsMap = new HashMap<>(Map.of(
        "760", new LinkedList<>(List.of(
            new AddressFallbackDTO("26758", "Phường Nguyễn Cư Trinh"),
            new AddressFallbackDTO("26743", "Phường Bến Thành"),
            new AddressFallbackDTO("26755", "Phường Cô Giang"))),

        "778", new LinkedList<>(List.of(
            new AddressFallbackDTO("27490", "Phường Tân Phong"),
            new AddressFallbackDTO("27493", "Phường Phú Mỹ"),
            new AddressFallbackDTO("27472", "Phường Tân Kiểng"))),

        "773", new LinkedList<>(List.of(
            new AddressFallbackDTO("27298", "Phường 01"),
            new AddressFallbackDTO("27292", "Phường 02"),
            new AddressFallbackDTO("27286", "Phường 03"))),

        "005", new LinkedList<>(List.of(
            new AddressFallbackDTO("00166", "Phường Dịch Vọng"),
            new AddressFallbackDTO("00163", "Phường Mai Dịch"),
            new AddressFallbackDTO("00157", "Phường Nghĩa Đô"))),

        "009", new LinkedList<>(List.of(
            new AddressFallbackDTO("00352", "Phường Khương Mai"),
            new AddressFallbackDTO("00373", "Phường Kim Giang"),
            new AddressFallbackDTO("00343", "Phường Nhân Chính"))),

        "008", new LinkedList<>(List.of(
            new AddressFallbackDTO("00322", "Phường Hoàng Văn Thụ"),
            new AddressFallbackDTO("00301", "Phường Thanh Trì"),
            new AddressFallbackDTO("00334", "Phường Trần Phú"))),

        "493", new LinkedList<>(List.of(
            new AddressFallbackDTO("20275", "Phường Phước Mỹ"),
            new AddressFallbackDTO("20263", "Phường Thọ Quang"),
            new AddressFallbackDTO("20269", "Phường Mân Thái"))),

        "491", new LinkedList<>(List.of(
            new AddressFallbackDTO("20224", "Phường An Khê"),
            new AddressFallbackDTO("20203", "Phường Tam Thuận"),
            new AddressFallbackDTO("20209", "Phường Xuân Hà"))),

        "492", new LinkedList<>(List.of(
            new AddressFallbackDTO("20251", "Phường Bình Hiên"),
            new AddressFallbackDTO("20248", "Phường Nam Dương"),
            new AddressFallbackDTO("20242", "Phường Phước Ninh")))));

  }

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

  @GetMapping("/fallback/{param1}/{param2}")
  public ResponseEntity<?> getFallback(@PathVariable String param1, @PathVariable String param2) {
    if (param1.equals("1") && param2.equals("0")) {
      return new ResponseEntity<>(cities, HttpStatus.OK);

    } else if (param1.equals("2")) {
      List<AddressFallbackDTO> districts = districtsMap.get(param2);
      if (districts == null)
        return ResponseEntity.notFound().build();
      return new ResponseEntity<>(districts, HttpStatus.OK);

    } else if (param1.equals("3")) {
      List<AddressFallbackDTO> wards = wardsMap.get(param2);
      if (wards == null)
        return ResponseEntity.notFound().build();
      return new ResponseEntity<>(wards, HttpStatus.OK);

    }

    return ResponseEntity.badRequest().build();
  }
}
