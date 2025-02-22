<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
<link href="/client/css/style.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> -->
<!-- Navbar start-->

<!-- Dùng thẻ script trong file .jsp để có thể lấy được các giá trị truyền qua model từ Controller -->
<script>
  const userId = "${userId}"; // Dùng để check user có login hay chưa trong file js. userId được vào session khi đăng nhập thành công.
  const errorMessage = "${errorMessage}";
  const successMessage = "${successMessage}";
</script>

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
          ><a href="mailto:safie.shop.babycloth@gmail.com" class="text-white"
            >safie.shop.babycloth@gmail.com</a
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
        <div class="navbar-nav fw-medium">
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
                  class="position-absolute bg-warning rounded-circle align-items-center justify-content-center text-dark px-1 ${cartSum > 0 ? 'd-flex' : 'd-none'}"
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
                  style="max-width: 235px"
                >
                  <li class="text-center mb-2">
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
                    <!-- biến fullName lấy từ session. Nếu có biến trùng tên thì dùng sessionScope.fullName -->
                    <div class="text-truncate mt-2">${fullName}</div>
                  </li>

                  <li>
                    <a
                      class="dropdown-item"
                      href="/profile/account"
                      style="text-align: justify"
                      >Quản lý tài khoản</a
                    >
                  </li>

                  <li>
                    <a
                      class="dropdown-item"
                      href="/profile/order-history"
                      style="text-align: justify"
                      >Lịch sử mua hàng</a
                    >
                  </li>
                  <li>
                    <hr class="dropdown-divider" />
                  </li>
                  <li>
                    <form
                      action="/logout"
                      method="post"
                      class="text-center"
                      style="text-align: justify"
                    >
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
<div
  class="modal fade"
  id="searchModal"
  tabindex="-1"
  aria-labelledby="searchModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-fullscreen-sm-down modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="searchModalLabel">
          Tìm Sản phẩm theo từ khoá
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
          <!-- Search input -->
          <div class="form-control d-flex align-items-center p-2 mb-3">
            <input
              id="product-search"
              type="text"
              class="my-search-input"
              placeholder="Nhập từ khoá cần tìm ..."
              spellcheck="false"
              autocomplete="off"
            />
            <i
              id="product-search-clear"
              class="bi bi-x-circle-fill ps-1"
              style="font-size: 16px; line-height: 0"
              role="button"
            ></i>
            <i
              id="product-search-btn"
              class="fas fa-search px-2"
              style="font-size: 18px"
              role="button"
            ></i>
          </div>

          <!-- Search history -->
          <div id="product-search-history" class="d-none">
            <div class="mb-1 d-flex justify-content-between">
              <h5 class="fw-bold text-uppercase">Lịch sử tìm kiếm</h5>
              <span
                id="product-search-history-clear"
                role="button"
                class="link-secondary fw-medium"
                style="font-size: 14px"
                >Xoá lịch sử</span
              >
            </div>
            <div class="ps-2">
              <!-- <div
                class="d-flex align-items-center mb-2 px-2 py-1 list-group-item-action rounded"
                role="button"
              >
                <i class="bi bi-clock me-2"></i>Trương Công Quốc Triệu
                <i class="bi bi-x ms-auto link-secondary d-none"></i>
              </div> -->
            </div>
          </div>

          <!-- Suggestion searched products -->
          <div id="product-search-suggest" class="d-none">
            <h5 class="mb-1 fw-bold">Sản phẩm đề xuất</h5>
            <div>
              <!-- <a href="/product/{id}" class="row mx-auto mb-2 g-3">
                <div class="col-3">
                  <img
                    src="/images/product/1734890654888-artboard-1-copy-b06f179c-e008-4fd0-a687-c0b0e990bc27.webp"
                    alt="product name"
                    class="w-100"
                    style="object-fit: cover"
                  />
                </div>
                <div class="col">
                  <h6 class="my-card-title">
                    Quần áo trẻ em Bobicraft - Đầm đô bèo tay dài - Cotton hữu
                    cơ organic an toàn
                  </h6>
                  <p class="fw-medium mb-0" style="color: black">
                    <fmt:formatNumber type="number" value="292500.0" />
                    đ
                  </p>
                </div>
              </a> -->
            </div>
          </div>

          <!-- Search not found -->
          <div id="search-not-found" class="d-none">
            <p class="fw-medium">
              <i class="bi bi-search me-2 text-primary"></i>Không tìm thấy kết
              quả với từ khóa
              <b class="fw-bold" style="color: black">"<span>...</span>"</b>
            </p>
            <hr class="my-2" />
            <ul style="font-size: 14px">
              <li>Kiểm tra lỗi chính tả với từ khoá đã nhập</li>
              <li>Liên hệ để nhận hỗ trợ</li>
            </ul>
          </div>

          <!-- Loading spinner -->
          <div id="search-loading-spinner" class="text-center">
            <div class="spinner-border text-primary m-2" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Modal Search End -->

<div
  class="modal fade"
  id="alert-modal"
  tabindex="-1"
  aria-labelledby="alert-modal-label"
  aria-hidden="true"
>
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body">
        <div class="text-center p-3">
          <span id="alert-modal-icon"><i class="bi bi-check-circle"></i></span>
          <p id="alert-modal-message" class="fs-4">
            Alert modal message goes here
          </p>
        </div>
      </div>
    </div>
  </div>
</div>
