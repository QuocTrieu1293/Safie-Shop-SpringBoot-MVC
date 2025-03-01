<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="p-2" style="width: 235px">
  <div class="d-flex gap-2">
    <a href="/profile/account"
      ><img
        src="/images/avatar/${not empty avatar ? avatar : 'user_placeholder.png'}"
        alt="user avatar"
        style="aspect-ratio: 1 / 1; width: 45px; object-fit: cover"
        class="rounded-circle"
    /></a>
    <div class="d-flex flex-column text-truncate">
      <span class="fw-bold d-inline-block text-truncate" style="color: black"
        >${fullName}</span
      >
      <span style="font-size: 14px"
        ><a href="/profile/account" class="text-body"
          ><i class="bi bi-pen-fill"></i> Sửa hồ sơ</a
        ></span
      >
    </div>
  </div>
  <hr />
  <ul class="text-capitalize nav flex-column fw-medium">
    <li class="nav-item">
      <a
        href="/profile/account"
        class="d-flex align-items-center gap-1 nav-link"
        ><i class="bi bi-person text-blue fs-5"></i> Tài khoản của tôi</a
      >
      <ul class="ps-4 nav flex-column fw-normal">
        <li class="nav-item">
          <a href="/profile/account" class="nav-link py-1">Hồ sơ</a>
        </li>
        <li class="nav-item">
          <a href="/profile/account/address" class="nav-link py-1"
            >Sổ địa chỉ</a
          >
        </li>
        <li class="nav-item">
          <a href="/profile/account/password" class="nav-link py-1"
            >Đổi mật khẩu</a
          >
        </li>
      </ul>
    </li>
    <li class="nav-item">
      <a
        href="/profile/order-history"
        class="d-flex align-items-center gap-1 nav-link"
        ><i class="bi bi-clipboard2-check fs-5 text-success"></i> Đơn mua</a
      >
    </li>
  </ul>
</nav>
