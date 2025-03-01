package com.quoctrieu.springbootmvc.domain.dto;

import java.util.Arrays;

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

  // Cần override hashCode() và equals() để làm key cho cache
  @Override
  public int hashCode() {
    final int prime = 83;
    int result = 1;
    result = prime * result + ((page == null) ? 0 : page.hashCode());
    result = prime * result + pageSize;
    result = prime * result + ((category == null) ? 0 : category.hashCode());
    result = prime * result + Arrays.hashCode(brands);
    result = prime * result + ((brand == null) ? 0 : brand.hashCode());
    result = prime * result + ((price == null) ? 0 : price.hashCode());
    result = prime * result + Arrays.hashCode(sizes);
    result = prime * result + ((sort == null) ? 0 : sort.hashCode());
    result = prime * result + ((search == null) ? 0 : search.hashCode());
    return result;
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    ProductCriteriaDTO other = (ProductCriteriaDTO) obj;
    if (page == null) {
      if (other.page != null)
        return false;
    } else if (!page.equals(other.page))
      return false;
    if (pageSize != other.pageSize)
      return false;
    if (category == null) {
      if (other.category != null)
        return false;
    } else if (!category.equals(other.category))
      return false;
    if (!Arrays.equals(brands, other.brands))
      return false;
    if (brand == null) {
      if (other.brand != null)
        return false;
    } else if (!brand.equals(other.brand))
      return false;
    if (price == null) {
      if (other.price != null)
        return false;
    } else if (!price.equals(other.price))
      return false;
    if (!Arrays.equals(sizes, other.sizes))
      return false;
    if (sort == null) {
      if (other.sort != null)
        return false;
    } else if (!sort.equals(other.sort))
      return false;
    if (search == null) {
      if (other.search != null)
        return false;
    } else if (!search.equals(other.search))
      return false;
    return true;
  }

}
