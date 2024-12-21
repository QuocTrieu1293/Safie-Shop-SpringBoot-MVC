<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://sargue.net/jsptags/time" prefix="javatime" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Lịch sử đơn hàng</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
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

    <style>
      #search-input {
        border: none;
        flex-grow: 1;
        outline: none;
        background-color: transparent;
      }

      .card-title {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        margin-bottom: 0.5rem;
      }
    </style>
  </head>

  <body>
    <c:set var="view" value="orderHistory" scope="session" />

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
      <div class="container py-4">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-3">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item active">Lịch sử đơn hàng</li>
          </ol>
        </nav>
        <c:choose>
          <c:when test="${not empty orders}">
            <div
              class="d-flex align-items-center p-2 mb-4"
              style="background-color: #eaeaea; border-radius: 5px"
            >
              <i class="fas fa-search px-2 fs-5"></i>
              <input
                type="text"
                id="search-input"
                placeholder="Bạn có thể tìm kiếm theo ID Đơn Hàng hoặc Tên Sản Phẩm"
                spellcheck="false"
              />
            </div>
            <c:forEach var="order" items="${orders}">
              <div class="card mb-3" data-order-id="${order.id}">
                <div class="card-header d-flex">
                  <span
                    ><small><b>Mã đơn hàng:</b> #${order.id}</small></span
                  >
                  <span class="ms-5 fw-bold"
                    ><small
                      ><javatime:format
                        value="${order.date}"
                        pattern="dd/MM/yyyy HH:mm" /></small
                  ></span>
                  <span class="ms-auto text-primary fw-bold"
                    >${order.status}</span
                  >
                </div>
                <div class="card-body">
                  <div class="row gy-2">
                    <c:forEach var="item" items="${order.orderDetails}">
                      <div class="col-12">
                        <div class="row gx-3">
                          <div class="col-auto">
                            <img
                              src="/images/product/${item.product.image}"
                              alt=""
                              style="width: 100px; aspect-ratio: 1 / 1"
                            />
                          </div>
                          <div class="col d-flex justify-content-between">
                            <div class="flex-grow-1" style="max-width: 60%">
                              <p class="card-title">
                                <a
                                  href="/product/${item.product.id}"
                                  style="color: black"
                                  >${item.product.name}</a
                                >
                              </p>
                              <div class="card-subtitle row gx-3">
                                <small class="col-auto">
                                  <b>Thương hiệu:</b> ${item.product.brand.name}
                                </small>
                                <small class="col-auto">
                                  <b>Danh mục:</b> ${item.product.category.name}
                                </small>
                                <small class="col-auto">
                                  <b>Size:</b> ${item.size.name}
                                </small>
                              </div>
                              <p style="color: black">x${item.quantity}</p>
                            </div>
                            <div class="text-center align-content-center">
                              <p class="text-nowrap text-primary">
                                <fmt:formatNumber
                                  type="number"
                                  value="${item.productPrice}"
                                />
                                đ
                              </p>
                            </div>
                          </div>
                        </div>
                      </div>
                      <hr />
                    </c:forEach>
                    <div class="col-12 d-flex">
                      <c:if test="${order.paymentStatus == 'PAYMENT_SUCCEED'}">
                        <div class="text-success d-flex align-items-center">
                          <i
                            class="bi bi-check2-circle"
                            style="font-size: 18px"
                          ></i>
                          <span class="ms-1">Đã thanh toán</span>
                        </div>
                      </c:if>
                      <div class="ms-auto">
                        <span style="color: black" class="me-2"
                          >Thành tiền:</span
                        >
                        <span class="text-primary fs-5">
                          <fmt:formatNumber
                            type="number"
                            value="${order.totalPrice}"
                          />
                          đ
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="text-center py-5">
              <span
                ><img
                  src="/images/others/empty_order_history.png"
                  alt=""
                  style="width: 100px; object-fit: cover"
              /></span>
              <h4>Bạn không có đơn hàng nào</h4>
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
        $("#search-input").focus(function () {
          $(this).siblings("i").css("color", "#212121");
        });

        $("#search-input").blur(function () {
          $(this).siblings("i").css("color", "");
        });

        $("#search-input").keypress(function (e) {
          if (e.key === "Enter") {
            $(this).blur(); // trigger blur event on search input
            const keyword = $(this).val();
            $.get("/api/order/search", { keyword }, (response) => {
              // console.log(response); // an array of order ids
              $(".card[data-order-id]").each(function (index, element) {
                const id = $(element).data("order-id"); // hoặc dùng $(this)
                $(element).css(
                  "display",
                  response.includes(id) ? "block" : "none"
                );
              });
            });
          }
        });
      });
    </script>
  </body>
</html>
