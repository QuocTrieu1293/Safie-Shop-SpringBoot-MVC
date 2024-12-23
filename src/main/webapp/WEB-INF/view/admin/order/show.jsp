<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://sargue.net/jsptags/time" prefix="javatime" %> <%@ taglib
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
            <h1 class="mt-4">Manage Orders</h1>
            <!-- breadcrumb -->
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">Orders</li>
            </ol>

            <hr />

            <!-- Hiện thông báo thành công / thất bại -->
            <c:choose>
              <c:when test="${not empty successMessage}">
                <div
                  class="alert alert-success alert-dismissible fade show"
                  role="alert"
                >
                  ${successMessage}
                  <button class="btn-close" data-bs-dismiss="alert"></button>
                </div>
              </c:when>
              <c:when test="${not empty errorMessage}">
                <div
                  class="alert alert-danger alert-dismissible fade show"
                  role="alert"
                >
                  ${errorMessage}
                  <button class="btn-close" data-bs-dismiss="alert"></button>
                </div>
              </c:when>
            </c:choose>
            <table class="table table-hover table-bordered">
              <thead>
                <tr class="text-center">
                  <th>ID</th>
                  <th>Date</th>
                  <th>User</th>
                  <th>Total price</th>
                  <th style="width: 100px">Status</th>
                  <th>Payment status</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody class="table-group-divider">
                <c:if test="${empty orders}">
                  <td class="text-center" colspan="7">No order found</td>
                </c:if>
                <c:forEach var="order" items="${orders}">
                  <tr>
                    <td class="text-center fw-bold order-id">${order.id}</td>
                    <td class="text-center">
                      <javatime:format
                        value="${order.date}"
                        pattern="dd/MM/yyyy HH:mm"
                      />
                    </td>
                    <td class="text-center">${order.user.fullName}</td>
                    <td class="text-center">
                      <fmt:formatNumber
                        type="number"
                        value="${order.totalPrice}"
                      />
                      đ
                    </td>
                    <td class="text-center px-3">
                      <div class="dropdown">
                        <button
                          class="btn dropdown-toggle order-status fw-semibold w-100"
                          type="button"
                          data-bs-toggle="dropdown"
                          aria-expanded="false"
                        >
                          ${order.status}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-dark">
                          <li>
                            <button
                              class="btn dropdown-item"
                              data-status="PENDING"
                            >
                              PENDING
                            </button>
                          </li>
                          <li>
                            <button
                              class="btn dropdown-item"
                              data-status="SHIPPING"
                            >
                              SHIPPING
                            </button>
                          </li>
                          <li>
                            <button
                              class="btn dropdown-item"
                              data-status="COMPLETE"
                            >
                              COMPLETE
                            </button>
                          </li>
                          <li>
                            <button
                              class="btn dropdown-item"
                              data-status="CANCEL"
                            >
                              CANCEL
                            </button>
                          </li>
                        </ul>
                      </div>
                    </td>
                    <td class="text-center">${order.paymentStatus}</td>
                    <td class="text-center">
                      <a href="/admin/order/${order.id}" class="btn btn-primary"
                        >View</a
                      >
                      <a
                        href="/admin/order/delete/${order.id}"
                        class="btn btn-danger"
                        >Delete</a
                      >
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
            <c:if test="${not empty orders && totalPages > 1}">
              <nav aria-label="Order pages navigation">
                <ul class="pagination justify-content-center">
                  <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a
                      class="page-link"
                      href="/admin/order?page=${currentPage - 1}"
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
                        href="/admin/order?page=${loop.index}"
                        >${loop.index}</a
                      >
                    </li>
                  </c:forEach>
                  <li
                    class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                  >
                    <a
                      class="page-link"
                      href="/admin/order?page=${currentPage + 1}"
                      aria-label="Next"
                    >
                      <i class="bi bi-chevron-right"></i>
                    </a>
                  </li>
                </ul>
              </nav>
            </c:if>
          </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <!-- <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script> -->
    <script src="/js/scripts.js"></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
      crossorigin="anonymous"
    ></script>

    <script
      src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
      crossorigin="anonymous"
    ></script>

    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
      integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>

    <script>
      $(document).ready(function () {
        $(".order-status.dropdown-toggle").each(function () {
          const toggle = $(this);
          setStateColor(toggle);
        });

        $.ajaxSetup({
          headers: {
            "${_csrf.headerName}": "${_csrf.token}",
          },
        });

        $("[data-status]").click(function () {
          const toggle = $(this)
            .parent()
            .parent()
            .siblings(".order-status.dropdown-toggle");
          const orderId = $(this).closest("tr").find(".order-id").text().trim();
          const status = $(this).attr("data-status");
          $.post(
            "/admin/order/update",
            { orderId: orderId, status: status },
            function ({ orderId, status }) {
              toggle.text(status);
              setStateColor(toggle);
            }
          );
        });
      });

      function setStateColor(toggle) {
        const status = toggle.text().trim();
        toggle.removeClass("btn-primary btn-warning btn-success btn-danger");
        switch (status) {
          case "PENDING":
            toggle.addClass("btn-primary");
            break;
          case "SHIPPING":
            toggle.addClass("btn-warning");
            break;
          case "COMPLETE":
            toggle.addClass("btn-success");
            break;
          case "CANCEL":
            toggle.addClass("btn-danger");
            break;
          default:
        }
      }
    </script>
  </body>
</html>
