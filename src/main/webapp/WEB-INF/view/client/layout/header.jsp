<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!-- <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
<link href="/client/css/style.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> -->
<!-- Navbar start-->

<div class="container-fluid fixed-top px-0">
  <div
    class="mb-1"
    style="
      background-color: #cbab91;
      text-align: center;
      font-size: 12px;
      color: white;
    "
  >
    <strong>Miễn phí vận chuyển</strong> toàn quốc
  </div>
  <div class="container topbar bg-primary d-none d-lg-block">
    <div class="d-flex justify-content-between">
      <div class="top-info ps-2">
        <small class="me-3"
          ><i class="fas fa-map-marker-alt me-2 text-warning"></i>
          <a
            href="https://maps.app.goo.gl/2HUaojpnK1GcmKHw7"
            class="text-white"
            target="_blank"
            >Đường Hàn Thuyên, khu phố 6, Tp Thủ Đức</a
          ></small
        >
        <small class="me-3"
          ><i class="fas fa-envelope me-2 text-warning"></i
          ><a href="mailto:21522714@gm.uit.edu.vn" class="text-white"
            >contact@safie.com</a
          ></small
        >
      </div>
      <div class="top-link pe-2">
        <a href="#" class="text-white"
          ><small class="text-white mx-2">Chính sách đổi trả</small>/</a
        >
        <a href="#" class="text-white"
          ><small class="text-white mx-2">Chính sách vận chuyển</small></a
        >
      </div>
    </div>
  </div>
  <div class="container px-0">
    <nav class="navbar navbar-light bg-white navbar-expand-xl">
      <a href="/" class="navbar-brand"
        ><img
          src="/images/others/logo.png"
          alt="Safie brand"
          style="height: 76px; object-fit: contain"
      /></a>
      <button
        class="navbar-toggler py-2 px-3"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarCollapse"
        aria-controls="navbarCollapse"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="fa fa-bars text-primary"></span>
      </button>
      <div
        class="collapse navbar-collapse bg-white justify-content-between px-3"
        id="navbarCollapse"
      >
        <div class="navbar-nav fw-bold">
          <a href="/" class="nav-item nav-link">Trang chủ</a>
          <a href="/products" class="nav-item nav-link">Sản phẩm</a>
          <!-- <a href="shop-detail.html" class="nav-item nav-link "></a> -->
          <a href="#" class="nav-item nav-link">Liên hệ</a>
          <div class="nav-item dropdown">
            <a
              href="#"
              class="nav-link dropdown-toggle"
              data-bs-toggle="dropdown"
              aria-expanded="false"
              >Khác</a
            >
            <div class="dropdown-menu m-0 bg-secondary rounded-0">
              <a href="#" class="dropdown-item">Giới thiệu</a>
              <a href="#" class="dropdown-item">Bài viết</a>
              <a href="#" class="dropdown-item">Đánh giá từ khách hàng</a>
            </div>
          </div>
          <!-- <div style="color: red">${view}</div> -->
        </div>
        <div class="d-flex m-3 me-0 align-items-center">
          <button
            class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
            data-bs-toggle="modal"
            data-bs-target="#searchModal"
          >
            <i class="fas fa-search text-primary"></i>
          </button>

          <c:choose>
            <c:when test="${not empty pageContext.request.userPrincipal}">
              <a href="/cart" class="position-relative me-4 my-auto">
                <i class="fa fa-shopping-bag fa-2x"></i>
                <span
                  id="cart-sum"
                  class="position-absolute bg-warning rounded-circle align-items-center justify-content-center text-dark px-1 ${cartSum > 0 ? 'd-flex' : 'd-none'} fw-bold"
                  style="top: -5px; left: 15px; height: 20px; min-width: 20px"
                  >${cartSum}</span
                >
              </a>
              <div class="dropdown my-auto">
                <a
                  href="#"
                  class="dropdown-toggle"
                  role="button"
                  id="dropdownMenuLink"
                  aria-expanded="false"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  <i class="fas fa-user fa-2x"></i>
                </a>

                <ul
                  class="dropdown-menu dropdown-menu-end p-4"
                  aria-labelledby="dropdownMenuLink"
                >
                  <li
                    class="d-flex align-items-center flex-column"
                    style="min-width: 200px"
                  >
                    <img
                      style="
                        width: 85px;
                        height: 85px;
                        border-radius: 50%;
                        overflow: hidden;
                        object-fit: cover;
                      "
                      src="/images/avatar/${not empty avatar ? avatar : 'user_placeholder.png'}"
                    />
                    <div class="text-center my-3">
                      <!-- biến fullName lấy từ session. Nếu có biến trùng tên thì dùng sessionScope.fullName -->
                      <span> ${fullName}</span>
                    </div>
                  </li>

                  <li>
                    <a class="dropdown-item" href="#">Quản lý tài khoản</a>
                  </li>

                  <li>
                    <a class="dropdown-item" href="/order-history"
                      >Lịch sử mua hàng</a
                    >
                  </li>
                  <li>
                    <hr class="dropdown-divider" />
                  </li>
                  <li>
                    <form action="/logout" method="post">
                      <input
                        type="hidden"
                        name="${_csrf.parameterName}"
                        value="${_csrf.token}"
                      />
                      <button class="dropdown-item">Đăng xuất</button>
                    </form>
                  </li>
                </ul>
              </div>
            </c:when>
            <c:otherwise> <a href="/login">Đăng nhập</a></c:otherwise>
          </c:choose>
        </div>
      </div>
    </nav>
  </div>
</div>
<!-- Navbar End -->

<!-- Modal Search Start -->
<!-- <div
  class="modal fade"
  id="searchModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-fullscreen">
    <div class="modal-content rounded-0">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">
          Tìm kiếm bằng từ khoá
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body d-flex align-items-center">
        <div class="input-group w-75 mx-auto d-flex">
          <input
            type="search"
            class="form-control p-3"
            placeholder="Nhập từ khoá tìm kiếm ..."
            aria-describedby="search-icon-1"
          />
          <span id="search-icon-1" class="input-group-text p-3"
            ><i class="fa fa-search"></i
          ></span>
        </div>
      </div>
    </div>
  </div>
</div> -->
<!-- Modal Search End -->
