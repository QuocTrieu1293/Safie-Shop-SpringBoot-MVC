<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Thay đổi mật khẩu</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />
    <link rel="manifest" href="/static/site.webmanifest" />
    <link rel="icon" type="image/x-icon" href="/static/favicon.ico" />

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
    <!-- <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    /> -->

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/mycss.css" />
  </head>

  <body class="bg-gray-white">
    <!-- Spinner Start -->
    <div
      id="spinner"
      class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../../layout/header.jsp" />

    <!-- Cart Page Start -->

    <div
      class="container container-fluid py-md-4"
      style="margin-top: 180px; min-height: 85vh"
    >
      <div class="row flex-nowrap">
        <div class="col-auto">
          <jsp:include page="../sideNav.jsp" />
        </div>
        <div class="col" style="min-width: 830px">
          <div
            class="rounded shadow-sm bg-white p-4 pb-5 d-flex flex-column"
            style="min-height: 450px"
          >
            <h2 class="fs-3 mb-4">Thay đổi mật khẩu</h2>
            <div class="row justify-content-center">
              <div class="col-7">
                <form:form
                  id="changePassword-form"
                  action="/profile/account/password"
                  method="post"
                  modelAttribute="changePasswordDTO"
                  novalidate="true"
                >
                  <table
                    class="table table-borderless"
                    style="border-collapse: separate; border-spacing: 5px 10px"
                  >
                    <!-- password -->
                    <tr>
                      <td class="text-end fw-medium text-nowrap">
                        <form:label path="password" cssClass="mt-3">
                          Mật khẩu hiện tại
                        </form:label>
                      </td>
                      <td>
                        <c:set var="passwordError">
                          <form:errors
                            path="password"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set>
                        <div class="input-group has-validation">
                          <form:input
                            type="password"
                            path="password"
                            cssClass="form-control ${not empty passwordError ? 'is-invalid' : ''}"
                            required="true"
                          />
                          <span class="input-group-text rounded-end">
                            <i
                              class="bi bi-eye-slash-fill fs-4"
                              role="button"
                              id="toggle-password"
                            >
                            </i>
                          </span>
                          <div class="invalid-feedback">
                            Vui lòng nhập mật khẩu
                          </div>
                          ${passwordError}
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2"><hr /></td>
                    </tr>
                    <!-- new password -->
                    <tr>
                      <td class="text-end fw-medium text-nowrap">
                        <form:label path="newPassword" cssClass="mt-3"
                          >Mật khẩu mới</form:label
                        >
                      </td>
                      <td>
                        <c:set var="newPasswordError">
                          <form:errors
                            path="newPassword"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set>
                        <div class="input-group has-validation">
                          <form:input
                            type="password"
                            path="newPassword"
                            cssClass="form-control ${not empty newPasswordError ? 'is-invalid' : ''}"
                            required="true"
                          />
                          <span class="input-group-text rounded-end">
                            <i
                              class="bi bi-eye-slash-fill fs-4"
                              role="button"
                              id="toggle-newPassword"
                            >
                            </i>
                          </span>
                          <div class="invalid-feedback">
                            Vui lòng nhập mật khẩu mới
                          </div>
                          ${newPasswordError}
                        </div>
                        <div
                          class="form-text ${not empty newPasswordError ? 'd-none' : ''}"
                        >
                          Chứa tối thiểu 8 kí tự bao gồm chữ in hoa, in thường,
                          số và kí tự đặc biệt
                        </div>
                      </td>
                    </tr>
                    <!-- confirm new password -->
                    <tr>
                      <td class="text-end fw-medium text-nowrap">
                        <form:label
                          path="confirmNewPassword"
                          cssClass="col-form-label"
                        >
                          Nhập lại mật khẩu mới
                        </form:label>
                      </td>
                      <td>
                        <c:set var="confirmNewPasswordError">
                          <form:errors
                            path="confirmNewPassword"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set>
                        <form:input
                          type="password"
                          path="confirmNewPassword"
                          class="form-control ${not empty confirmNewPasswordError ? 'is-invalid' : ''}"
                          required="true"
                        />
                        <div class="invalid-feedback">
                          Vui lòng nhập lại mật khẩu mới
                        </div>
                        ${confirmNewPasswordError}
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2"></td>
                    </tr>
                  </table>
                  <div class="row justify-content-center">
                    <div class="col-auto">
                      <button type="submit" class="btn btn-primary px-4">
                        Xác nhận
                      </button>
                    </div>
                  </div>
                </form:form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Cart Page End -->

    <jsp:include page="../../layout/footer.jsp" />

    <!-- Back to Top -->
    <a
      href="#"
      class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <script>
      $(document).ready(function () {
        $(".server-validate-feedback")
          .siblings(".invalid-feedback")
          .addClass("d-none");

        // handle events
        $("#changePassword-form").submit(function (e) {
          if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();

            $(this)
              .find("input")
              .each(function () {
                if (!this.checkValidity()) $(this).addClass("is-invalid");
              });
          }
        });

        $("#changePassword-form input").on("input", function () {
          $(this).siblings(".server-validate-feedback").remove();
          $(this)
            .siblings(".invalid-feedback:not(.server-validate-feedback)")
            .removeClass("d-none");
          $(this).parent().siblings(".form-text").removeClass("d-none");

          if (!this.checkValidity()) {
            $(this).addClass("is-invalid");
          } else {
            $(this).removeClass("is-invalid");
          }
        });

        $("#toggle-password").on("click", function () {
          const show =
            $("#password").attr("type") === "password" ? true : false;
          $("#password").attr("type", show ? "text" : "password");
          $(this).removeClass(show ? "bi-eye-slash-fill" : "bi-eye-fill");
          $(this).addClass(show ? "bi-eye-fill" : "bi-eye-slash-fill");
        });
        $("#toggle-newPassword").on("click", function () {
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
