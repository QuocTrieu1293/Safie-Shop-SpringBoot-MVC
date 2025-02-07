package com.quoctrieu.springbootmvc.controller.client;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.Page;
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

import com.quoctrieu.springbootmvc.domain.Order;
import com.quoctrieu.springbootmvc.domain.User;
import com.quoctrieu.springbootmvc.domain.dto.AccountInfoDTO;
import com.quoctrieu.springbootmvc.domain.dto.OrderCriteriaDTO;
import com.quoctrieu.springbootmvc.service.FileService;
import com.quoctrieu.springbootmvc.service.FileService.Type;
import com.quoctrieu.springbootmvc.service.OrderService;
import com.quoctrieu.springbootmvc.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/profile")
public class ProfileController {

  private final OrderService orderService;
  private final UserService userService;
  private final FileService fileService;

  public ProfileController(OrderService orderService, UserService userService, FileService fileService) {
    this.orderService = orderService;
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
    // nhận giá trị "email" từ form -> backed
    // form Object có email = null
    binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
  }

  @GetMapping("/account")
  public String getAccountInfoPage(Model model, HttpSession session) {
    Long userId = (Long) session.getAttribute("userId");
    User user = userService.get(userId);
    AccountInfoDTO accountInfo = new AccountInfoDTO(user);

    model.addAttribute("user", accountInfo);

    return "client/profile/account/show";
  }

  @PostMapping("/account")
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

  @GetMapping("/account/address")
  public String getAddressBookPage() {
    return "client/profile/account/addressBook";
  }

  @GetMapping("/account/password")
  public String getChangePasswordPage() {
    return "client/profile/account/changePassword";
  }

  @GetMapping("/order-history")
  public String getOrderHistoryPage(Model model, OrderCriteriaDTO orderCriteria, HttpServletRequest request) {

    HttpSession session = request.getSession(false);
    long userId = (long) session.getAttribute("userId");
    orderCriteria.setUserId(userId);
    orderCriteria.setPageSize(3);

    Page<Order> pagedOrder = orderService.getPageWithSpec(orderCriteria);
    List<Order> orders = pagedOrder.getContent();
    model.addAttribute("orders", orders);
    model.addAttribute("totalPages", pagedOrder.getTotalPages());
    model.addAttribute("currentPage", pagedOrder.getNumber() + 1);

    String queryString = request.getQueryString();
    if (queryString != null) {
      queryString = queryString.replace("page=" + (pagedOrder.getNumber() + 1), "");
      if (!queryString.isBlank() && !queryString.startsWith("&"))
        queryString = "&" + queryString;
    }
    model.addAttribute("queryString", queryString);

    return "client/profile/orderHistory";
  }

}
