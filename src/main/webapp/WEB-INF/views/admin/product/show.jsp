<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="Safie shop" />
    <meta name="author" content="Quoc Trieu" />
    <title>Admin Dashboard</title>
    <link rel="manifest" href="/static/site.webmanifest" />
    <link rel="icon" type="image/x-icon" href="/static/favicon.ico" />

    <!-- CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/mycss.css" />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />

    <!-- JS -->
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
      integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
  </head>
  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="../layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <div class="row">
              <div class="col">
                <div class="d-flex align-items-end justify-content-between">
                  <div>
                    <h1 class="mt-4">Manage Products</h1>
                    <ol class="breadcrumb mb-4">
                      <li class="breadcrumb-item active">Products</li>
                    </ol>
                  </div>
                  <a href="/admin/product/create" class="btn btn-primary btn-lg"
                    >Create a product</a
                  >
                </div>
                <hr />
                <!-- Hiện thông báo thành công / thất bại -->
                <c:choose>
                  <c:when test="${not empty successMessage}">
                    <div
                      class="alert alert-success alert-dismissible fade show"
                      role="alert"
                    >
                      ${successMessage}
                      <button
                        class="btn-close"
                        data-bs-dismiss="alert"
                      ></button>
                    </div>
                  </c:when>
                  <c:when test="${not empty errorMessage}">
                    <div
                      class="alert alert-danger alert-dismissible fade show"
                      role="alert"
                    >
                      ${errorMessage}
                      <button
                        class="btn-close"
                        data-bs-dismiss="alert"
                      ></button>
                    </div>
                  </c:when>
                </c:choose>

                <!-- Filter -->
                <div class="row mb-3">
                  <!-- Category -->
                  <div
                    class="col-sm-auto col-12 row flex-nowrap me-2 mb-sm-0 mb-2"
                  >
                    <label
                      for="category-filter"
                      class="col-form-label col-sm-auto col-2 fw-semibold"
                      >Category</label
                    >
                    <div class="col-auto">
                      <select
                        name="category"
                        id="category-filter"
                        class="form-select"
                        aria-label="Product category filter"
                      >
                        <option value="All">All</option>
                        <c:forEach var="category" items="${categories}">
                          <option value="${category.name}">
                            ${category.name}
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>

                  <!-- Brand -->
                  <div
                    class="col-sm-auto col-12 row flex-nowrap me-2 mb-xxl-0 mb-2"
                  >
                    <label
                      for="brand-filter"
                      class="col-form-label col-sm-auto col-2 fw-semibold"
                      >Brand</label
                    >
                    <div class="col-auto">
                      <select
                        name="brand"
                        id="brand-filter"
                        class="form-select"
                        aria-label="Product brand filter"
                      >
                        <option value="All">All</option>
                        <c:forEach var="brand" items="${brands}">
                          <option value="${brand.name}">${brand.name}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>

                  <!-- Search -->
                  <div
                    class="col-xxl ms-xl-auto col-12"
                    style="max-width: 500px; min-width: 440px"
                  >
                    <div class="form-control p-2 d-flex align-items-center">
                      <i
                        class="fas fa-search px-2"
                        style="font-size: 18px"
                        role="button"
                      ></i>
                      <input
                        type="text"
                        class="my-search-input"
                        id="search"
                        name="search"
                        style="font-size: 16px"
                        placeholder="Search for product ID (ex: #123), product name"
                        spellcheck="false"
                      />
                      <i
                        class="bi bi-x-circle-fill ps-1"
                        style="font-size: 16px; line-height: 0"
                        role="button"
                      ></i>
                    </div>
                  </div>
                </div>

                <!-- Sort -->
                <div class="row mb-3">
                  <span class="col-form-label col-auto"
                    >Có <b>${totalProducts}</b> kết quả</span
                  >
                  <div class="col-auto row flex-nowrap ms-auto">
                    <label
                      for="sort"
                      class="col-form-label col-auto fw-semibold"
                      >Sort by</label
                    >
                    <div class="col-auto">
                      <select
                        name="sort"
                        id="sort"
                        class="form-select"
                        aria-label="Products sort types"
                      >
                        <option value="default">Default</option>
                        <option value="price-highest">Highest price</option>
                        <option value="price-lowest">Lowest price</option>
                        <option value="quant-highest">Highest quantity</option>
                        <option value="quant-lowest">Lowest quantity</option>
                      </select>
                    </div>
                  </div>
                </div>

                <table class="table table-hover table-bordered">
                  <thead>
                    <tr class="text-center">
                      <th>ID</th>
                      <th>Name</th>
                      <th>Brand</th>
                      <th>Cate</th>
                      <th>Price</th>
                      <th>Quant</th>
                      <th style="width: 200px">Image</th>
                      <th style="width: 80px">Action</th>
                    </tr>
                  </thead>
                  <tbody class="table-group-divider">
                    <c:if test="${empty productList}">
                      <td class="text-center" colspan="8">No product found</td>
                    </c:if>
                    <c:forEach var="product" items="${productList}">
                      <tr>
                        <td class="text-center fw-bold">${product.id}</td>
                        <td style="width: 30%">${product.name}</td>
                        <td class="text-nowrap text-center">
                          ${product.brand.name}
                        </td>
                        <td class="text-nowrap text-center">
                          ${product.category.name}
                        </td>
                        <td class="text-center">
                          <fmt:formatNumber
                            type="number"
                            value="${product.price}"
                          />
                          đ
                        </td>
                        <td class="text-center">${product.quantity}</td>
                        <td>
                          <img
                            src="/images/product/${product.image}"
                            alt="product image"
                            class="w-100 rounded"
                            style="object-fit: cover"
                          />
                        </td>
                        <td>
                          <div class="d-flex flex-column">
                            <a
                              href="/admin/product/${product.id}"
                              class="btn btn-success mb-2"
                              >View</a
                            >
                            <a
                              href="/admin/product/update/${product.id}"
                              class="btn btn-warning mb-2"
                              >Update</a
                            >
                            <a
                              href="/admin/product/delete/${product.id}"
                              class="btn btn-danger"
                              >Delete</a
                            >
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
                <c:if test="${not empty productList}">
                  <nav aria-label="Product pages navigation">
                    <ul class="pagination justify-content-center">
                      <li
                        class="page-item ${currentPage == 1 ? 'disabled' : ''}"
                      >
                        <a
                          class="page-link"
                          href="/admin/product?page=${currentPage - 1}${queryString}"
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
                            href="/admin/product?page=${loop.index}${queryString}"
                            >${loop.index}</a
                          >
                        </li>
                      </c:forEach>
                      <li
                        class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                      >
                        <a
                          class="page-link"
                          href="/admin/product?page=${currentPage + 1}${queryString}"
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
        </main>
        <jsp:include page="../layout/footer.jsp" />
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="/js/scripts.js"></script>

    <script>
      const url = new URL(window.location.href);
      const searchParams = url.searchParams;

      function searchProduct(keyword) {
        if (keyword) searchParams.set("search", keyword);
        else searchParams.delete("search");
        searchParams.delete("page");
        window.location.href = url.toString();
      }

      $(document).ready(function () {
        $("#category-filter, #brand-filter, #sort, #search").each(function () {
          const name = $(this).attr("name");
          if (searchParams.has(name)) {
            $(this).val(searchParams.get(name));
          }
        });

        $("#category-filter, #brand-filter, #sort").change(function () {
          const name = $(this).attr("name");
          const value = $(this).val().trim();
          if (value) searchParams.set(name, value);
          else searchParams.delete(name);
          if ($(this).attr("id") !== "sort" && searchParams.has("page"))
            searchParams.delete("page");
          window.location.href = url.toString();
        });

        $("#search")
          .prev()
          .click(function () {
            searchProduct($("#search").val().trim());
          });
        const clearSearch = $("#search").siblings(
          "i.bi-x-circle-fill[role='button']"
        );
        if (!searchParams.has("search")) clearSearch.addClass("d-none");
        clearSearch.click(function () {
          $("#search").val("");
          clearSearch.addClass("d-none");
          $("#search").focus();
        });
        $("#search").on("input", function () {
          const val = $(this).val();
          if (val && clearSearch.hasClass("d-none"))
            clearSearch.removeClass("d-none");
          else if (!val && !clearSearch.hasClass("d-none"))
            clearSearch.addClass("d-none");
        });
        $("#search").keydown(function (e) {
          if (e.key === "Enter") {
            searchProduct($("#search").val().trim());
          }
        });
      });
    </script>
  </body>
</html>
