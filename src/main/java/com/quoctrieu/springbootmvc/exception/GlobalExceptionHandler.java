package com.quoctrieu.springbootmvc.exception;

import java.net.URL;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

  @Value("${spring.servlet.multipart.max-file-size}")
  private String maxFileSize;

  @ExceptionHandler(MaxUploadSizeExceededException.class)
  public String handleFileUploadSizeExceed(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("errorMessage", "File ảnh không vượt quá " + maxFileSize);
    String referer = request.getHeader("Referer");
    try {
      URL url = new URL(referer);
      return "redirect:" + url.getPath();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "redirect:/";
  }

}
