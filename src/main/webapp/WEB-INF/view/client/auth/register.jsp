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
    <title>Safie - An tâm cho con | Đăng ký tài khoản</title>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap"
      rel="stylesheet"
    />

    <!-- Icon Font Stylesheet -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"
      integrity="sha512-5Hs3dF2AEPkpNAR7UiOHba+lRSJNeM2ECkwxUIxC1Q/FLycGTbNapWXB4tP889k5T5Ju8fs4b1P5z/iB4nMfSQ=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet" />
  </head>
  <body class="bg-primary">
    <!-- Header -->
    <nav class="navbar navbar-expand-sm bg-white">
      <div class="container-fluid justify-content-start">
        <a href="/" class="navbar-brand me-4"
          ><img
            src="/images/others/logo.png"
            alt="Safie brand"
            style="height: 76px; object-fit: contain"
        /></a>
        <div class="text-black fs-2 pt-2">Đăng ký</div>
      </div>
    </nav>

    <div id="layoutAuthentication">
      <div id="layoutAuthentication_content">
        <main>
          <div class="container">
            <div class="row justify-content-between align-items-center mt-5">
              <div class="col-lg-6">
                <img
                  src="/images/others/logo_white.png"
                  alt="brand logo"
                  class="img-fluid mb-lg-5 mb-3"
                />
                <p class="text-center text-white fs-2 fw-bold">
                  Shop thời trang dành cho trẻ nhỏ chất lượng & an toàn số 1
                  Việt Nam
                </p>
              </div>
              <div class="col-lg-5">
                <div class="card shadow-lg border-0 rounded-lg">
                  <div class="card-header">
                    <h3 class="text-center font-weight-light mt-3">Đăng ký</h3>
                  </div>
                  <div class="card-body">
                    <form:form
                      method="post"
                      action="/register"
                      novalidate="true"
                      id="registration-form"
                      modelAttribute="registerUser"
                      cssClass="pt-3"
                    >
                      <!-- email -->
                      <div class="input-group mb-3 has-validation">
                        <c:set var="emailError">
                          <form:errors
                            path="email"
                            cssClass="invalid-feedback server-validate-feedback"
                            cssStyle="margin-left: 45px"
                          />
                        </c:set>
                        <span class="input-group-text"
                          ><i class="bi bi-envelope-at-fill"></i
                        ></span>
                        <div
                          class="form-floating ${not empty emailError ? 'is-invalid' : ''}"
                        >
                          <form:input
                            type="text"
                            cssClass="form-control ${not empty emailError ? 'is-invalid' : ''} rounded-end"
                            path="email"
                            required="true"
                            placeholder="Nhập địa chỉ email"
                          />
                          <form:label path="email">Địa chỉ email</form:label>
                        </div>
                        <div class="invalid-feedback" style="margin-left: 45px">
                          Vui lòng điền Email
                        </div>
                        ${emailError}
                      </div>

                      <!-- fullName -->
                      <div class="input-group mb-3 has-validation">
                        <c:set var="fullNameError">
                          <form:errors
                            path="fullName"
                            cssClass="invalid-feedback server-validate-feedback"
                            cssStyle="margin-left: 45px"
                          />
                        </c:set>
                        <span class="input-group-text"
                          ><i class="bi bi-person-fill"></i
                        ></span>
                        <div
                          class="form-floating ${not empty fullNameError ? 'is-invalid' : ''}"
                        >
                          <form:input
                            type="text"
                            cssClass="form-control ${not empty fullNameError ? 'is-invalid' : ''} rounded-end"
                            path="fullName"
                            required="true"
                            placeholder="Nhập họ tên"
                          />
                          <form:label path="fullName">Họ tên</form:label>
                        </div>
                        <div class="invalid-feedback" style="margin-left: 45px">
                          Vui lòng điền Họ tên
                        </div>
                        ${fullNameError}
                      </div>

                      <!-- password -->
                      <div class="input-group has-validation mb-3">
                        <c:set var="passwordError">
                          <form:errors
                            path="password"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set>
                        <div
                          class="form-floating ${not empty passwordError ? 'is-invalid' : ''}"
                        >
                          <form:input
                            cssClass="form-control ${not empty passwordError ? 'is-invalid' : ''}"
                            type="password"
                            placeholder="Password"
                            required="true"
                            path="password"
                          />
                          <form:label path="password">Mật khẩu</form:label>
                        </div>
                        <span class="input-group-text rounded-end"
                          ><i
                            class="bi bi-eye-slash-fill fs-4"
                            role="button"
                            id="toggle-password"
                          ></i
                        ></span>
                        <div class="invalid-feedback">
                          Vui lòng điền Mật khẩu
                        </div>
                        ${passwordError}
                        <div
                          class="form-text ${not empty passwordError ? 'd-none' : ''}"
                        >
                          Chứa tối thiểu 8 kí tự bao gồm chữ in hoa, in thường,
                          số và kí tự đặc biệt
                        </div>
                      </div>

                      <!-- confirm password -->
                      <div class="input-group has-validation">
                        <c:set var="confirmPasswordError">
                          <form:errors
                            path="confirmPassword"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set>
                        <div
                          class="form-floating ${not empty confirmPasswordError ? 'is-invalid' : ''}"
                        >
                          <form:input
                            cssClass="form-control ${not empty confirmPasswordError ? 'is-invalid' : ''} rounded-end"
                            type="password"
                            placeholder="confirmPassword"
                            required="true"
                            path="confirmPassword"
                          />
                          <form:label path="confirmPassword"
                            >Nhập lại Mật khẩu</form:label
                          >
                        </div>
                        <div class="invalid-feedback">
                          Vui lòng nhập lại Mật khẩu ở trên
                        </div>
                        ${confirmPasswordError}
                      </div>

                      <div class="mt-4">
                        <div class="d-grid">
                          <button
                            type="submit"
                            class="btn btn-primary btn-block"
                          >
                            Đăng ký
                          </button>
                        </div>
                      </div>
                    </form:form>

                    <!-- OAuth2 -->
                    <div class="mb-2">
                      <div class="position-relative">
                        <hr class="mt-4 mb-3" />
                        <span
                          class="bg-white px-1 pb-1 position-absolute translate-middle top-50 start-50"
                          >Hoặc đăng nhập với</span
                        >
                      </div>
                      <div class="d-flex gap-3 justify-content-center">
                        <!-- Google -->
                        <a
                          href="/oauth2/authorization/google"
                          class="rounded-circle bg-white p-1 d-inline-block shadow user-select-none"
                          style="width: 48px; height: 48px"
                          title="Google"
                        >
                          <img
                            class="img-fluid"
                            src="/images/others/google-login.png"
                          />
                        </a>

                        <!-- Github -->
                        <a
                          href="/oauth2/authorization/github"
                          class="rounded-circle bg-white p-1 d-inline-block shadow user-select-none"
                          style="width: 48px; height: 48px"
                          title="Github"
                        >
                          <img
                            class="img-fluid"
                            src="/images/others/github-login.png"
                          />
                        </a>
                      </div>
                    </div>
                  </div>
                  <div class="card-footer text-center py-3">
                    <div class="small">
                      <span>Đã có tài khoản?</span>
                      <a href="/login" class="fw-medium"> Đăng nhập</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="/js/scripts.js"></script>
    <script>
      $(document).ready(() => {
        if ($("#registration-form .server-validate-feedback").length > 0) {
          $("#registration-form .server-validate-feedback")
            .siblings(".invalid-feedback:not(.server-validate-feedback)")
            .addClass("d-none");
        }

        // handle events
        $("#registration-form").submit(function (e) {
          if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();

            $(this)
              .find("input")
              .each(function () {
                if (!this.checkValidity()) {
                  $(this).addClass("is-invalid");
                  $(this).closest(".form-floating").addClass("is-invalid");
                }
              });
          }
        });

        $("#registration-form input").on("input", function () {
          $(this).parent().siblings(".server-validate-feedback").remove();
          $(this)
            .parent()
            .siblings(".invalid-feedback:not(.server-validate-feedback)")
            .removeClass("d-none");
          $(this).parent().siblings(".form-text").removeClass("d-none");

          if (!this.checkValidity()) {
            $(this).addClass("is-invalid");
            $(this).closest(".form-floating").addClass("is-invalid");
          } else {
            $(this).removeClass("is-invalid");
            $(this).closest(".form-floating").removeClass("is-invalid");
          }
        });

        $("#toggle-password").on("click", function () {
          const show =
            $("#password").attr("type") === "password" ? true : false;
          $("#password").attr("type", show ? "text" : "password");
          $(this).removeClass(show ? "bi-eye-slash-fill" : "bi-eye-fill");
          $(this).addClass(show ? "bi-eye-fill" : "bi-eye-slash-fill");
        });
      });
    </script>
  </body>
</html>
