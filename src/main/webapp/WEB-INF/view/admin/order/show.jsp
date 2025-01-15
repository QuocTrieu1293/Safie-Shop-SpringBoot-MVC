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
    <meta name="description" content="Safie shop" />
    <meta name="author" content="Quoc Trieu" />
    <title>Admin Dashboard</title>
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

    <!-- Toast plugin -->
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
      rel="stylesheet"
    />

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

            <!-- Filter -->
            <div class="row mb-3">
              <!-- Status filter -->
              <div class="col-md-auto col-12 row me-3 mb-2 gx-3 flex-nowrap">
                <label
                  for="status-filter"
                  class="col-form-label col-md-auto col-2 fw-semibold"
                  >Status</label
                >
                <div class="col-auto ps-0">
                  <select
                    name="status"
                    id="status-filter"
                    class="form-select"
                    aria-label="Order status filter"
                  >
                    <option value="All">All</option>
                    <option value="PENDING">PENDING</option>
                    <option value="SHIPPING">SHIPPING</option>
                    <option value="COMPLETE">COMPLETE</option>
                    <option value="CANCEL">CANCEL</option>
                  </select>
                </div>
              </div>

              <!-- Date filter -->
              <div class="col-md-auto col-12 row me-3 mb-2 gx-3 flex-nowrap">
                <label class="col-form-label col-md-auto col-2 fw-semibold"
                  >Date</label
                >
                <div class="col-auto row flex-nowrap ps-0 gx-2">
                  <div class="col-auto">
                    <input
                      type="date"
                      name="from"
                      id="from-date"
                      class="form-control"
                    />
                  </div>
                  <span class="col-auto align-content-center">-</span>
                  <div class="col-auto">
                    <input
                      type="date"
                      name="to"
                      id="to-date"
                      class="form-control"
                    />
                  </div>
                </div>
              </div>

              <!-- Search -->
              <div class="col ms-auto" style="max-width: 500px">
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
                    placeholder="Search for order ID (ex: #123), customer or product"
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
                >Có <b>${totalOrders}</b> kết quả</span
              >
              <div class="col-auto row flex-nowrap ms-auto">
                <label for="sort" class="col-form-label col-auto fw-semibold"
                  >Sort by</label
                >
                <div class="col-auto">
                  <select
                    name="sort"
                    id="sort"
                    class="form-select"
                    aria-label="Orders sort types"
                  >
                    <option value="default">Default</option>
                    <option value="newest-created">Newest Created</option>
                    <option value="oldest-created">Oldest Created</option>
                    <option value="recently-updated">Recently Updated</option>
                    <option value="oldest-updated">Oldest Updated</option>
                  </select>
                </div>
              </div>
            </div>

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
                      <a
                        href="/admin/order/${order.id}"
                        class="btn btn-primary mb-2 mb-xl-0"
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
            <c:if test="${totalPages > 0}">
              <nav aria-label="Order pages navigation">
                <ul class="pagination justify-content-center">
                  <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a
                      class="page-link"
                      href="/admin/order?page=${currentPage - 1}${queryString}"
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
                        href="/admin/order?page=${loop.index}${queryString}"
                        >${loop.index}</a
                      >
                    </li>
                  </c:forEach>
                  <li
                    class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                  >
                    <a
                      class="page-link"
                      href="/admin/order?page=${currentPage + 1}${queryString}"
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
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
      crossorigin="anonymous"
    ></script>

    <script
      src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
      crossorigin="anonymous"
    ></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
    <script src="/js/scripts.js"></script>

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
        $(".order-status.dropdown-toggle").each(function () {
          const toggle = $(this);
          setStateColor(toggle);
        });

        $("#status-filter, #from-date, #to-date, #sort, #search").each(
          function () {
            const name = $(this).attr("name");
            if (searchParams.has(name)) {
              $(this).val(searchParams.get(name));
            }
          }
        );

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

          if (status === toggle.text().trim()) {
            return;
          }

          $.post(
            "/api/order/update",
            { orderId: orderId, status: status },
            function ({ orderId, status }) {
              toggle.text(status);
              setStateColor(toggle);

              $.toast({
                text:
                  "<span style='font-size: 14px'>Trạng thái đã thay đổi thành <b>" +
                  status +
                  "</b></span>", // Text that is to be shown in the toast
                heading: "Đơn hàng <b>#" + orderId + "</b>", // Optional heading to be shown on the toast
                icon: "success", // Type of toast icon
                showHideTransition: "fade", // fade, slide or plain
                allowToastClose: true, // Boolean value true or false
                hideAfter: 2500, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
                stack: false, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
                position: "bottom-right", // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values
                textAlign: "left", // Text alignment i.e. left, right or center
                loader: true, // Whether to show loader or not. True by default
                loaderBg: "#20c997", // Background color of the toast loader
              });
            }
          );
        });

        $("#status-filter, #from-date, #to-date, #sort").change(function () {
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
            searchOrder($("#search").val().trim());
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
            searchOrder($("#search").val().trim());
          }
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
