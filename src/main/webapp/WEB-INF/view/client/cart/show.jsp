<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Chi tiết giỏ hàng</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />

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

    <!-- Cart Page Start -->

    <div class="container-fluid" style="margin-top: 180px">
      <div class="container py-md-4">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-5">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item active">Giỏ hàng</li>
          </ol>
        </nav>
        <c:choose>
          <c:when test="${not empty cartItems}">
            <div class="table-responsive">
              <table class="table">
                <thead>
                  <tr class="">
                    <th scope="col" class="text-nowrap" style="width: 150px">
                      Sản phẩm
                    </th>
                    <th scope="col" class="text-nowrap" style="width: 30%">
                      Tên
                    </th>
                    <th scope="col" class="text-nowrap">Size</th>
                    <th scope="col" class="text-nowrap">Đơn giá</th>
                    <th scope="col" class="text-nowrap">Số lượng</th>
                    <th scope="col" class="text-nowrap">Thành tiền</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="item" items="${cartItems}">
                    <tr data-cart-detail-id="${item.id}">
                      <th scope="row">
                        <div
                          class="d-flex align-items-center"
                          style="width: 150px"
                        >
                          <img
                            src="/images/product/${item.product.image}"
                            class="img-fluid rounded-circle m-2"
                            style="
                              width: 100px;
                              height: 100px;
                              object-fit: cover;
                            "
                            alt=""
                          />
                        </div>
                      </th>
                      <td style="min-width: 200px">
                        <p class="mb-0 mt-4">
                          <a href="/product/${item.product.id}" target="_blank">
                            ${item.product.name}
                          </a>
                        </p>
                      </td>
                      <td class="text-nowrap">
                        <p class="mb-0 mt-4">${item.size.name}</p>
                      </td>
                      <td class="text-nowrap">
                        <p class="mb-0 mt-4">
                          <fmt:formatNumber
                            type="number"
                            value="${item.product.price}"
                          />
                          đ
                        </p>
                      </td>
                      <td>
                        <div
                          class="input-group quantity mt-4"
                          style="width: 100px"
                        >
                          <div class="input-group-btn">
                            <button
                              class="btn btn-sm btn-minus rounded-circle bg-light border"
                            >
                              <i class="fa fa-minus"></i>
                            </button>
                          </div>
                          <input
                            type="text"
                            class="form-control form-control-sm text-center border-0"
                            value="${item.quantity}"
                            data-cart-detail-id="${item.id}"
                            data-cart-detail-price="${item.product.price}"
                          />
                          <div class="input-group-btn">
                            <button
                              class="btn btn-sm btn-plus rounded-circle bg-light border"
                            >
                              <i class="fa fa-plus"></i>
                            </button>
                          </div>
                        </div>
                      </td>
                      <td class="text-nowrap">
                        <p class="mb-0 mt-4" data-cart-detail-id="${item.id}">
                          <fmt:formatNumber
                            type="number"
                            value="${item.price}"
                          />
                          đ
                        </p>
                      </td>
                      <td>
                        <button
                          data-cart-detail-id="${item.id}"
                          class="btn btn-md rounded-circle bg-secondary border mt-4 delete-cart-detail"
                        >
                          <i class="fa fa-times" style="color: #ef4b4b"></i>
                        </button>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            <div class="row g-4 justify-content-end">
              <div class="col-8"></div>
              <div class="col-sm-8 col-md-7 col-lg-6">
                <div class="bg-light rounded fw-bold">
                  <div class="p-4">
                    <h1 class="display-6 mb-4">
                      Thông tin <span class="fw-normal">đơn hàng</span>
                    </h1>
                    <div
                      class="d-flex justify-content-between mb-4 align-items-center"
                    >
                      <h5 class="mb-0 me-4">Tạm tính:</h5>
                      <p class="mb-0 fs-5" data-cart-total-price>
                        <fmt:formatNumber type="number" value="${totalPrice}" />
                        đ
                      </p>
                    </div>

                    <div
                      class="d-flex justify-content-between align-items-center"
                    >
                      <h5 class="mb-0 me-4">Phí vận chuyển:</h5>
                      <div class="">
                        <p class="mb-0 fs-5">
                          <fmt:formatNumber type="number" value="0" />
                          đ
                        </p>
                      </div>
                    </div>
                  </div>
                  <div
                    class="py-4 mb-4 border-top border-bottom d-flex justify-content-between align-items-center"
                  >
                    <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                    <p class="mb-0 pe-4 fs-3" data-cart-total-price>
                      <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                    </p>
                  </div>
                  <a
                    href="/checkout"
                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                    type="button"
                  >
                    Xác nhận đặt hàng
                  </a>
                </div>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-center">
              <span
                ><img
                  src="/images/others/empty_cart.jpg"
                  alt=""
                  style="width: 300px; object-fit: cover"
              /></span>
              <h3>Bạn hiện không có sản phẩm trong giỏ hàng</h3>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <!-- Cart Page End -->

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

    <script>
      $(document).ready(function () {
        $(".quantity button")
          .off("click")
          .on("click", function (e) {
            // console.log("hello");
            const button = $(this);
            const oldValue = button.parent().parent().find("input").val();
            let newVal = null;
            if (button.hasClass("btn-plus")) {
              newVal = parseFloat(oldValue) + 1;
            } else if (oldValue > 0) {
              newVal = parseFloat(oldValue) - 1;
            }
            const input = button.parent().parent().find("input");
            const id = input.attr("data-cart-detail-id");

            updateQuantity(
              id,
              newVal,
              function ({ quantity, cartDetailPrice }) {
                if (quantity > 0) {
                  input.val(quantity);
                  $("p[data-cart-detail-id=" + id + "]").text(
                    new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(parseFloat(cartDetailPrice))
                  );
                } else {
                  $("tr[data-cart-detail-id=" + id + "]").remove();
                }
              }
            );
          });

        $("button.delete-cart-detail")
          .off("click")
          .on("click", function (e) {
            console.log("delete");
            const id = $(this).attr("data-cart-detail-id");

            updateQuantity(id, 0, function ({ quantity, cartDetailPrice }) {
              $("tr[data-cart-detail-id=" + id + "]").remove();
            });
          });
      });

      function updateQuantity(cartDetailId, quantity, callback) {
        $.ajax({
          url: "/api/cart/update-quantity",
          method: "POST",
          data: {
            cartDetailId: cartDetailId,
            quantity: quantity,
          },
          timeout: 600000,
          beforeSend: function (xhr) {
            // Retrieve CSRF token and header name from meta tags
            const csrfToken = $("meta[name='_csrf']").attr("content");
            const csrfHeader = $("meta[name='_csrf_header']").attr("content");

            // Set the CSRF token in the request header
            xhr.setRequestHeader(csrfHeader, csrfToken);
          },
          success: function (response) {
            ({ totalPrice, cartSum } = response);
            if (cartSum == 0) {
              location.reload();
            } else {
              callback(response);

              // update total price ui
              $(`p[data-cart-total-price]`).text(
                new Intl.NumberFormat("vi-VN", {
                  style: "currency",
                  currency: "VND",
                }).format(parseFloat(totalPrice))
              );

              // update session ui
              $("#cart-sum").text(cartSum);
            }
          },
        });
      }
    </script>
  </body>
</html>
