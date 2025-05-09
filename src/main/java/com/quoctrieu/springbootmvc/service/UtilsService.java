package com.quoctrieu.springbootmvc.service;

import org.springframework.data.domain.PageRequest;

public class UtilsService {

  public static PageRequest getPageRequest(String page, int size) {
    int pageNumber = 0;
    try {
      pageNumber = Integer.parseInt(page) - 1;
      pageNumber = Math.max(0, pageNumber); // Tránh trường hợp người dùng truyền ?page= số ấm
    } catch (NumberFormatException e) {
      e.printStackTrace();
    }

    PageRequest pageable = PageRequest.of(pageNumber, size);

    return pageable;
  }

}
