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
    <!-- <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css
    "
    /> -->

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
    <link rel="stylesheet" href="/css/mycss.css" />
  </head>

  <body class="bg-gray-white">
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

    <div
      class="container container-fluid py-md-4"
      style="margin-top: 180px; min-height: 85vh"
    >
      <div class="row flex-nowrap">
        <div class="col-auto">
          <jsp:include page="./sideNav.jsp" />
        </div>
        <div class="col" style="min-width: 830px">
          <div class="p-4 pb-5">
            <div class="row justify-content-between mb-3">
              <div class="col-auto">
                <h5 class="fs-3">Đơn hàng của tôi</h5>
              </div>
              <div class="col-auto">
                <div
                  class="d-flex align-items-center p-2 rounded-pill"
                  style="background-color: #eaeaea; width: 400px"
                >
                  <input
                    type="text"
                    id="search-input"
                    class="my-search-input ps-3"
                    placeholder="Tìm theo mã đơn (vd: #123) hoặc tên sản phẩm"
                    spellcheck="false"
                    autocomplete="off"
                  />
                  <i
                    class="bi bi-x-circle-fill ps-1"
                    style="font-size: 16px; line-height: 0"
                    role="button"
                  ></i>
                  <i
                    class="fas fa-search px-2"
                    style="font-size: 18px"
                    role="button"
                  ></i>
                </div>
              </div>
            </div>

            <!-- Nav tab  -->
            <div
              class="d-flex mb-3 bg-info rounded-top"
              style="font-size: 16px; font-weight: 500"
            >
              <ul
                id="status-filter"
                class="nav my-nav-underline nav-fill gap-0 flex-nowrap overflow-x-auto"
              >
                <li class="nav-item" style="min-width: 144px">
                  <a class="nav-link p-3" role="button" data-status="all"
                    >Tất cả</a
                  >
                </li>
                <li class="nav-item" style="min-width: 144px">
                  <a class="nav-link p-3" role="button" data-status="PENDING"
                    >Đang xử lý</a
                  >
                </li>
                <li class="nav-item" style="min-width: 144px">
                  <a class="nav-link p-3" role="button" data-status="SHIPPING"
                    >Đang giao</a
                  >
                </li>
                <li class="nav-item" style="min-width: 144px">
                  <a class="nav-link p-3" role="button" data-status="COMPLETE"
                    >Hoàn tất</a
                  >
                </li>
                <li class="nav-item" style="min-width: 144px">
                  <a class="nav-link p-3" role="button" data-status="CANCEL"
                    >Đã huỷ</a
                  >
                </li>
              </ul>
            </div>

            <c:choose>
              <c:when test="${not empty orders}">
                <div class="row mb-5">
                  <div class="col">
                    <c:forEach var="order" items="${orders}">
                      <div class="card mb-3" data-order-id="${order.id}">
                        <div class="card-header d-flex">
                          <span
                            ><small
                              ><b>Mã đơn hàng:</b> #${order.id}</small
                            ></span
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
                                    <a href="/product/${item.product.id}">
                                      <img
                                        src="/images/product/${item.product.image}"
                                        alt=""
                                        style="
                                          width: 100px;
                                          aspect-ratio: 1 / 1;
                                        "
                                      />
                                    </a>
                                  </div>
                                  <div
                                    class="col d-flex justify-content-between"
                                  >
                                    <div
                                      class="flex-grow-1"
                                      style="max-width: 60%"
                                    >
                                      <p class="card-title my-card-title">
                                        <a
                                          href="/product/${item.product.id}"
                                          style="color: black"
                                          >${item.product.name}</a
                                        >
                                      </p>
                                      <div class="card-subtitle row gx-3">
                                        <small class="col-auto">
                                          <b>Thương hiệu:</b>
                                          ${item.product.brand.name}
                                        </small>
                                        <small class="col-auto">
                                          <b>Danh mục:</b>
                                          ${item.product.category.name}
                                        </small>
                                        <small class="col-auto">
                                          <b>Size:</b> ${item.size.name}
                                        </small>
                                      </div>
                                      <p style="color: black">
                                        x${item.quantity}
                                      </p>
                                    </div>
                                    <div
                                      class="text-center align-content-center"
                                    >
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
                              <c:if
                                test="${order.paymentStatus == 'PAYMENT_SUCCEED'}"
                              >
                                <div
                                  class="text-success d-flex align-items-center"
                                >
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
                                <span class="text-primary fs-5 fw-bold">
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
                  </div>
                </div>

                <!-- Pagination -->
                <nav aria-label="Order history pages navigation">
                  <ul
                    class="pagination justify-content-center"
                    style="display: flex"
                  >
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                      <a
                        class="page-link"
                        href="/profile/order-history?page=${currentPage - 1}${queryString}"
                        aria-label="Previous"
                      >
                        <i class="bi bi-chevron-left"></i>
                      </a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                      <li
                        class="page-item ${currentPage == loop.index ? 'active' : ''}"
                      >
                        <a
                          class="page-link"
                          href="/profile/order-history?page=${loop.index}${queryString}"
                          >${loop.index}</a
                        >
                      </li>
                    </c:forEach>
                    <li
                      class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                    >
                      <a
                        class="page-link"
                        href="/profile/order-history?page=${currentPage + 1}${queryString}"
                        aria-label="Next"
                      >
                        <i class="bi bi-chevron-right"></i>
                      </a>
                    </li>
                  </ul>
                </nav>
              </c:when>
              <c:when test="${not empty queryString}">
                <div class="d-flex flex-column align-items-center">
                  <img src="/images/others/E-Commerce 03.png" alt="" />
                  <p class="fw-bold fs-5">Không tìm thấy đơn hàng phù hợp.</p>
                </div>
              </c:when>
              <c:otherwise>
                <div class="text-center py-5">
                  <span>
                    <img
                      src="/images/others/empty_order_history.png"
                      alt=""
                      style="width: 200px"
                    />
                  </span>
                  <h4 class="mt-4">Bạn không có đơn hàng nào</h4>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <script>
      const url = new URL(window.location.href);
      const searchParams = url.searchParams;

      function searchOrder(keyword) {
        if (keyword) searchParams.set("search", keyword);
        else searchParams.delete("search");

        searchParams.delete("page");
        window.location.href = url.toString();
      }

      $(document).ready(function () {
        const activeStatus = searchParams.has("status")
          ? $(
              '#status-filter a.nav-link[data-status="' +
                searchParams.get("status") +
                '"]'
            )
          : $('#status-filter a.nav-link[data-status="all"]');
        activeStatus.addClass("active");
        activeStatus.attr("aria-current", "true");

        $("#search-input").val(searchParams.get("search"));

        $("#status-filter a.nav-link").click(function () {
          const status = $(this).data("status");

          if (status === "all") searchParams.delete("status");
          else searchParams.set("status", $(this).data("status"));

          searchParams.delete("page");
          window.location.href = url.toString();
        });

        $("#search-input")
          .siblings("i.fa-search[role='button']")
          .click(function () {
            searchOrder($("#search-input").val().trim());
          });

        const clearSearch = $("#search-input").siblings(
          "i.bi-x-circle-fill[role='button']"
        );
        if (!$("#search-input").val()) clearSearch.addClass("d-none");
        $("#search-input").on("input", function (e) {
          const val = $(this).val();
          // console.log($(this).val());
          if (val && clearSearch.hasClass("d-none")) {
            clearSearch.removeClass("d-none");
          } else if (!val && !clearSearch.hasClass("d-none")) {
            clearSearch.addClass("d-none");
          }
        });
        $("#search-input").keydown(function (e) {
          if (e.key === "Enter") {
            searchOrder($("#search-input").val().trim());
          }
        });
        clearSearch.click(function () {
          $("#search-input").val("");
          clearSearch.addClass("d-none");
          $("#search-input").focus();
        });
      });
    </script>
  </body>
</html>
