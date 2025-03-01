<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%>

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
    <link href="/css/mycss.css" rel="stylesheet" />
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
            <h1 class="mt-4">Update User</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="/admin/user">Users</a>
              </li>
              <li class="breadcrumb-item active">Update</li>
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
            <div class="row justify-content-md-center">
              <div class="col-md-6 col">
                <form:form
                  method="post"
                  action="/admin/user/update"
                  novalidate="not empty string here"
                  modelAttribute="user"
                  enctype="multipart/form-data"
                  id="form"
                >
                  <!--jsp tạo một đối tượng User mới để gửi tới controller-->
                  <div class="container-fluid">
                    <div class="row">
                      <div class="col-md-4 col-12">
                        <div class="row">
                          <label
                            for="id"
                            class="form-label col-form-label col-md-2 col-1 ps-0 fw-bold"
                            >ID:</label
                          >
                          <div class="col">
                            <form:input
                              type="text"
                              class="form-control-plaintext fw-bold"
                              readonly="true"
                              id="id"
                              path="id"
                              required="true"
                            />
                          </div>
                        </div>
                      </div>
                      <div class="col-md-8 col-12">
                        <div class="row">
                          <c:set var="emailBindError">
                            <form:errors
                              path="email"
                              cssClass="invalid-feedback server-validate-feedback"
                            />
                          </c:set>
                          <label
                            for="email"
                            class="form-label col-md-2 col-1 col-form-label ps-0"
                            >Email:</label
                          >
                          <div class="col">
                            <form:input
                              type="email"
                              class="form-control form-control-plaintext"
                              readonly="true"
                              id="email"
                              required="not empty string here"
                              path="email"
                            />
                            ${emailBindError}
                            <span
                              class="invalid-feedback client-validate-feedback d-none"
                              >Email is not valid</span
                            >
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="mb-3">
                    <c:set var="fullNameBindError">
                      <form:errors
                        path="fullName"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <label for="fullname" class="form-label">Full name:</label>
                    <form:input
                      type="text"
                      class="form-control ${not empty fullNameBindError ? 'is-invalid' : ''}"
                      id="fullname"
                      required="not empty string here"
                      path="fullName"
                    />
                    ${fullNameBindError}
                  </div>
                  <div class="mb-3">
                    <c:set var="phoneBindError">
                      <form:errors
                        path="phone"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <label for="phone" class="form-label">Phone number:</label>
                    <form:input
                      type="text"
                      class="form-control ${not empty phoneBindError ? 'is-invalid' : ''}"
                      id="phone"
                      path="phone"
                    />
                    ${phoneBindError}
                  </div>
                  <div class="mb-3 row">
                    <label for="role" class="form-label col-auto col-form-label"
                      >Role:</label
                    >
                    <div class="col-3 px-0">
                      <form:select
                        class="form-select"
                        id="role"
                        required="not empty string here"
                        path="role.id"
                      >
                        <c:forEach var="role" items="${roles}">
                          <form:option value="${role.id}"
                            >${role.name}</form:option
                          >
                        </c:forEach>
                      </form:select>
                    </div>
                    <label
                      for="avatar"
                      class="form-label col-form-label col-auto offset-1"
                      >Avatar:</label
                    >
                    <div class="col ps-0">
                      <input
                        type="file"
                        accept=".png, .jpg, .jpeg, .webp"
                        class="form-control"
                        id="avatar"
                        name="avatar_file"
                      />
                    </div>
                  </div>
                  <div class="d-flex justify-content-center mb-3">
                    <div
                      style="position: relative"
                      class="${empty user.avatar ? 'd-none' : ''}"
                      id="avatar_preview"
                    >
                      <button class="btn-remove btn-close"></button>
                      <img
                        alt="avatar preview"
                        class="img-thumbnail"
                        style="
                          max-width: 180px;
                          aspect-ratio: 3/4;
                          object-fit: cover;
                        "
                        src="/images/avatar/${not empty user.avatar ? user.avatar : ''}"
                      />
                    </div>
                  </div>
                  <div class="mb-3">
                    <button type="submit" class="btn btn-success me-2">
                      Update
                    </button>
                    <a
                      role="button"
                      class="btn btn-secondary"
                      onclick="goBack()"
                    >
                      Cancel
                    </a>
                  </div>
                  <input
                    id="isDeleteAvatar"
                    name="isDeleteAvatar"
                    type="checkbox"
                    readonly
                    style="display: none"
                  />
                  <form:input
                    type="text"
                    readonly="true"
                    style="display: none"
                    path="avatar"
                    id="avatar_tmp"
                  />
                  <!-- password giả để không bị dính cái validate @Size(min=8) của password-->
                  <form:input type="hidden" value="00000000" path="password" />
                </form:form>
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
      $(document).ready(() => {
        $("#form").submit(function (e) {
          if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
          }

          $(this).addClass("was-validated");
          $(".server-validate-feedback").remove();
          $(".client-validate-feedback").removeClass("d-none");
        });

        $("#avatar").change(function (e) {
          // console.log(e.target.files);
          let imgURL = "";
          if (e.target.files.length > 0) {
            imgURL = URL.createObjectURL(e.target.files[0]);
            if ($("#avatar_tmp").val())
              $("#isDeleteAvatar").prop("checked", true);
          }
          $("#avatar_preview img").attr("src", imgURL);
          if (imgURL) $("#avatar_preview").removeClass("d-none");
          else $("#avatar_preview").addClass("d-none");
        });

        $(".btn-remove").click(function (e) {
          e.preventDefault();

          if ($("#avatar_tmp").val())
            $("#isDeleteAvatar").prop("checked", true);

          $("#avatar").val("");
          $("#avatar_preview img").attr("src", "");
          $("#avatar_preview").addClass("d-none");
        });

        $(".form-control").on("input", function () {
          $(this).removeClass("is-invalid");
          $(this).siblings(".server-validate-feedback").remove();
          $(".client-validate-feedback").removeClass("d-none");
        });
      });
    </script>
  </body>
</html>
