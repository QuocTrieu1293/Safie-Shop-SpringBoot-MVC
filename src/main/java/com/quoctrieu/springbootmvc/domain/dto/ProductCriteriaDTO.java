package com.quoctrieu.springbootmvc.domain.dto;

public class ProductCriteriaDTO {
  private String page = "1";

  private String category;

  private String[] brands;

  private String price;

  private String[] sizes;

  private String sort = "noi-bat";

  public String getPage() {
    return page;
  }

  public void setPage(String page) {
    this.page = page;
  }

  public String getCategory() {
    return category;
  }

  public void setCategory(String category) {
    this.category = category;
  }

  public String[] getBrands() {
    return brands;
  }

  public void setBrands(String[] brands) {
    this.brands = brands;
  }

  public String getPrice() {
    return price;
  }

  public void setPrice(String price) {
    this.price = price;
  }

  public String[] getSizes() {
    return sizes;
  }

  public void setSizes(String[] sizes) {
    this.sizes = sizes;
  }

  public String getSort() {
    return sort;
  }

  public void setSort(String sort) {
    this.sort = sort;
  }

}
