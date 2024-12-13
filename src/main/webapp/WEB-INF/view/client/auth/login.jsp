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
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Account Login</title>
    <link href="css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  </head>
  <body class="bg-primary">
    <div id="layoutAuthentication">
      <div id="layoutAuthentication_content">
        <main>
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-lg-5">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                  <div class="card-header">
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
                      <c:when test="${param.logout != null}">
                        <div
                          class="alert alert-success alert-dismissible fade show"
                          role="alert"
                        >
                          Logout success!
                          <button
                            class="btn-close"
                            data-bs-dismiss="alert"
                          ></button>
                        </div>
                      </c:when>
                    </c:choose>
                    <h3 class="text-center font-weight-light my-4">Login</h3>
                  </div>
                  <div class="card-body">
                    <form
                      method="post"
                      action="/login"
                      novalidate="true"
                      id="form"
                    >
                      <div class="form-floating mb-3">
                        <!-- <c:set var="emailBindErrors">
                          <form:errors
                            path="email"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set> -->

                        <input
                          class="form-control ${param.error != null ? 'is-invalid' : ''}"
                          id="inputEmail"
                          type="email"
                          placeholder="name@example.com"
                          required="true"
                          name="username"
                        />
                        <label for="inputEmail">Email address</label>
                        <!-- ${emailBindErrors} -->
                        <c:if test="${param.error != null}">
                          <div
                            class="mt-1 mb-2 invalid-feedback server-validate-feedback"
                          >
                            Invalid email or password.
                          </div>
                        </c:if>
                      </div>
                      <div class="form-floating mb-3">
                        <!-- <c:set var="passwordBindErrors">
                          <form:errors
                            path="password"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set> -->
                        <input
                          class="form-control ${param.error != null ? 'is-invalid' : ''}"
                          id="inputPassword"
                          type="password"
                          placeholder="Password"
                          required="true"
                          name="password"
                        />
                        <label for="inputPassword">Password</label>
                        <!-- ${passwordBindErrors} -->
                      </div>
                      <div class="form-check mb-3">
                        <input
                          class="form-check-input"
                          id="inputRememberPassword"
                          type="checkbox"
                          value=""
                        />
                        <label
                          class="form-check-label"
                          for="inputRememberPassword"
                          >Remember Password</label
                        >
                      </div>
                      <div
                        class="d-flex align-items-center justify-content-between mt-4 mb-0"
                      >
                        <a class="small" href="#">Forgot Password?</a>
                        <button type="submit" class="btn btn-primary">
                          Login
                        </button>
                      </div>
                      <input
                        type="hidden"
                        name="${_csrf.parameterName}"
                        value="${_csrf.token}"
                      />
                    </form>
                  </div>
                  <div class="card-footer text-center py-3">
                    <div class="small">
                      <a href="/register">Need an account? Sign up!</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="js/scripts.js"></script>
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

        $(".form-control").on("input", function () {
          $(".form-control").removeClass("is-invalid");
          $(".server-validate-feedback").remove();
          $(".client-validate-feedback").removeClass("d-none");
        });
      });
    </script>
  </body>
</html>
