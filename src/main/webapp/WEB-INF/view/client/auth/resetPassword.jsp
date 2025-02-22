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
    <title>Safie - An tâm cho con | Thiết lập mật khẩu</title>

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
        <div class="text-black fs-2 pt-2" style="color: black">
          Thiết lập mật khẩu
        </div>
      </div>
    </nav>

    <div id="layoutAuthentication">
      <div id="layoutAuthentication_content">
        <main>
          <div class="container">
            <div class="row justify-content-center mt-5 pt-5">
              <div class="col-md-5 col">
                <div class="card shadow-lg rounded-lg border-0">
                  <div class="card-body text-dark pt-5 pb-4 px-5">
                    <form:form
                      id="reset-password-form"
                      action="/profile/account/password/reset"
                      method="post"
                      modelAttribute="resetPasswordDTO"
                      novalidate="true"
                    >
                      <!-- newPassword -->
                      <div class="input-group has-validation mb-3">
                        <c:set var="newPasswordError">
                          <form:errors
                            path="newPassword"
                            cssClass="server-validate"
                          />
                        </c:set>
                        <div
                          class="form-floating ${not empty newPasswordError ? 'is-invalid' : ''}"
                        >
                          <form:input
                            type="password"
                            cssClass="form-control ${not empty newPasswordError ? 'is-invalid' : ''}"
                            path="newPassword"
                            placeholder="newPassword"
                            required="true"
                          />
                          <form:label path="newPassword">
                            Mật khẩu mới
                          </form:label>
                        </div>
                        <span class="input-group-text rounded-end">
                          <i
                            class="bi bi-eye-slash-fill fs-4"
                            role="button"
                            id="toggle-password"
                          ></i>
                        </span>
                        <div class="invalid-feedback">
                          <span
                            class="client-validate ${not empty newPasswordError ? 'd-none' : ''}"
                          >
                            Bắt buộc nhập mật khẩu mới
                          </span>
                          ${newPasswordError}
                        </div>
                        <div
                          class="form-text ${not empty newPasswordError ? 'd-none' : ''}"
                        >
                          Chứa tối thiểu 8 kí tự bao gồm chữ in hoa, in thường,
                          số và kí tự đặc biệt
                        </div>
                      </div>

                      <!-- confirmNewPassword -->
                      <div class="form-floating mb-5">
                        <c:set var="confirmNewPasswordError">
                          <form:errors
                            path="confirmNewPassword"
                            cssClass="server-validate"
                          />
                        </c:set>
                        <form:input
                          type="password"
                          cssClass="form-control ${not empty confirmNewPasswordError ? 'is-invalid' : ''}"
                          path="confirmNewPassword"
                          placeholder="confirmNewPassword"
                          required="true"
                        />
                        <form:label path="confirmNewPassword">
                          Nhập lại mật khẩu mới
                        </form:label>
                        <div class="invalid-feedback">
                          <span
                            class="client-validate ${not empty confirmNewPasswordError ? 'd-none' : ''}"
                          >
                            Bắt buộc nhập lại mật khẩu mới
                          </span>
                          ${confirmNewPasswordError}
                        </div>
                      </div>

                      <form:input type="hidden" path="token" />

                      <button
                        class="btn btn-primary mx-auto d-block"
                        style="width: 124px"
                      >
                        Xác nhận
                      </button>
                    </form:form>
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
      $(document).ready(function () {
        // handle events
        $("#reset-password-form").submit(function (e) {
          if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
          }

          $("#newPassword")
            .parent()
            .siblings(".form-text")
            .removeClass("d-none");
          if (!$("#newPassword")[0].checkValidity()) {
            $("#newPassword").addClass("is-invalid");
            $("#newPassword").parent().addClass("is-invalid");
          } else {
            $("#newPassword").removeClass("is-invalid");
            $("#newPassword").parent().removeClass("is-invalid");
          }

          if (!$("#confirmNewPassword")[0].checkValidity()) {
            $("#confirmNewPassword").addClass("is-invalid");
          } else {
            $("#confirmNewPassword").removeClass("is-invalid");
          }

          $(".client-validate").removeClass("d-none");
          $(".server-validate").remove();
        });

        $("#newPassword").on("input", function () {
          const invalidFeedback = $(this)
            .parent()
            .siblings(".invalid-feedback");
          invalidFeedback.find(".server-validate").remove();
          invalidFeedback.find(".client-validate").removeClass("d-none");
          $(this).parent().siblings(".form-text").removeClass("d-none");

          if (!this.checkValidity()) {
            $(this).addClass("is-invalid");
            $(this).parent().addClass("is-invalid");
          } else {
            $(this).removeClass("is-invalid");
            $(this).parent().removeClass("is-invalid");
          }
        });

        $("#confirmNewPassword").on("input", function () {
          const invalidFeedback = $(this).siblings(".invalid-feedback");
          invalidFeedback.find(".server-validate").remove();
          invalidFeedback.find(".client-validate").removeClass("d-none");

          if (!this.checkValidity()) {
            $(this).addClass("is-invalid");
          } else {
            $(this).removeClass("is-invalid");
          }
        });

        $("#toggle-password").on("click", function () {
          const show =
            $("#newPassword").attr("type") === "password" ? true : false;
          $("#newPassword").attr("type", show ? "text" : "password");
          $(this).removeClass(show ? "bi-eye-slash-fill" : "bi-eye-fill");
          $(this).addClass(show ? "bi-eye-fill" : "bi-eye-slash-fill");
        });
      });
    </script>
  </body>
</html>
