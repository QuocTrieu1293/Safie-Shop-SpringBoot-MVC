package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.hoidanit.laptopshop.service.FileService;

@Controller
@RequestMapping("/admin/utils")
public class UtilsController {

  private final FileService fileService;

  public UtilsController(FileService fileService) {
    this.fileService = fileService;
  }

  @GetMapping("clear-images")
  public String clearImages(@RequestHeader(value = "referer", required = false) String referer) {
    long num = fileService.clearImages();
    System.out.println(num);
    return "redirect:referer" + (referer != null ? referer : "/admin");
  }

}
