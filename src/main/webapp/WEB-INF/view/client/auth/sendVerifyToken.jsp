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
    <title>Safie - An tâm cho con | ${title}</title>

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
        <div class="text-black fs-2 pt-2" style="color: black">${title}</div>
      </div>
    </nav>

    <div id="layoutAuthentication">
      <div id="layoutAuthentication_content">
        <main>
          <div class="container" style="min-height: 65vh">
            <div class="row justify-content-center mt-5">
              <div class="col-md-5 col">
                <div class="card shadow-lg rounded-lg border-0 my-5">
                  <div class="card-body text-dark">
                    <c:if test="${not empty errorMessage}">
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
                      <% session.removeAttribute("errorMessage"); %>
                    </c:if>
                    <div class="text-center py-3">
                      <img src="/images/others/mail.png" alt="" class="w-50" />
                    </div>
                    <p class="fw-medium" style="text-align: justify">
                      ${message}
                    </p>
                    <div class="text-center">
                      <a href="/login" class="btn btn-secondary shadow-sm">
                        Về trang đăng nhập
                      </a>
                    </div>
                  </div>
                  <div class="card-footer fw-medium" style="font-size: 14px">
                    <div class="d-flex align-items-center py-2">
                      Chưa nhận được đường dẫn?
                      <span class="text-nowrap ms-2">
                        <span id="resend-count-down" class="text-dark d-none">
                          Gửi lại sau
                          <span
                            id="count-down"
                            class="text-primary fw-bold"
                          ></span>
                          giây
                        </span>
                        <span class="fw-bold">
                          <a
                            id="resend-btn"
                            role="button"
                            class="text-blue"
                            style="display: none"
                            >Gửi lại
                          </a>
                          <span id="resend-loader" class="text-blue">
                            <span
                              role="status"
                              class="spinner-border spinner-border-sm"
                            ></span>
                            <span class="ms-1">Đang gửi...</span>
                          </span>
                        </span>
                      </span>
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
      const COUNT_DOWN_TIME = 60;

      $(document).ready(() => {
        $.ajaxSetup({
          headers: {
            "${_csrf.headerName}": "${_csrf.token}",
            "Content-Type": "application/json; charset=UTF-8",
          },
        });
        const startCountDown = (time = COUNT_DOWN_TIME) => {
          $("#count-down").text(time);
          $("#resend-count-down").removeClass("d-none");
          $("#resend-btn").css("display", "none");

          const intervalId = setInterval(function () {
            time -= 1;
            $("#count-down").text(time);
            if (time == 0) {
              $("#resend-count-down").addClass("d-none");
              $("#resend-btn").css("display", "inline");
              clearInterval(intervalId);
            }
          }, 1000);
        };
        const sendVerifyMail = () => {
          $.post(
            "${sendMailAPI}",
            JSON.stringify({
              email: "${param.email}",
            }),
            function (response) {
              alert(response);
            }
          )
            .fail((response) => alert(response.responseText))
            .always(() => {
              $("#resend-loader").fadeOut("fast", () => startCountDown());
            });
        };

        sendVerifyMail();

        $("#resend-btn").click(function () {
          $("#resend-btn").fadeOut("fast", () => {
            $("#resend-loader").fadeIn("fast", () => {
              sendVerifyMail();
            });
          });
        });
      });
    </script>
  </body>
</html>
