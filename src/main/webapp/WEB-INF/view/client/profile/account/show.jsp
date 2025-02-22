<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Thông tin tài khoản</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

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
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css
    "
    /> -->

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link
      href="/client/lib/owlcarousel/assets/owl.carousel.min.css"
      rel="stylesheet"
    />

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

    <!-- Account Info Page Start -->

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
            style="min-height: 463px"
          >
            <h2 class="fs-3 mb-4">Thông tin tài khoản</h2>
            <form:form
              action="/profile/account"
              method="post"
              cssClass="container container-fluid flex-grow-1 d-flex flex-column"
              enctype="multipart/form-data"
              novalidate="true"
              id="form"
              modelAttribute="user"
            >
              <div class="row flex-nowrap mb-3">
                <!-- Thông tin text -->
                <div class="col-8" style="min-width: 450px">
                  <table class="table table-borderless">
                    <!-- email -->
                    <tr>
                      <td class="text-end pe-3 fw-medium">
                        <form:label
                          for="email"
                          path="email"
                          cssClass="col-form-label"
                          >Email</form:label
                        >
                      </td>
                      <td>
                        <form:input
                          type="email"
                          id="email"
                          path="email"
                          cssClass="form-control-plaintext"
                          readonly="true"
                          required="true"
                          disabled="true"
                        />
                      </td>
                    </tr>
                    <!-- fullName -->
                    <tr>
                      <td class="text-end pe-3 fw-medium">
                        <form:label
                          for="fullName"
                          path="fullName"
                          cssClass="col-form-label"
                          >Họ Tên</form:label
                        >
                      </td>
                      <td>
                        <c:set var="nameBindError">
                          <form:errors
                            path="fullName"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set>
                        <form:input
                          type="text"
                          id="fullName"
                          path="fullName"
                          cssClass="form-control ${not empty nameBindError ? 'is-invalid' : ''}"
                          spellcheck="false"
                          required="true"
                        />
                        <div class="invalid-feedback">
                          Thông tin bắt buộc nhập
                        </div>
                        ${nameBindError}
                      </td>
                    </tr>
                    <!-- phone -->
                    <tr>
                      <td class="text-end pe-3 fw-medium">
                        <form:label
                          for="phone"
                          path="phone"
                          cssClass="col-form-label"
                          >Số điện thoại</form:label
                        >
                      </td>
                      <td>
                        <c:set var="phoneBindError">
                          <form:errors
                            path="phone"
                            cssClass="invalid-feedback server-validate-feedback"
                          />
                        </c:set>
                        <form:input
                          type="text"
                          path="phone"
                          id="phone"
                          cssClass="form-control ${not empty phoneBindError ? 'is-invalid' : ''}"
                          spellcheck="false"
                          pattern="\d{10}"
                        />
                        <div class="invalid-feedback">SĐT gồm 10 chữ số</div>
                        ${phoneBindError}
                      </td>
                    </tr>
                    <!-- Gender -->
                    <tr>
                      <td class="text-end pe-3 fw-medium">
                        <form:label path="gender">Gender</form:label>
                      </td>
                      <td>
                        <div class="form-check form-check-inline">
                          <form:radiobutton
                            path="gender"
                            value="male"
                            label="Nam"
                            cssClass="form-check-input form-check-label"
                          />
                        </div>
                        <div class="form-check form-check-inline">
                          <form:radiobutton
                            path="gender"
                            value="female"
                            label="Nữ"
                            cssClass="form-check-input form-check-label"
                          />
                        </div>
                        <div class="form-check form-check-inline">
                          <form:radiobutton
                            path="gender"
                            value="other"
                            label="Khác"
                            cssClass="form-check-input form-check-label"
                          />
                        </div>
                      </td>
                    </tr>
                  </table>
                </div>
                <!-- file ảnh -->
                <div
                  class="col-4 border-start d-flex flex-column align-items-center"
                  style="min-width: 200px"
                >
                  <form:input type="hidden" path="avatar" id="avatar" />
                  <img
                    src="/images/avatar/${not empty user.avatar ? user.avatar : 'user_placeholder.png'}"
                    id="avatar-preview"
                    alt="avatar preview"
                    class="rounded-circle mb-3"
                    style="aspect-ratio: 1 / 1; width: 120px; object-fit: cover"
                    role="button"
                  />
                  <div class="d-flex flex-column gap-1">
                    <button
                      id="avatar-btn"
                      type="button"
                      class="btn btn-outline-dark"
                    >
                      Chọn Ảnh
                    </button>
                    <div class="form-text" id="image-file-helper">
                      <div>Dung lượng file tối đa ${fileMaxSize} MB</div>
                      <div>Định dạng: .JPEG, .PNG</div>
                    </div>
                  </div>

                  <button
                    class="btn btn-outline-red rounded-circle mt-3"
                    title="Gỡ ảnh đại diện"
                    type="button"
                    id="remove-avatar-btn"
                  >
                    <i class="bi bi-x-lg"></i>
                  </button>

                  <input
                    type="file"
                    id="avatar-file"
                    name="avatarFile"
                    class="form-control d-none"
                    accept=".jpg,.jpeg,.png"
                    aria-describedby="image-file-helper"
                  />
                  <input
                    type="file"
                    id="avatar-file-tmp"
                    class="form-control d-none"
                    accept=".jpg,.jpeg,.png"
                    aria-hidden="true"
                  />
                </div>
              </div>

              <div class="row mt-auto">
                <button class="col-auto btn btn-primary px-4 mx-auto">
                  Lưu
                </button>
              </div>
              <!-- <input
                type="hidden"
                name="${_csrf.parameterName}"
                value="${_csrf.token}"
              /> -->
            </form:form>
          </div>
        </div>
      </div>
    </div>

    <!-- Account Info Page End -->

    <jsp:include page="../../layout/footer.jsp" />

    <!-- Back to Top -->
    <a
      href="#"
      class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- JavaScript Libraries -->
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
      integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <script>
      const fileMaxSize = "${fileMaxSize}" * 1024 * 1024; // convert MB to B
      // console.log(fileMaxSize);

      $(document).ready(function () {
        if (!$("#avatar").val()) {
          $("#remove-avatar-btn").hide();
        }
        $("#avatar-preview, #avatar-btn").click(() =>
          $("#avatar-file-tmp").click()
        );
        $("#avatar-file-tmp").change(function (e) {
          // console.log(e.target.files);

          if (e.target.files.length > 0) {
            const size = e.target.files[0].size;
            // console.log(size);
            if (size <= fileMaxSize) {
              $("#avatar-file").prop("files", e.target.files);
              $("#avatar").val("");
              const avatarURL = URL.createObjectURL(e.target.files[0]);
              // console.log(avatarURL);
              $("#avatar-preview").attr("src", avatarURL);
              $("#remove-avatar-btn").show(150);
            } else {
              $(this).val("");
              alertModal(`File ảnh vượt quá ${fileMaxSize} MB`, "error");
            }
          }
        });
        $("#remove-avatar-btn").click(function () {
          $("#avatar-file").val("");
          $("#avatar-file-tmp").val("");
          $("#avatar").val("");
          $("#avatar-preview").attr(
            "src",
            "/images/avatar/user_placeholder.png"
          );
          $(this).hide(150);
        });

        // validate form
        $("#form").submit(function (e) {
          if (!this.checkValidity()) {
            e.stopPropagation();
            e.preventDefault();
            $(this)
              .find("input")
              .each(function () {
                if (!this.checkValidity()) $(this).addClass("is-invalid");
              });
          }
          // $(this).addClass("was-validated");
        });
        $("#form")
          .find("input")
          .on("input change", function () {
            $(this).siblings(".server-validate-feedback").remove();
            $(this)
              .siblings(".invalid-feedback:not(.server-validate-feedback)")
              .removeClass("d-none");

            if (!this.checkValidity()) $(this).addClass("is-invalid");
            else if ($(this).hasClass("is-invalid"))
              $(this).removeClass("is-invalid");
          });
        $(".server-validate-feedback")
          .siblings(".invalid-feedback:not(.server-validate-feedback)")
          .addClass("d-none");
      });
    </script>
  </body>
</html>
