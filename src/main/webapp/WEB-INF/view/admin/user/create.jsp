<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

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
    <link href="/css/mycss.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  </head>
  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="../layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Create a user</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">
                <a href="/admin/user">Users</a>
              </li>
              <li class="breadcrumb-item active">Create</li>
            </ol>
            <hr />
            <div class="row justify-content-center">
              <div class="col-md-6 col">
                <form:form
                  method="post"
                  action="/admin/user/create"
                  enctype="multipart/form-data"
                  novalidate="not empty string here"
                  modelAttribute="newUser"
                  id="form"
                  class="row g-3"
                >
                  <div class="col-md-6 col-12">
                    <label for="email" class="form-label">Email:</label>
                    <form:input
                      type="email"
                      class="form-control"
                      id="email"
                      required="not empty string here"
                      path="email"
                    />
                    <div class="invalid-feedback">Email không hợp lệ</div>
                  </div>
                  <div class="col-md-6 col-12">
                    <label for="password" class="form-label">Password:</label>
                    <form:input
                      type="password"
                      class="form-control"
                      id="password"
                      required="not empty string here"
                      path="password"
                    />
                  </div>
                  <div class="col-md-6 col-12">
                    <label for="phone" class="form-label">Phone number:</label>
                    <form:input
                      type="number"
                      class="form-control"
                      id="phone"
                      required="not empty string here"
                      path="phone"
                    />
                  </div>
                  <div class="col-md-6 col-12">
                    <label for="fullname" class="form-label">Full name:</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="fullname"
                      required="not empty string here"
                      path="fullName"
                    />
                  </div>
                  <div class="col-12">
                    <label for="address" class="form-label">Address:</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="address"
                      required="not empty string here"
                      path="address"
                    />
                  </div>
                  <div class="col-md-6 col-12">
                    <label for="role" class="form-label">Role:</label>
                    <form:select
                      class="form-select"
                      id="role"
                      required="not empty string here"
                      path="role.name"
                    >
                      <form:option value="Admin">Admin</form:option>
                      <form:option value="User" selected="true"
                        >User</form:option
                      >
                    </form:select>
                  </div>
                  <div class="col-md-6 col-12">
                    <label for="avatar" class="form-label">Avatar:</label>
                    <input
                      type="file"
                      accept=".png, .jpg, .jpeg"
                      class="form-control"
                      id="avatar"
                      name="avatar_file"
                    />
                  </div>
                  <div class="col-12 d-flex justify-content-center">
                    <div
                      style="position: relative; display: none"
                      id="avatar_preview"
                    >
                      <button class="btn-remove btn-close"></button>
                      <img
                        alt="avatar preview"
                        style="max-width: 180px; aspect-ratio: 3/4"
                        class="img-thumbnail"
                      />
                    </div>
                  </div>
                  <div class="col-12 mb-3">
                    <button type="submit" class="btn btn-primary me-2">
                      Create
                    </button>
                    <a class="btn btn-secondary" href="/admin/user">Cancel</a>
                  </div>
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
      form = document.getElementById("form");
      form.addEventListener("submit", (e) => {
        if (!form.checkValidity()) {
          e.preventDefault();
        }

        form.classList.add("was-validated");
      });

      $(document).ready(() => {
        $("#avatar").change(function (e) {
          // console.log(e.target.files);
          const imgURL =
            e.target.files.length > 0
              ? URL.createObjectURL(e.target.files[0])
              : "";
          // console.log(imgURL);
          $("#avatar_preview img").attr("src", imgURL);
          $("#avatar_preview").css({ display: imgURL ? "block" : "none" });
        });

        $(".btn-remove").click(function (e) {
          e.preventDefault();
          $("#avatar").val("");
          $("#avatar_preview img").attr("src", "");
          $("#avatar_preview").css({ display: "none" });
        });
      });
    </script>
  </body>
</html>
