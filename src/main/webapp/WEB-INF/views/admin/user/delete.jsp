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
    <link rel="manifest" href="/site.webmanifest" />
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <link href="/css/styles.css" rel="stylesheet" />
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
            <h1 class="mt-4">Delete User id = ${user.id}</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item"><a href="/admin/user">Users</a></li>
              <li class="breadcrumb-item active">Delete</li>
            </ol>
            <hr />
            <div class="alert alert-danger">
              Are you sure to delete this user ?
            </div>
            <div class="row g-3">
              <div
                class="col-md-3 col-12 d-flex justify-content-center align-items-start"
              >
                <!-- <c:choose>
                  <c:when test="${not empty user.avatar}">
                    <img
                      src="/images/avatar/${user.avatar}"
                      alt="avatar"
                      class="img-thumbnail"
                      style="max-width: 180px; aspect-ratio: 3/4"
                    />
                  </c:when>
                  <c:otherwise>
                    <img
                      src="/images/avatar/user_placeholder.png"
                      alt="avatar"
                      class="img-thumbnail"
                      style="max-width: 180px; aspect-ratio: 3/4"
                    />
                  </c:otherwise>
                </c:choose> -->
                <img src="/images/avatar/${not empty user.avatar ? user.avatar :
                "user_placeholder.png"}" alt="avatar" class="img-thumbnail"
                style="max-width: 180px; aspect-ratio: 3/4; object-fit: cover;"
                />
              </div>
              <div class="col-md-6 col">
                <div class="card mb-3">
                  <div class="card-header">User information</div>
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item">ID: ${user.id}</li>
                    <li class="list-group-item">Role: ${user.role.name}</li>
                    <li class="list-group-item">Email: ${user.email}</li>
                    <li class="list-group-item">Full name: ${user.fullName}</li>
                    <li class="list-group-item">Phone: ${user.phone}</li>
                  </ul>
                </div>
                <form
                  action="/admin/user/delete/${user.id}"
                  method="post"
                  class="text-end mb-3"
                >
                  <button class="btn btn-danger me-2">Confirm</button>
                  <a role="button" class="btn btn-secondary" onclick="goBack()"
                    >Cancel</a
                  >
                  <input
                    type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}"
                  />
                </form>
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
