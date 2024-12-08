package vn.hoidanit.laptopshop.service;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class FileService {

  private final ServletContext servletContext;

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

  public FileService(ServletContext servletContext) {
    this.servletContext = servletContext;
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
    } catch (IOException e) {
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

}
