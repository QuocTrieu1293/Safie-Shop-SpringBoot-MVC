package com.quoctrieu.springbootmvc.domain.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class OrderCriteriaDTO {

  private Long userId;
  private String page = "1";
  private int pageSize = 3;
  private String status = "all";
  private String search;
  private LocalDateTime from;
  private LocalDateTime to;
  private String sort = "default";

  public Long getUserId() {
    return userId;
  }

  public void setUserId(Long userId) {
    this.userId = userId;
  }

  public String getPage() {
    return page;
  }

  public void setPage(String page) {
    this.page = page;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getSearch() {
    return search;
  }

  public void setSearch(String search) {
    this.search = search;
  }

  public LocalDateTime getFrom() {
    return from;
  }

  public void setFrom(LocalDate from) {
    if (from != null)
      this.from = from.atStartOfDay();
  }

  public LocalDateTime getTo() {
    return to;
  }

  public void setTo(LocalDate to) {
    if (to != null)
      this.to = to.atTime(23, 59, 59, 999_999_999);
  }

  public String getSort() {
    return sort;
  }

  public void setSort(String sort) {
    this.sort = sort;
  }

  public int getPageSize() {
    return pageSize;
  }

  public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
  }

}
