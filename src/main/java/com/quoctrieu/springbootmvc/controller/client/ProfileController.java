package com.quoctrieu.springbootmvc.controller.client;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.dto.AccountInfoDTO;
import com.quoctrieu.springbootmvc.service.FileService;
import com.quoctrieu.springbootmvc.service.FileService.Type;
import com.quoctrieu.springbootmvc.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/profile/account")
public class ProfileController {

  private final UserService userService;
  private final FileService fileService;

  public ProfileController(UserService userService, FileService fileService) {
    this.userService = userService;
    this.fileService = fileService;

  }

  @Value("${spring.servlet.multipart.max-file-size}")
  private String fileMaxSize;

  @ModelAttribute("fileMaxSize")
  public Integer addFileMaxSize() {
    try {
      int maxSize = Integer.parseInt(fileMaxSize.substring(0, fileMaxSize.length() - 2));
      return maxSize;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }

  @InitBinder
  void initBinder(WebDataBinder binder) {
    // binder.setAllowedFields("fullName", "phone", "avatar", "gender"); // Không
    // nhận giá trị "email" từ form -> backed form Object có email = null
    binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
  }

  @GetMapping("")
  public String getAccountInfoPage(Model model, HttpSession session) {
    Long userId = (Long) session.getAttribute("userId");
    User user = userService.get(userId);
    AccountInfoDTO accountInfo = new AccountInfoDTO(user);

    model.addAttribute("user", accountInfo);

    return "client/profile/account/show";
  }

  @PostMapping("")
  public String updateAccountInfo(@Valid @ModelAttribute("user") AccountInfoDTO formUser, BindingResult bindingResult,
      @RequestParam("avatarFile") MultipartFile file, HttpSession session, RedirectAttributes redirectAttributes) {

    // bindingResult.rejectValue("phone", "testCode", "test123");
    if (bindingResult.hasErrors()) {
      bindingResult.getFieldErrors().forEach(error -> System.out
          .println(">>> ERR updateAccountInfo: " + error.getField() + " - " + error.getDefaultMessage()));
      return "client/profile/account/show";
    }

    Long userId = (Long) session.getAttribute("userId");
    User user = userService.get(userId);

    // xoá avatar
    if (formUser.getAvatar() == null) {
      boolean isDeleteFile = fileService.deleteImage(user.getAvatar(), Type.AVATAR);
      user.setAvatar(null);

    }

    // cập nhật avatar mới
    if (!file.isEmpty()) {
      String avatar = fileService.saveImage(file, Type.AVATAR);
      user.setAvatar(avatar);
    }

    user.setFullName(formUser.getFullName());
    user.setPhone(formUser.getPhone());
    user.setGender(formUser.getGender());

    try {
      user = userService.updateUser(user);
      session.setAttribute("fullName", user.getFullName());
      session.setAttribute("avatar", user.getAvatar());
    } catch (Exception e) {
      redirectAttributes.addFlashAttribute("errorMessage", "Cập nhật thông tin tài khoản thất bại");
      return "redirect:/profile/account";
    }

    redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thông tin tài khoản thành công");

    return "redirect:/profile/account";
  }

}
