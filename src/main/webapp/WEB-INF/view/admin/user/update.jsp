<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Update User</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <script
      defer
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <script
      defer
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
    ></script>
  </head>
  <body>
    <div class="container mt-5">
      <div class="row justify-content-md-center">
        <div class="col-md-6 col">
          <h1>Update User</h1>
          <hr />
          <c:if test="${not empty errorMessage}">
            <div
              class="alert alert-danger alert-dismissible fade show"
              role="alert"
            >
              ${errorMessage}
              <button class="btn-close" data-bs-dismiss="alert"></button>
            </div>
          </c:if>
          <form:form
            method="post"
            action="/admin/user/update"
            novalidate="not empty string here"
            modelAttribute="user"
          >
            <!--jsp tạo một đối tượng User mới để gửi tới controller-->
            <div class="container-fluid">
              <div class="mb-3 row">
                <label for="id" class="form-label col-form-label col-1 px-0"
                  >ID:</label
                >
                <form:input
                  type="text"
                  class="form-control-plaintext col"
                  id="id"
                  path="id"
                  required="true"
                />
              </div>
            </div>
            <div class="mb-3">
              <label for="email" class="form-label">Email:</label>
              <form:input
                type="email"
                class="form-control"
                readonly="true"
                id="email"
                required="not empty string here"
                path="email"
              />
              <div class="invalid-feedback">Email không hợp lệ</div>
            </div>
            <div class="mb-3">
              <label for="phone" class="form-label">Phone number:</label>
              <form:input
                type="number"
                class="form-control"
                id="phone"
                required="not empty string here"
                path="phone"
              />
              <div class="invalid-feedback">Không được để trống</div>
            </div>
            <div class="mb-3">
              <label for="fullname" class="form-label">Full Name:</label>
              <form:input
                type="text"
                class="form-control"
                id="fullname"
                required="not empty string here"
                path="fullName"
              />
              <div class="invalid-feedback">Không được để trống</div>
            </div>
            <div class="mb-3">
              <label for="address" class="form-label">Address:</label>
              <form:input
                type="text"
                class="form-control"
                id="address"
                required="not empty string here"
                path="address"
              />
              <div class="invalid-feedback">Không được để trống</div>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
            <!-- <form:input
              type="password"
              path="password"
              class="d-none"
              readonly="không được sửa"
            /> -->
          </form:form>
        </div>
      </div>
    </div>

    <script>
      form = document.querySelector("form");
      form.addEventListener("submit", (e) => {
        if (!form.checkValidity()) {
          e.preventDefault();
        }

        form.classList.add("was-validated");
      });
    </script>
  </body>
</html>
