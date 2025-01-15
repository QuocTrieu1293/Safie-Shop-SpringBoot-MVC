package com.quoctrieu.springbootmvc.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import com.quoctrieu.springbootmvc.service.FileService;

@Controller
@RequestMapping("/admin/utils")
public class UtilsController {

  private final FileService fileService;

  public UtilsController(FileService fileService) {
    this.fileService = fileService;
  }

  @GetMapping("clear-images")
  public String clearImages(@RequestHeader("Referer") String referer) {
    long num = fileService.clearImages();
    System.out.println(">>> CLEAR IMAGES: " + num);
    return "redirect:" + (referer == null ? "/admin" : referer);
  }

}
