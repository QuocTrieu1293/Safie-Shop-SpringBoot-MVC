package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("clientProductController")
public class ProductController {

  @GetMapping("/product/{id}")
  public String getProductPage(@PathVariable long id) {
    return "client/product/detail";
  }

}
