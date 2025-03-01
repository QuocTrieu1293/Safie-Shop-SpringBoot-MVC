package com.quoctrieu.springbootmvc.exception;

import java.net.URL;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

  private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

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

  @ExceptionHandler(Exception.class)
  public ModelAndView handleError(Exception e) {
    logger.error(">>> Lỗi nè !!!!", e);

    ModelAndView mav = new ModelAndView("error");
    mav.addObject("exception", e);
    return mav;
  }

}
