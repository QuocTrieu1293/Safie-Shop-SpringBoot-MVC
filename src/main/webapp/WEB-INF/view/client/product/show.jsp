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

    <!-- Toast plugin -->
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
      rel="stylesheet"
    />

    <!-- JSP variables for accessing in js file -->
    <script>
      const addedProduct = "${addedProduct}";
      const addedSize = "${addedSize}";
    </script>
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
            <form id="filter-form" action="/products" class="card bg-light">
              <div class="card-header bg-white fw-bold fs-5">
                <span><i class="bi bi-filter"></i></span>
                <span>Bộ lọc tìm kiếm</span>
              </div>
              <div class="card-body bg-light">
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
                        value="${category.name}"
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
                        value="${brand.name}"
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
                      id="0-100"
                      value="0-100"
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
                      for="0-100"
                      >Dưới 100 ngàn</label
                    >
                  </div>
                  <div class="col-auto">
                    <input
                      type="radio"
                      class="btn-check"
                      id="100-200"
                      value="100-200"
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
                      for="100-200"
                      >Từ 100 - 200 ngàn</label
                    >
                  </div>
                  <div class="col-auto">
                    <input
                      type="radio"
                      class="btn-check"
                      id="200-300"
                      value="200-300"
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
                      for="200-300"
                      >Từ 200 - 300 ngàn</label
                    >
                  </div>
                  <div class="col-auto">
                    <input
                      type="radio"
                      class="btn-check"
                      id="300-inf"
                      value="300-inf"
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
                      for="300-inf"
                      >Trên 300 ngàn</label
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
                        value="${size.name}"
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
              </div>

              <div class="card-footer bg-white p-3">
                <button
                  class="text-uppercase rounded-pill btn btn-outline-light-primary border-secondary px-3 py-2 fs-5"
                >
                  Lọc sản phẩm
                </button>
              </div>

              <input type="hidden" name="sort" value="noi-bat" />
            </form>
          </div>

          <!-- Products -->
          <div class="col-md-8">
            <div
              class="row g-3 mb-3 justify-content-between align-items-md-end align-items-baseline"
            >
              <span class="col-auto" style="color: black"
                >Tìm thấy <b>${totalProducts}</b> kết quả</span
              >
              <div class="col-auto d-flex align-items-center">
                <span class="col-auto me-2">Sắp xếp theo:</span>
                <select
                  class="form-select"
                  style="color: black"
                  aria-label="Sort type select"
                  name="sort"
                >
                  <option value="noi-bat">Nổi bật</option>
                  <option value="gia-thap">Giá thấp nhất</option>
                  <option value="gia-cao">Giá cao nhất</option>
                </select>
              </div>
            </div>
            <div class="row gx-3 gy-4 mb-5">
              <c:if test="${empty products}">
                <div
                  class="col-md-auto col-12 mx-auto d-flex flex-column align-items-center"
                >
                  <img src="/images/others/empty_state.png" />
                  <span class="fw-bold fs-5">
                    Rất tiếc, chúng tôi không tìm thấy sản phẩm nào phù hợp.
                  </span>
                </div>
              </c:if>
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
                            class="text-start fw-bold my-card-title"
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
                            class="btn border border-secondary rounded-pill px-3 text-primary"
                            style="font-size: 14px"
                            size-modal-trigger
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
            <c:if test="${totalPages > 0}">
              <nav aria-label="Product pages navigation">
                <ul
                  class="pagination justify-content-center"
                  style="display: flex"
                >
                  <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a
                      class="page-link"
                      href="/products?page=${currentPage - 1}${queryString}"
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
                        href="/products?page=${loop.index}${queryString}"
                        >${loop.index}</a
                      >
                    </li>
                  </c:forEach>
                  <li
                    class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                  >
                    <a
                      class="page-link"
                      href="/products?page=${currentPage + 1}${queryString}"
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
    <!-- size modal js -->
    <script src="/client/js/sizeModal.js"></script>

    <script>
      $(document).ready(function () {
        const url = new URL(window.location.href);
        // console.log(window.location.search); // là một query string với `?` ở đầu
        const searchParams = url.searchParams;

        searchParams.forEach((value, name) => {
          const checkBtn = $(
            '[data-filter] input.btn-check[name="' +
              name +
              '"][value="' +
              value +
              '"]'
          );
          checkBtn.prop("checked", true);

          const criterion = checkBtn.closest("[data-filter]");
          criterion.data("filter", criterion.data("filter") + 1);
        });
        if (searchParams.has("sort")) {
          $("#filter-form input[name='sort']").val(searchParams.get("sort"));
          $("select[name='sort']").val(searchParams.get("sort"));
        }

        $("[data-filter]").each(function () {
          const criterion = $(this);
          const clearFilter = criterion.children(":first").children().eq(1);
          if (criterion.data("filter") > 0) clearFilter.removeClass("d-none");

          clearFilter.click(function () {
            const checkedInput = criterion.find("input.btn-check:checked");

            // checkedInput.trigger("click"); // trigger sự kiện change của input.btn-check

            checkedInput.prop("checked", false); // không trigger sự kiện change
            criterion.data("filter", 0); // do không trigger sự kiện change nên phải tự reset giá trị data-filter

            $(this).addClass("d-none"); // Ẩn button clear fiter đi
          });
        });

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

        // reload lại page mỗi khi user chọn tiêu chí sort
        $("select[name='sort']").change(function () {
          searchParams.delete("page");
          searchParams.set("sort", $(this).val());
          window.location.href = url.toString();
        });
      });
    </script>
  </body>
</html>
