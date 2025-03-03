<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

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

    <!-- css -->
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <link href="/css/styles.css" rel="stylesheet" />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />
    <link rel="stylesheet" href="/css/mycss.css" />

    <!-- js -->
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
                    <h1 class="mt-4">Manage Users</h1>
                    <ol class="breadcrumb mb-4">
                      <li class="breadcrumb-item active">Users</li>
                    </ol>
                  </div>
                  <a href="/admin/user/create" class="btn btn-primary btn-lg"
                    >Create a user</a
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

                <div class="row mb-3 justify-content-between">
                  <div
                    class="col-md-5 col-12 mb-2 mb-md-0"
                    style="max-width: 800px"
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
                        placeholder="Search for user ID (ex: #123), full name or email"
                        spellcheck="false"
                      />
                      <i
                        class="bi bi-x-circle-fill ps-1"
                        style="font-size: 16px; line-height: 0"
                        role="button"
                      ></i>
                    </div>
                  </div>
                  <span class="col-form-label col-auto align-content-end"
                    >Có <b>${totalUsers}</b> kết quả</span
                  >
                </div>
                <table class="table table-hover table-bordered">
                  <thead>
                    <tr class="text-center">
                      <th>ID</th>
                      <th>Email</th>
                      <th>Full Name</th>
                      <th>Role</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody class="table-group-divider">
                    <c:if test="${empty userList}">
                      <td class="text-center" colspan="5">No user found</td>
                    </c:if>
                    <c:forEach var="user" items="${userList}">
                      <tr>
                        <td class="text-center fw-bold">${user.id}</td>
                        <td>${user.email}</td>
                        <td>${user.fullName}</td>
                        <td class="text-center">${user.role.name}</td>
                        <td
                          class="text-center d-flex justify-content-evenly justify-content-xxl-center flex-column flex-md-row"
                        >
                          <a
                            href="/admin/user/${user.id}"
                            class="btn btn-success me-xxl-2 mb-2 mb-md-0"
                            >View</a
                          >
                          <a
                            href="/admin/user/update/${user.id}"
                            class="btn btn-warning me-xxl-2 mb-2 mb-md-0"
                            >Update</a
                          >
                          <a
                            href="/admin/user/delete/${user.id}"
                            class="btn btn-danger"
                            >Delete</a
                          >
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
                <c:if test="${not empty userList}">
                  <nav aria-label="User pages navigation">
                    <ul class="pagination justify-content-center">
                      <li
                        class="page-item ${currentPage == 1 ? 'disabled' : ''}"
                      >
                        <a
                          class="page-link"
                          href="/admin/user?page=${currentPage - 1}${queryString}"
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
                            href="/admin/user?page=${loop.index}${queryString}"
                            >${loop.index}</a
                          >
                        </li>
                      </c:forEach>
                      <li
                        class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                      >
                        <a
                          class="page-link"
                          href="/admin/user?page=${currentPage + 1}${queryString}"
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

      function searchUser(keyword) {
        if (keyword) searchParams.set("search", keyword);
        else searchParams.delete("search");
        searchParams.delete("page");
        window.location.href = url.toString();
      }

      $(document).ready(function () {
        const clearSearch = $("#search").siblings(
          "i.bi-x-circle-fill[role='button']"
        );

        if (searchParams.has("search"))
          $("#search").val(searchParams.get("search"));
        else clearSearch.addClass("d-none");

        $("#search")
          .prev()
          .click(function () {
            searchUser($("#search").val().trim());
          });

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
            searchUser($("#search").val().trim());
          }
        });
      });
    </script>
  </body>
</html>
