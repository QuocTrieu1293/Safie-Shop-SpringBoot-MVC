<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Đặt hàng</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap"
      rel="stylesheet"
    />

    <!-- Icon Font Stylesheet -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"
      integrity="sha512-5Hs3dF2AEPkpNAR7UiOHba+lRSJNeM2ECkwxUIxC1Q/FLycGTbNapWXB4tP889k5T5Ju8fs4b1P5z/iB4nMfSQ=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link
      href="/client/lib/owlcarousel/assets/owl.carousel.min.css"
      rel="stylesheet"
    />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet" />
  </head>

  <body>
    <!-- Spinner Start -->
    <div
      id="spinner"
      class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../layout/header.jsp" />

    <!-- Checkout Page Start -->
    <div class="container-fluid" style="margin-top: 180px">
      <div class="container py-md-4">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-5">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item">
              <a href="/cart">Giỏ hàng</a>
            </li>
            <li class="breadcrumb-item active">Đặt hàng</li>
          </ol>
        </nav>
        <h1 class="mb-4">Thông tin đơn hàng</h1>
        <form:form
          action="/checkout"
          method="post"
          id="form"
          modelAttribute="checkoutDTO"
        >
          <div class="row g-5">
            <div class="col-md-12 col-lg-5">
              <div class="row g-5">
                <div class="form-item col-12">
                  <label class="form-label fw-bold" for="fullName"
                    >Họ tên người nhận<sup>*</sup></label
                  >
                  <form:input
                    type="text"
                    class="form-control"
                    required="true"
                    path="fullName"
                    id="fullName"
                    value="${cart.user.fullName}"
                    spellcheck="false"
                  />
                </div>

                <div class="form-item col-12">
                  <label class="form-label fw-bold" for="address"
                    >Địa chỉ nhận hàng <sup>*</sup></label
                  >
                  <form:input
                    type="text"
                    class="form-control"
                    placeholder="Số nhà tên đường"
                    id="address"
                    path="address"
                    required="true"
                    value="${cart.user.address}"
                    spellcheck="false"
                  />
                </div>

                <div class="form-item col-12">
                  <label class="form-label fw-bold" for="phone"
                    >Số điện thoại<sup>*</sup></label
                  >
                  <form:input
                    id="phone"
                    type="tel"
                    class="form-control"
                    path="phone"
                    required="true"
                    value="${cart.user.phone}"
                  />
                </div>
                <div class="form-item col-12">
                  <label class="form-label fw-bold" for="email"
                    >Email<sup>*</sup></label
                  >
                  <form:input
                    id="email"
                    type="email"
                    class="form-control"
                    required="true"
                    path="email"
                    value="${cart.user.email}"
                  />
                </div>

                <div class="form-item col-12">
                  <form:textarea
                    path="orderNotes"
                    class="form-control"
                    spellcheck="false"
                    cols="30"
                    rows="11"
                    placeholder="Lưu ý đơn hàng (Nếu có)"
                  ></form:textarea>
                </div>
              </div>
            </div>
            <div
              class="col-md-12 col-lg-7 rounded p-5 border-secondary border-1"
              style="background-color: whitesmoke"
            >
              <div class="table-responsive">
                <table class="table">
                  <thead>
                    <tr>
                      <th scope="col" style="width: 120px">Sản phẩm</th>
                      <th scope="col" style="width: 30%">Tên</th>
                      <th scope="col" class="text-nowrap">Đơn giá</th>
                      <th scope="col" class="text-nowrap">Số lượng</th>
                      <th scope="col" class="text-nowrap">Thành tiền</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="item" items="${cart.cartDetails}">
                      <tr>
                        <th scope="row">
                          <div class="d-flex align-items-center mt-3">
                            <img
                              src="/images/product/${item.product.image}"
                              class="img-fluid rounded-circle"
                              style="
                                width: 100px;
                                height: 100px;
                                object-fit: cover;
                              "
                              alt=""
                            />
                          </div>
                        </th>
                        <td class="mt-3">${item.product.name}</td>
                        <td class="mt-3 text-nowrap">
                          <fmt:formatNumber
                            type="number"
                            value="${item.product.price}"
                          />
                          đ
                        </td>
                        <td class="mt-3 text-nowrap text-center">
                          ${item.quantity}
                        </td>
                        <td class="mt-3 text-nowrap">
                          <fmt:formatNumber
                            type="number"
                            value="${item.price}"
                          />
                          đ
                        </td>
                      </tr>
                    </c:forEach>

                    <tr>
                      <th scope="row"></th>
                      <td class="py-5"></td>
                      <td class="py-5"></td>
                      <td class="py-5">
                        <p class="mb-0 text-dark py-3 fw-bold">Tạm tính</p>
                      </td>
                      <td class="py-5">
                        <div class="py-3 border-bottom border-top">
                          <p class="mb-0 text-dark">
                            <fmt:formatNumber
                              type="number"
                              value="${totalPrice}"
                            />
                            đ
                          </p>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th scope="row"></th>
                      <td class="py-5">
                        <p class="mb-0 text-dark py-4 fw-bold">
                          Loại giao hàng
                        </p>
                      </td>
                      <td colspan="3" class="py-5 align-content-center">
                        <div
                          class="form-check d-flex justify-content-end align-items-center"
                        >
                          <input
                            type="checkbox"
                            class="form-check-input bg-primary border-0 m-2"
                            id="Shipping-1"
                            name="Shipping-1"
                            value="Shipping"
                            checked
                            disabled
                          />
                          <label class="form-check-label" for="Shipping-1"
                            >Giao hàng miễn phí</label
                          >
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th scope="row"></th>
                      <td class="py-5">
                        <p class="mb-0 text-dark text-uppercase py-3 fw-bold">
                          Tổng số tiền
                        </p>
                      </td>
                      <td class="py-5"></td>
                      <td class="py-5"></td>
                      <td class="py-5">
                        <div class="py-3 border-bottom border-top">
                          <p class="mb-0 text-dark">
                            <fmt:formatNumber
                              type="number"
                              value="${totalPrice}"
                            />
                            đ
                          </p>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div
                class="row g-4 text-center align-items-center justify-content-center border-bottom py-3"
              >
                <div class="col-12">
                  <div class="form-check text-start my-3 col-auto">
                    <form:radiobutton
                      class="form-check-input bg-primary border-0"
                      id="cod"
                      path="paymentMethod"
                      value="COD"
                      checked="true"
                    />
                    <label class="form-check-label fw-bold fs-6" for="cod"
                      >Thanh toán trực tiếp khi nhận hàng (COD)</label
                    >
                  </div>
                </div>
              </div>
              <div
                class="row g-4 text-center align-items-center justify-content-center border-bottom py-3"
              >
                <div class="col-12">
                  <div class="row">
                    <div class="col-auto d-flex align-items-center">
                      <div class="form-check text-start my-3">
                        <form:radiobutton
                          class="form-check-input bg-primary border-0"
                          id="vnpay"
                          path="paymentMethod"
                          value="VNPAY"
                        />
                        <label class="form-check-label fw-bold fs-6" for="vnpay"
                          >Ví điện tử VNPAY</label
                        >
                      </div>
                    </div>
                    <div class="col-auto">
                      <img
                        src="/images/others/vnpay-logo.jpg"
                        alt=""
                        style="width: 100px; object-fit: cover"
                      />
                    </div>
                  </div>
                </div>
              </div>

              <div
                class="row g-4 text-center align-items-center justify-content-center pt-4"
              >
                <button
                  class="btn py-3 px-4 text-uppercase w-100 text-white fw-bold"
                  style="background-color: #0d6efd"
                >
                  Đặt hàng
                </button>
              </div>
            </div>
          </div>
          <input
            type="hidden"
            name="${_csrf.parameterName}"
            value="${_csrf.token}"
          />
        </form:form>
      </div>
    </div>
    <!-- Checkout Page End -->

    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a
      href="#"
      class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
  </body>
</html>
