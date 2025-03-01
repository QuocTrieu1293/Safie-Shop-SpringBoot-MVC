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
            <h1 class="mt-4">Update Product</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="/admin/product">Products</a>
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
            <form:form
              method="post"
              action="/admin/product/update"
              enctype="multipart/form-data"
              novalidate="not empty string here"
              modelAttribute="product"
              id="form"
              cssClass="row g-3 mb-3"
            >
              <div class="col-md-6 col-12">
                <div class="row g-3">
                  <div class="col-12">
                    <div class="row me-0">
                      <c:set var="idBindError">
                        <form:errors
                          path="id"
                          cssClass="invalid-feedback server-validate-feedback"
                        />
                      </c:set>
                      <form:label
                        path="id"
                        cssClass="form-label col-form-label col-1 fw-bold"
                        >ID:</form:label
                      >
                      <div class="col">
                        <form:input
                          type="text"
                          cssClass="form-control-plaintext ${not empty idBindError ? 'is-invalid' : ''} fw-bold"
                          required="not empty string here"
                          path="id"
                          readonly="true"
                        />
                        ${idBindError}
                      </div>
                    </div>
                  </div>

                  <div class="col-12">
                    <c:set var="nameBindError">
                      <form:errors
                        path="name"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <form:label path="name" cssClass="form-label"
                      >Name:</form:label
                    >
                    <form:input
                      type="text"
                      cssClass="form-control ${not empty nameBindError ? 'is-invalid' : ''}"
                      required="not empty string here"
                      path="name"
                    />
                    ${nameBindError}
                  </div>

                  <div class="col-md-4 col-12">
                    <c:set var="brandBindError">
                      <form:errors
                        path="brand"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <form:label path="brand" cssClass="form-label"
                      >Brand:</form:label
                    >
                    <form:select
                      cssClass="form-select ${not empty brandBindError ? 'is-invalid' : ''}"
                      required="not empty string here"
                      path="brand.id"
                    >
                      <form:option value="" selected="true">
                        Choose a brand
                      </form:option>
                      <form:options
                        items="${brands}"
                        itemValue="id"
                        itemLabel="name"
                      />
                    </form:select>
                    ${brandBindError}
                  </div>

                  <div class="col-md-4 col-12">
                    <c:set var="categoryBindError">
                      <form:errors
                        path="category"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <form:label path="category" cssClass="form-label"
                      >Category:</form:label
                    >
                    <form:select
                      cssClass="form-select ${not empty categoryBindError ? 'is-invalid' : ''}"
                      required="not empty string here"
                      path="category.id"
                    >
                      <form:option value="" selected="true">
                        Choose a category
                      </form:option>
                      <form:options
                        items="${categories}"
                        itemValue="id"
                        itemLabel="name"
                      />
                    </form:select>
                    ${categoryBindError}
                  </div>

                  <div class="col-md-4 col-12">
                    <c:set var="priceBindError">
                      <form:errors
                        path="price"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <form:label path="price" cssClass="form-label"
                      >Price:</form:label
                    >
                    <form:input
                      type="number"
                      cssClass="form-control ? ${not empty priceBindError ? 'is-invalid' : ''}"
                      path="price"
                      required="not empty string here"
                    />
                    ${priceBindError}
                  </div>

                  <div class="col-md-8 col-12">
                    <c:set var="sizesBindError">
                      <form:errors
                        path="sizes"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <form:label path="sizes" cssClass="form-label"
                      >Sizes:</form:label
                    >
                    <form:select
                      cssClass="form-select ${not empty sizesBindError ? 'is-invalid' : ''}"
                      required="not empty string here"
                      path="sizes"
                      multiple="true"
                    >
                      <!-- <form:options
                        items="${sizes}"
                        itemValue="id"
                        itemLabel="name"
                      /> -->
                      <c:forEach items="${sizes}" var="size">
                        <form:option
                          value="${size.id}"
                          selected="${product.sizes.contains(size) ? 'true' : ''}"
                          >${size.name}</form:option
                        >
                      </c:forEach>
                    </form:select>
                    ${sizesBindError}
                  </div>

                  <div class="col-md-4 col-12">
                    <c:set var="quantityBindError">
                      <form:errors
                        path="quantity"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <form:label path="quantity" cssClass="form-label"
                      >Quantity:</form:label
                    >
                    <form:input
                      type="number"
                      cssClass="form-control ${not empty quantityBindError ? 'is-invalid' : ''}"
                      path="quantity"
                    />
                    ${quantityBindError}
                  </div>
                  <div class="col-12">
                    <c:set var="shortDescBindError">
                      <form:errors
                        path="shortDesc"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <form:label path="shortDesc" cssClass="form-label"
                      >Short description:</form:label
                    >
                    <form:input
                      type="text"
                      cssClass="form-control ${not empty shortDescBindError ? 'is-invalid' : ''}"
                      path="shortDesc"
                    />
                    ${shortDescBindError}
                  </div>
                  <div class="col-12">
                    <c:set var="detailDescBindError">
                      <form:errors
                        path="detailDesc"
                        cssClass="invalid-feedback server-validate-feedback"
                      />
                    </c:set>
                    <form:label path="detailDesc" cssClass="form-label"
                      >Description:</form:label
                    >
                    <form:textarea
                      cssClass="form-control ${not empty detailDescBindError ? 'is-invalid' : ''}"
                      rows="4"
                      path="detailDesc"
                    />
                    ${detailDescBindError}
                  </div>
                </div>
              </div>
              <div class="col-md-6 col-12">
                <div class="row justify-content-center">
                  <div class="col-md-6 col-12">
                    <div class="mb-5">
                      <c:set var="imageBindError">
                        <form:errors
                          path="image"
                          cssClass="invalid-feedback server-validate-feedback"
                        />
                      </c:set>
                      <label for="image" class="form-label">Image:</label>
                      <input
                        type="file"
                        accept=".png, .jpg, .jpeg, .webp"
                        class="form-control ${not empty imageBindError ? 'is-invalid' : ''}"
                        id="image"
                        name="image_file"
                      />
                      ${imageBindError}
                    </div>

                    <div
                      id="image_preview"
                      class="text-center"
                      class="${empty product.image ? 'd-none' : ''}"
                    >
                      <!-- <button class="btn-remove btn-close"></button> -->
                      <img
                        alt="image preview"
                        class="w-100 rounded"
                        style="object-fit: cover"
                        src="/images/product/${not empty product.image ? product.image : ''}"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-12 d-flex justify-content-end">
                <button type="submit" class="btn btn-primary me-3">
                  Update
                </button>
                <a role="button" class="btn btn-secondary" onclick="goBack()"
                  >Cancel</a
                >
              </div>
              <form:input
                type="text"
                readonly="true"
                cssStyle="display: none"
                path="image"
                id="image_tmp"
              />
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
          $(".server-validate-feedback").remove();
          $(".client-validate-feedback").removeClass("d-none");
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

        $(".form-control, .form-select").on("input change", function () {
          $(this).removeClass("is-invalid");
          $(this).siblings(".server-validate-feedback").remove();
          $(".client-validate-feedback").removeClass("d-none");
        });
      });
    </script>
  </body>
</html>
