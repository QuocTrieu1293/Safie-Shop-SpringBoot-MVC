package vn.hoidanit.laptopshop.domain.dto;

import vn.hoidanit.laptopshop.domain.Size;

public class SizeDTO {

  long id;
  String name;

  public SizeDTO(Size size) {
    id = size.getId();
    name = size.getName();
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

}
