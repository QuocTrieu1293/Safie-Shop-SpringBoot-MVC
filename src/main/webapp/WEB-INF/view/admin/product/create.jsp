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
            <h1 class="mt-4">Create a product</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">
                <a href="/admin/user">Products</a>
              </li>
              <li class="breadcrumb-item active">Create</li>
            </ol>
            <hr />
            <form:form
              method="post"
              action="/admin/product/create"
              enctype="multipart/form-data"
              novalidate="not empty string here"
              modelAttribute="newProduct"
              id="form"
              class="row g-3 mb-3"
            >
              <div class="col-md-6 col-12">
                <div class="row g-3">
                  <div class="col-12">
                    <label for="name" class="form-label">Name:</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="name"
                      required="not empty string here"
                      path="name"
                    />
                  </div>
                  <div class="col-md-4 col-12">
                    <label for="brand" class="form-label">Brand:</label>
                    <form:select
                      class="form-select"
                      id="brand"
                      required="not empty string here"
                      path="brand.id"
                    >
                      <option value="" selected="true" disabled="true">
                        Choose a brand
                      </option>
                      <c:forEach var="brand" items="${brands}">
                        <form:option value="${brand.id}"
                          >${brand.name}</form:option
                        >
                      </c:forEach>
                    </form:select>
                  </div>
                  <div class="col-md-4 col-12">
                    <label for="category" class="form-label">Category:</label>
                    <form:select
                      class="form-select"
                      id="category"
                      required="not empty string here"
                      path="category.id"
                    >
                      <option value="" selected="true" disabled="true">
                        Choose a category
                      </option>
                      <c:forEach var="category" items="${categories}">
                        <form:option value="${category.id}"
                          >${category.name}</form:option
                        >
                      </c:forEach>
                    </form:select>
                  </div>
                  <div class="col-md-4 col-12">
                    <label for="price" class="form-label">Price:</label>
                    <form:input
                      type="number"
                      class="form-control"
                      id="price"
                      required="not empty string here"
                      path="price"
                    />
                  </div>
                  <div class="col-md-8 col-12">
                    <label for="size" class="form-label">Sizes:</label>
                    <select
                      class="form-select"
                      id="size"
                      required="not empty string here"
                      name="sizes"
                      multiple
                    >
                      <c:forEach var="size" items="${sizes}">
                        <option value="${size.id}">${size.name}</option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="col-md-4 col-12">
                    <label for="quantity" class="form-label">Quantity:</label>
                    <form:input
                      type="number"
                      class="form-control"
                      id="quantity"
                      path="quantity"
                    />
                  </div>
                  <div class="col-12">
                    <label for="shortDesc" class="form-label"
                      >Short description:</label
                    >
                    <form:input
                      type="text"
                      class="form-control"
                      id="shortDesc"
                      path="shortDesc"
                    />
                  </div>
                  <div class="col-12">
                    <label for="detailDesc" class="form-label"
                      >Description:</label
                    >
                    <form:textarea
                      class="form-control"
                      rows="4"
                      id="detailDesc"
                      path="detailDesc"
                    />
                  </div>
                </div>
              </div>
              <div class="col-md-6 col-12">
                <div class="row justify-content-center">
                  <div class="col-md-6 col-12">
                    <div class="mb-5">
                      <label for="image" class="form-label">Image:</label>
                      <input
                        type="file"
                        accept=".png, .jpg, .jpeg"
                        class="form-control"
                        id="image"
                        name="image_file"
                        required="true"
                      />
                    </div>

                    <div
                      id="image_preview"
                      class="text-center"
                      style="display: none"
                    >
                      <!-- <button class="btn-remove btn-close"></button> -->
                      <img alt="image preview" class="img-fluid rounded" />
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-12 d-flex justify-content-end">
                <button type="submit" class="btn btn-primary me-3">
                  Create
                </button>
                <a class="btn btn-secondary" href="/admin/product">Cancel</a>
              </div>
            </form:form>
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
          $(".server-validate-feedback").css({ display: "none" });
          $(".client-validate-feedback").css({ display: "block" });
        });

        $("#image").change(function (e) {
          // console.log(e.target.files);
          const imgURL =
            e.target.files.length > 0
              ? URL.createObjectURL(e.target.files[0])
              : "";
          // console.log(imgURL);
          $("#image_preview img").attr("src", imgURL);
          $("#image_preview").css({ display: imgURL ? "block" : "none" });
        });

        // $(".btn-remove").click(function (e) {
        //   e.preventDefault();
        //   $("#image").val("");
        //   $("#avatar_preview img").attr("src", "");
        //   $("#avatar_preview").css({ display: "none" });
        // });
      });
    </script>
  </body>
</html>
