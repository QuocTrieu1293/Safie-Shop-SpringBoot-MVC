<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Trang Sản phẩm</title>
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
      .card-title {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        font-size: 14px;
        letter-spacing: 1px;
        color: #45595b;
      }
    </style>
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

    <!-- Product Page Start -->

    <div class="container-fluid" style="margin-top: 180px">
      <div class="container py-md-4">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-5">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item active">Sản phẩm</li>
          </ol>
        </nav>
        <div class="row g-4">
          <!-- Filter criteria -->
          <div class="col-md-4">
            <form action="#">
              <!-- Category -->
              <div class="row g-2 mb-3" data-filter="0">
                <div class="d-flex justify-content-between">
                  <span class="fw-bold">Danh mục</span>
                  <span
                    role="button"
                    style="color: #dc3545; font-size: 13px"
                    class="fw-bold mt-auto d-none"
                    ><i
                      class="fa-solid fa-xmark me-1"
                      style="font-size: 11px"
                    ></i>
                    Xoá lọc</span
                  >
                </div>
                <c:forEach var="category" items="${categories}">
                  <div class="col-auto">
                    <input
                      type="radio"
                      class="btn-check"
                      id="category_${category.id}"
                      autocomplete="off"
                      name="category"
                    />
                    <label
                      class="btn btn-outline-light-primary fw-normal"
                      style="
                        padding-block: 2px;
                        border-radius: 5px;
                        font-size: 14px;
                      "
                      for="category_${category.id}"
                      >${category.name}</label
                    >
                  </div>
                </c:forEach>
              </div>

              <!-- Brand -->
              <div class="row g-2 mb-3" data-filter="0">
                <div class="d-flex justify-content-between">
                  <span class="fw-bold">Thương hiệu</span>
                  <span
                    role="button"
                    style="color: #dc3545; font-size: 13px"
                    class="fw-bold mt-auto d-none"
                    ><i
                      class="fa-solid fa-xmark me-1"
                      style="font-size: 11px"
                    ></i>
                    Xoá lọc</span
                  >
                </div>
                <c:forEach var="brand" items="${brands}">
                  <div class="col-auto">
                    <input
                      type="checkbox"
                      class="btn-check"
                      id="brand_${brand.id}"
                      autocomplete="off"
                      name="brands"
                    />
                    <label
                      class="btn btn-outline-light-primary fw-normal"
                      style="
                        padding-block: 2px;
                        border-radius: 5px;
                        font-size: 14px;
                      "
                      for="brand_${brand.id}"
                      >${brand.name}</label
                    >
                  </div>
                </c:forEach>
              </div>

              <!-- Price -->
              <div class="row g-2 mb-3" data-filter="0">
                <div class="d-flex justify-content-between">
                  <span class="fw-bold">Mức giá</span>
                  <span
                    role="button"
                    style="color: #dc3545; font-size: 13px"
                    class="fw-bold mt-auto d-none"
                    ><i
                      class="fa-solid fa-xmark me-1"
                      style="font-size: 11px"
                    ></i>
                    Xoá lọc</span
                  >
                </div>

                <div class="col-auto">
                  <input
                    type="radio"
                    class="btn-check"
                    id="lt100"
                    value="lt100"
                    autocomplete="off"
                    name="price"
                  />
                  <label
                    class="btn btn-outline-light-primary fw-normal"
                    style="
                      padding-block: 2px;
                      border-radius: 5px;
                      font-size: 14px;
                    "
                    for="lt100"
                    >Dưới 100 ngàn</label
                  >
                </div>
                <div class="col-auto">
                  <input
                    type="radio"
                    class="btn-check"
                    id="100-300"
                    value="100-300"
                    autocomplete="off"
                    name="price"
                  />
                  <label
                    class="btn btn-outline-light-primary fw-normal"
                    style="
                      padding-block: 2px;
                      border-radius: 5px;
                      font-size: 14px;
                    "
                    for="100-300"
                    >Từ 100 - 300 ngàn</label
                  >
                </div>
                <div class="col-auto">
                  <input
                    type="radio"
                    class="btn-check"
                    id="300-500"
                    value="300-500"
                    autocomplete="off"
                    name="price"
                  />
                  <label
                    class="btn btn-outline-light-primary fw-normal"
                    style="
                      padding-block: 2px;
                      border-radius: 5px;
                      font-size: 14px;
                    "
                    for="300-500"
                    >Từ 300 - 500 ngàn</label
                  >
                </div>
                <div class="col-auto">
                  <input
                    type="radio"
                    class="btn-check"
                    id="gt500"
                    value="gt500"
                    autocomplete="off"
                    name="price"
                  />
                  <label
                    class="btn btn-outline-light-primary fw-normal"
                    style="
                      padding-block: 2px;
                      border-radius: 5px;
                      font-size: 14px;
                    "
                    for="gt500"
                    >Trên 500 ngàn</label
                  >
                </div>
              </div>

              <!-- Size -->
              <div class="row g-2 mb-3" data-filter="0">
                <div class="d-flex justify-content-between">
                  <span class="fw-bold">Size</span>
                  <span
                    role="button"
                    style="color: #dc3545; font-size: 13px"
                    class="fw-bold mt-auto d-none"
                    ><i
                      class="fa-solid fa-xmark me-1"
                      style="font-size: 11px"
                    ></i>
                    Xoá lọc</span
                  >
                </div>
                <c:forEach var="size" items="${sizes}">
                  <div class="col-auto">
                    <input
                      type="checkbox"
                      class="btn-check"
                      id="size_${size.id}"
                      autocomplete="off"
                      name="sizes"
                    />
                    <label
                      class="btn btn-outline-light-primary fw-normal"
                      style="
                        padding-block: 2px;
                        border-radius: 5px;
                        font-size: 14px;
                      "
                      for="size_${size.id}"
                      >${size.name}</label
                    >
                  </div>
                </c:forEach>
              </div>

              <button
                class="text-uppercase rounded-pill btn btn-outline-light-primary border-secondary p-3 fs-5 my-3"
              >
                Lọc sản phẩm
              </button>
            </form>
          </div>

          <!-- Products -->
          <div class="col-md-8">
            <div class="row gx-3 gy-4 mb-5">
              <c:forEach var="product" items="${products}">
                <div class="col-sm-6 col-xl-4">
                  <a href="/product/${product.id}" class="d-block">
                    <div
                      class="rounded position-relative fruite-item h-100 d-flex flex-column"
                    >
                      <div class="fruite-img">
                        <img
                          src="/images/product/${product.image}"
                          class="img-fluid w-100 rounded-top"
                          style="object-fit: cover"
                          alt="product thumbnail"
                        />
                      </div>
                      <div
                        class="text-white fw-bold bg-info px-3 py-1 rounded position-absolute"
                        style="top: 10px; left: 10px"
                      >
                        ${product.brand.name}
                      </div>
                      <div
                        class="p-4 border border-secondary border-top-0 rounded-bottom flex-grow-1 d-flex flex-column"
                      >
                        <div class="mb-3">
                          <a
                            class="text-start fw-bold card-title"
                            href="/product/${product.id}"
                          >
                            ${product.name}
                          </a>
                        </div>
                        <div
                          class="d-flex justify-content-between flex-lg-wrap mt-auto"
                        >
                          <p class="text-dark fs-5 fw-bold mb-0">
                            <fmt:formatNumber
                              type="number"
                              value="${product.price}"
                            />
                            đ
                          </p>
                          <button
                            class="btn border border-secondary rounded-pill px-3 text-primary add-to-cart-btn"
                            style="font-size: 14px"
                            data-product-id="${product.id}"
                          >
                            <i class="fa fa-shopping-bag me-2 text-primary"></i
                            >Thêm vào giỏ hàng
                          </button>
                        </div>
                      </div>
                    </div>
                  </a>
                </div>
              </c:forEach>
            </div>

            <!-- Pagination -->
            <c:if test="${not empty products && totalPages > 1}">
              <nav aria-label="Product pages navigation">
                <ul
                  class="pagination justify-content-center"
                  style="display: flex"
                >
                  <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a
                      class="page-link"
                      href="/products?page=${currentPage - 1}"
                      aria-label="Previous"
                    >
                      <i class="bi bi-chevron-left"></i>
                    </a>
                  </li>
                  <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                    <li
                      class="page-item ${currentPage == loop.index ? 'active' : ''}"
                    >
                      <a class="page-link" href="/products?page=${loop.index}"
                        >${loop.index}</a
                      >
                    </li>
                  </c:forEach>
                  <li
                    class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                  >
                    <a
                      class="page-link"
                      href="/products?page=${currentPage + 1}"
                      aria-label="Next"
                    >
                      <i class="bi bi-chevron-right"></i>
                    </a>
                  </li>
                </ul>
              </nav>
            </c:if>
          </div>
        </div>
      </div>
    </div>

    <!-- Product Page End -->

    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a
      href="#"
      class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- side bar for choosing product size -->
    <jsp:include page="../layout/sizeModal.jsp" />

    <!-- alert modal cho biết thành công/thất bại khi add to cart -->
    <jsp:include page="../layout/alertModal.jsp" />

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <script>
      $(document).ready(function () {
        // change thực hiện element có trigger hành động click
        $("[data-filter] input.btn-check").change(function () {
          const criterion = $(this).closest("[data-filter]");
          criterion.data(
            "filter",
            criterion.data("filter") + ($(this).prop("checked") ? 1 : -1)
          );

          if ($(this).attr("type") === "radio" && criterion.data("filter") > 1)
            criterion.data("filter", 1);

          const clearFilter = criterion.children(":first").children().eq(1); //.eq(1): Lấy phần tử thứ 2
          // console.log(clearFilter);

          const filter = criterion.data("filter");
          // console.log(filter);
          if (filter > 0) clearFilter.removeClass("d-none");
          else clearFilter.addClass("d-none");
        });

        $("[data-filter]").each(function () {
          const criterion = $(this);
          const clearFilter = criterion.children(":first").children().eq(1);
          clearFilter.click(function () {
            const checkedInput = criterion.find("input.btn-check:checked");

            // checkedInput.trigger("click"); // trigger sự kiện change của input.btn-check cài đặt ở trên

            checkedInput.prop("checked", false); // không trigger sự kiện change
            criterion.data("filter", 0); // do không trigger sự kiện change nên phải tự reset giá trị data-filter

            $(this).addClass("d-none"); // Ẩn button clear fiter đi
          });
        });

        // JS cho sizeModal
        if ("${addedProduct}" && "${addedSize}") {
          $("#alert-modal").modal("show");
        }

        $(".add-to-cart-btn").click(function () {
          if ("${userId}") {
            $("#rightSideModal").modal("show");
          } else {
            window.location.href = "/login";
          }
        });

        $(".add-to-cart-btn").click(function () {
          const productId = $(this).data("product-id");

          // Make an AJAX request to fetch the sizes for the selected product
          $.ajax({
            url: "/api/product", // URL to fetch sizes
            method: "GET",
            data: { id: productId },
            timeout: 600000,
            success: function (product) {
              console.log({ product });
              console.log(product.image);
              $("#size-modal-form").attr(
                "action",
                "/add-product-to-cart/" + product.id
              );
              $("#size-modal-img").attr(
                "src",
                "/images/product/" + product.image
              );
              $("#size-modal-name").text(product.name);
              $("#size-modal-brand").text(product.brand);
              const sizeSelect = $("#size-modal-size-radios");
              sizeSelect.empty();
              $.each(product.sizes, function (index, size) {
                const sizeTag =
                  "<label for=size-" +
                  size.id +
                  ' class="size-tag col-auto me-2 mb-2">' +
                  size.name +
                  '<input required id="size-' +
                  size.id +
                  '" type="radio" name="sizeId" value="' +
                  size.id +
                  '" class="d-none"/></label>';
                sizeSelect.append(sizeTag);
              });
              $("#size-modal-price").text(
                new Intl.NumberFormat("vi-VN", {
                  style: "currency",
                  currency: "VND",
                }).format(parseFloat(product.price))
              );
            },
            error: function () {
              alert("Something errors, please try again later!");
            },
          });
        });
      });
    </script>
  </body>
</html>
