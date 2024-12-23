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
    <meta name="description" content="Laptop shop" />
    <meta name="author" content="Quoc Trieu" />
    <title>Admin Dashboard</title>
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <link href="/css/styles.css" rel="stylesheet" />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
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
                            class="img-fluid rounded"
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
                <c:if test="${not empty productList && totalPages > 1}">
                  <nav aria-label="Product pages navigation">
                    <ul class="pagination justify-content-center">
                      <li
                        class="page-item ${currentPage == 1 ? 'disabled' : ''}"
                      >
                        <a
                          class="page-link"
                          href="/admin/product?page=${currentPage - 1}"
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
                            href="/admin/product?page=${loop.index}"
                            >${loop.index}</a
                          >
                        </li>
                      </c:forEach>
                      <li
                        class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                      >
                        <a
                          class="page-link"
                          href="/admin/product?page=${currentPage + 1}"
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
  </body>
</html>
