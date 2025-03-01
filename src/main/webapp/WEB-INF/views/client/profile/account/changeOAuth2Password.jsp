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
    <link rel="manifest" href="/site.webmanifest" />
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />

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
              <div class="col-7 text-center">
                <img
                  src="/images/others/mail.png"
                  alt=""
                  style="width: 35%"
                  class="mb-3"
                />
                <p class="fw-medium" style="font-size: 18px">
                  Nhận đường dẫn thiết lập mật khẩu qua địa chỉ email <br />
                  <b class="text-primary">${email}</b>
                </p>
                <button
                  id="send-btn"
                  type="button"
                  class="btn btn-outline-primary mt-4 py-2 d-flex align-items-center justify-content-center gap-2 mx-auto"
                  style="width: 155px; height: 42px"
                >
                  <span id="send-btn-label">Xác nhận</span>
                  <div id="sending-loader" style="display: none">
                    <span
                      class="spinner-border spinner-border-sm"
                      aria-hidden="true"
                    ></span>
                    <span role="status" class="small">Đang gửi...</span>
                  </div>

                  <span id="resend-text" class="small d-none">
                    Gửi lại sau
                    <span id="resend-counter">60</span>
                    giây
                  </span>
                </button>
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
      const COUNT_DOWN_TIME = 60;

      $(document).ready(() => {
        $.ajaxSetup({
          headers: {
            "${_csrf.headerName}": "${_csrf.token}",
            "Content-Type": "application/json; charset=UTF-8",
          },
        });
        const startCountDown = (time = COUNT_DOWN_TIME) => {
          const intervalId = setInterval(() => {
            time -= 1;
            if (time == 0) {
              clearInterval(intervalId);
              $("#resend-text").addClass("d-none");
              $("#send-btn-label").text("Gửi lại").removeClass("d-none");
              $("#send-btn").removeAttr("disabled");
            }
            $("#resend-counter").text(time);
          }, 1000);
        };

        // handle events
        $("#send-btn").click(function () {
          $(this).attr("disabled", true);
          $("#send-btn-label").addClass("d-none");
          $("#sending-loader").fadeIn("fast");

          // call api for sending mail
          $.post(
            "/profile/account/password/sendMail",
            JSON.stringify({
              email: "${email}",
            })
          )
            .done((response) => {
              alert(response);
            })
            .fail((response) => {
              alert(response.responseText);
            })
            .always(() => {
              $("#sending-loader").fadeOut("fast", () => {
                $("#resend-counter").text(COUNT_DOWN_TIME);
                $("#resend-text").removeClass("d-none");
                startCountDown();
              });
            });
        });
      });
    </script>
  </body>
</html>
