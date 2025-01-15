package com.quoctrieu.springbootmvc.domain.dto;

public class ProductCriteriaDTO {
  private String page = "1";

  private int pageSize = 4;

  private String category;

  private String[] brands;

  private String brand;

  private String price;

  private String[] sizes;

  private String sort = "noi-bat";

  private String search;

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
    if (category != null && category.toLowerCase().equals("all"))
      category = null;
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

  public String getBrand() {
    return brand;
  }

  public void setBrand(String brand) {
    if (brand != null && brand.toLowerCase().equals("all"))
      brand = null;
    this.brand = brand;
  }

  public int getPageSize() {
    return pageSize;
  }

  public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
  }

  public String getSearch() {
    return search;
  }

  public void setSearch(String search) {
    this.search = search;
  }

}
