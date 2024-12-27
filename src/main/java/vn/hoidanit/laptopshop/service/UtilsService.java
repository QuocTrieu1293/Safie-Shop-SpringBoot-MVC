package vn.hoidanit.laptopshop.service;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@Service
public class UtilsService {

  public PageRequest getPageRequest(String page, int size) {
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
