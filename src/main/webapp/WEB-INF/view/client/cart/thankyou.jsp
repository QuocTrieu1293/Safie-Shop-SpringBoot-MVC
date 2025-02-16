<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Cảm ơn quý khách đã mua hàng</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />

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
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
      rel="stylesheet"
    />

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
    <link
      href="https://fonts.googleapis.com/css?family=Lato:300,400|Montserrat:700"
      rel="stylesheet"
      type="text/css"
    />
  </head>

  <body>
    <!-- Spinner Start -->
    <div
      id="spinner"
      class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../layout/header.jsp" />

    <!-- Page Start -->

    <div class="container-fluid" style="margin-top: 180px">
      <div class="container py-md-4">
        <h1 class="text-center fw-bold" style="font-size: 50px">CẢM ƠN BẠN</h1>

        <div
          class="main-content justify-content-center text-center d-flex flex-column"
        >
          <i class="fa fa-check text-success fs-1"></i>
          <div class="text-start align-self-center fw-medium px-md-5 px-3">
            <p>
              Đơn hàng với mã là <b class="text-primary">#${orderId}</b> của bạn
              đã được xác nhận và chúng tôi sẽ sớm giao đến bạn. Cảm ơn bạn đã
              tin tưởng và lựa chọn những sản phẩm quần áo organic an toàn cho
              bé yêu của mình. 💚
            </p>
            <p>
              Thông tin về đơn hàng sẽ được gửi qua email
              <b class="text-primary">${email}</b>. Nếu cần hỗ trợ thêm, vui
              lòng liên hệ với chúng tôi!
            </p>
          </div>
          <a
            href="/products"
            class="btn btn-success text-white align-self-center"
            >Tiếp tục mua sắm</a
          >
        </div>
      </div>
      <jsp:include page="../layout/feature.jsp" />
    </div>

    <!-- Page End -->

    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a
      href="#"
      class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <script>
      const redirectAttributes = {
        email: "${email}",
        orderId: "${orderId}",
      };
      // console.log(redirectAttributes);

      fetch("/api/order/sendVerifyMail", {
        method: "POST",
        headers: {
          "Content-Type": "application/json;charset=utf-8",
          "${_csrf.headerName}": "${_csrf.token}",
        },
        body: JSON.stringify(redirectAttributes),
      })
        .then((response) => {
          if (!response.ok) return Promise.reject("Mail sent fail");
          return response.text();
        })
        .then((data) => console.log(data))
        .catch((e) => console.log(e));
    </script>
  </body>
</html>
