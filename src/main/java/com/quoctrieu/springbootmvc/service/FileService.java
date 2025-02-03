package com.quoctrieu.springbootmvc.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class FileService {

  private final ServletContext servletContext;
  private final UserService userService;
  private final ProductService productService;

  public enum Type {
    AVATAR("avatar"),
    PRODUCT("product");

    private final String DIR_NAME;

    Type(String dirName) {
      this.DIR_NAME = dirName;
    }

    @Override
    public String toString() {
      return DIR_NAME;
    }

  }

  public FileService(ServletContext servletContext, UserService userService, ProductService productService) {
    this.servletContext = servletContext;
    this.userService = userService;
    this.productService = productService;

  }

  public String saveImage(MultipartFile file, Type type) {
    String fileName = null;
    if (file.isEmpty())
      return fileName;

    String rootPath = servletContext.getRealPath("/resources/images");
    try {
      File serverFile = new File(
          rootPath + File.separator + type + File.separator + System.currentTimeMillis()
              + "-" + file.getOriginalFilename());
      serverFile.mkdirs();

      file.transferTo(serverFile); // exception khi file.isEmpty() == true
      fileName = serverFile.getName();
    } catch (Exception e) {
      e.printStackTrace();
    }

    return fileName;
  }

  public boolean deleteImage(String fileName, Type type) {
    if (fileName == null || fileName.isEmpty()) {
      return false;
    }
    String rootPath = servletContext.getRealPath("/resources/images");
    File serverFile = new File(
        rootPath + File.separator + type + File.separator + fileName);
    return serverFile.delete();
  }

  public long clearImages() {
    int num = 0;
    String rootPath = servletContext.getRealPath("/resources/images");
    Type[] arrType = Type.values();
    for (int i = 0; i < arrType.length; i++) {
      File dir = new File(rootPath + File.separator + arrType[i]);
      List<String> filenames = null;
      if (arrType[i] == Type.AVATAR) {
        filenames = userService.getAll().stream().map(user -> user.getAvatar()).toList();
      } else {
        filenames = productService.getAll().stream().map(product -> product.getImage()).toList();
      }

      final List<String> final_filenames = new ArrayList<>(filenames);
      final_filenames.add("user_placeholder.png");
      File[] deletedFiles = dir.listFiles((file, name) -> !final_filenames.contains(name));

      for (int j = 0; j < deletedFiles.length; j++) {
        num += deletedFiles[j].delete() ? 1 : 0;
      }

    }
    return num;
  }

}
