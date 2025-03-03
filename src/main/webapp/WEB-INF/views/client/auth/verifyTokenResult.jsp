<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

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
          <div class="container d-flex" style="min-height: 65vh">
            <div class="row justify-content-center mt-5 flex-grow-1">
              <div class="col-md-6 col h-100">
                <div
                  class="card shadow-lg rounded-lg border-0 my-5"
                  style="min-height: 60%"
                >
                  <div
                    class="card-body d-flex flex-column justify-content-center"
                  >
                    <div class="text-center text-dark">
                      <i
                        class="${not empty successMessage ? 'bi bi-check-circle text-success' : 'bi bi-x-circle text-red'}"
                        style="font-size: 65px"
                      ></i>
                      <p class="fw-medium">
                        ${not empty successMessage ? successMessage :
                        errorMessage}
                      </p>
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
  </body>
</html>
