<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>${product.name} - Safie</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
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

    <style>
      .card-title {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        font-size: 14px;
        letter-spacing: 1px;
        color: #45595b;
      }

      .size-tag {
        padding: 5px;
        border: solid 1px var(--bs-secondary);
        border-radius: 5px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 150ms linear;
        background-color: whitesmoke;
      }

      .size-tag:has(input[type="radio"]:not(:checked)):hover {
        background-color: rgba(0, 0, 0, 0.3);
        color: var(--bs-white);
      }

      .size-tag:has(input[type="radio"]:checked) {
        border-color: var(--bs-primary);
        background-color: #e0b8b835;
        /* color: var(--bs-secondary); */
      }
    </style>
  </head>

  <body>
    <c:set var="view" value="product detail" scope="session" />
    <!-- Spinner Start -->
    <div
      id="spinner"
      class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../layout/header.jsp" />

    <!-- Single Product Start -->
    <div class="container-fluid" style="margin-top: 180px">
      <div class="container py-4">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-3">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item active">Chi tiết sản phẩm</li>
          </ol>
        </nav>
        <div class="row g-5 mb-5">
          <div class="col-lg-8 col-xl-9">
            <div class="row g-4">
              <form
                id="add-to-cart-form"
                action="/add-product-to-cart/${product.id}"
                method="post"
                class="row g-4"
              >
                <div class="col-lg-6">
                  <div class="border rounded">
                    <a href="#">
                      <img
                        src="/images/product/${product.image}"
                        class="img-fluid rounded object-fit-cover"
                        alt="Image"
                      />
                    </a>
                  </div>
                </div>
                <div class="col-lg-6">
                  <h4 class="fw-bold mb-3">${product.name}</h4>
                  <div class="mb-3">
                    <p>Danh mục: <a href="#">${product.category.name}</a></p>
                    <p>Thương hiệu: <a href="#">${product.brand.name}</a></p>
                    <div>
                      <p class="col-12">Kích thước:</p>
                      <div class="row m-0">
                        <c:forEach var="size" items="${product.sizes}">
                          <label
                            for="sizeId-${size.id}"
                            class="size-tag col-auto me-2 mb-2"
                          >
                            ${size.name}
                            <input
                              id="sizeId-${size.id}"
                              type="radio"
                              name="sizeId"
                              value="${size.id}"
                              class="d-none"
                              required
                            />
                          </label>
                        </c:forEach>
                        <!-- <span class="size-tag col-auto me-2 mb-2" selected="true"
                        >12-18 tháng</span
                      > -->
                      </div>
                    </div>
                  </div>
                  <h3 class="fw-bold mb-3">
                    <fmt:formatNumber type="number" value="${product.price}" />
                    đ
                  </h3>
                  <div class="d-flex mb-4">
                    <i class="fa fa-star text-warning"></i>
                    <i class="fa fa-star text-warning"></i>
                    <i class="fa fa-star text-warning"></i>
                    <i class="fa fa-star text-warning"></i>
                    <i class="fa fa-star"></i>
                  </div>
                  <p class="mb-4">${product.shortDesc}</p>

                  <div
                    class="input-group quantity mb-5 align-items-center"
                    style="width: 100px"
                  >
                    <div class="input-group-btn">
                      <button
                        class="btn btn-sm btn-minus rounded-circle bg-light border"
                      >
                        <i class="fa fa-minus"></i>
                      </button>
                    </div>
                    <input
                      type="text"
                      class="form-control form-control-sm text-center border-0 fw-bold"
                      style="font-size: 18px"
                      value="1"
                      name="quantity"
                      id="quantity-input"
                    />
                    <div class="input-group-btn">
                      <button
                        class="btn btn-sm btn-plus rounded-circle bg-light border"
                      >
                        <i class="fa fa-plus"></i>
                      </button>
                    </div>
                  </div>
                  <button
                    class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
                  >
                    <i class="fa fa-shopping-bag me-2 text-primary"></i> Thêm
                    vào giỏ hàng
                  </button>
                </div>
                <input
                  type="hidden"
                  name="${_csrf.parameterName}"
                  value="${_csrf.token}"
                />
              </form>
              <!-- Nav Tab -->
              <div class="col-lg-12">
                <nav>
                  <div class="nav nav-tabs mb-3">
                    <button
                      class="nav-link active border-white border-bottom-0"
                      type="button"
                      role="tab"
                      id="nav-about-tab"
                      data-bs-toggle="tab"
                      data-bs-target="#nav-about"
                      aria-controls="nav-about"
                      aria-selected="true"
                    >
                      Description
                    </button>
                    <button
                      class="nav-link border-white border-bottom-0"
                      type="button"
                      role="tab"
                      id="nav-mission-tab"
                      data-bs-toggle="tab"
                      data-bs-target="#nav-mission"
                      aria-controls="nav-mission"
                      aria-selected="false"
                    >
                      Reviews
                    </button>
                  </div>
                </nav>
                <!-- Tab -->
                <div class="tab-content mb-5">
                  <div
                    class="tab-pane active"
                    id="nav-about"
                    role="tabpanel"
                    aria-labelledby="nav-about-tab"
                  >
                    <!-- <p>
                      The generated Lorem Ipsum is therefore always free from
                      repetition injected humour, or non-characteristic words
                      etc. Susp endisse ultricies nisi vel quam suscipit
                    </p>
                    <p>
                      Sabertooth peacock flounder; chain pickerel hatchetfish,
                      pencilfish snailfish filefish Antarctic icefish goldeye
                      aholehole trumpetfish pilot fish airbreathing catfish,
                      electric ray sweeper.
                    </p> -->
                    <p>${product.detailDesc}</p>
                    <div class="px-2">
                      <div class="row g-4">
                        <div class="col-6">
                          <div
                            class="row bg-light align-items-center text-center justify-content-center py-2"
                          >
                            <div class="col-6">
                              <p class="mb-0">Size</p>
                            </div>
                            <div class="col-6">
                              <p class="mb-0">0-3 tháng, 3-6 tháng</p>
                            </div>
                          </div>
                          <div
                            class="row text-center align-items-center justify-content-center py-2"
                          >
                            <div class="col-6">
                              <p class="mb-0">Chứng chỉ</p>
                            </div>
                            <div class="col-6">
                              <p class="mb-0">GOTS</p>
                            </div>
                          </div>

                          <div
                            class="row text-center align-items-center justify-content-center py-2 bg-light"
                          >
                            <div class="col-6">
                              <p class="mb-0">Chất lượng</p>
                            </div>
                            <div class="col-6">
                              <p class="mb-0">Organic</p>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div
                    class="tab-pane"
                    id="nav-mission"
                    role="tabpanel"
                    aria-labelledby="nav-mission-tab"
                  >
                    <div class="d-flex">
                      <img
                        src="/client/img/avatar.jpg"
                        class="img-fluid rounded-circle p-3 object-fit-cover"
                        style="width: 100px; height: 100px"
                        alt=""
                      />
                      <div class="">
                        <p class="mb-2" style="font-size: 14px">
                          April 12, 2024
                        </p>
                        <div class="d-flex justify-content-between">
                          <h5>Jason Smith</h5>
                          <div class="d-flex mb-3">
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star"></i>
                          </div>
                        </div>
                        <p>
                          The generated Lorem Ipsum is therefore always free
                          from repetition injected humour, or non-characteristic
                          words etc. Susp endisse ultricies nisi vel quam
                          suscipit
                        </p>
                      </div>
                    </div>
                    <div class="d-flex">
                      <img
                        src="/client/img/avatar.jpg"
                        class="img-fluid rounded-circle p-3 object-fit-cover"
                        style="width: 100px; height: 100px"
                        alt=""
                      />
                      <div class="">
                        <p class="mb-2" style="font-size: 14px">
                          April 12, 2024
                        </p>
                        <div class="d-flex justify-content-between">
                          <h5>Sam Peters</h5>
                          <div class="d-flex mb-3">
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star text-warning"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                          </div>
                        </div>
                        <p class="text-dark">
                          The generated Lorem Ipsum is therefore always free
                          from repetition injected humour, or non-characteristic
                          words etc. Susp endisse ultricies nisi vel quam
                          suscipit
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="tab-pane" id="nav-vision" role="tabpanel">
                    <p class="text-dark">
                      Tempor erat elitr rebum at clita. Diam dolor diam ipsum et
                      tempor sit. Aliqu diam amet diam et eos labore. 3
                    </p>
                    <p class="mb-0">
                      Diam dolor diam ipsum et tempor sit. Aliqu diam amet diam
                      et eos labore. Clita erat ipsum et lorem et sit
                    </p>
                  </div>
                </div>
              </div>
              <form action="#">
                <h4 class="mb-5 fw-bold">Leave a Reply</h4>
                <div class="row g-4">
                  <div class="col-lg-6">
                    <div class="border-bottom rounded">
                      <input
                        type="text"
                        class="form-control border-0 me-4"
                        placeholder="Yur Name *"
                      />
                    </div>
                  </div>
                  <div class="col-lg-6">
                    <div class="border-bottom rounded">
                      <input
                        type="email"
                        class="form-control border-0"
                        placeholder="Your Email *"
                      />
                    </div>
                  </div>
                  <div class="col-lg-12">
                    <div class="border-bottom rounded my-4">
                      <textarea
                        name=""
                        id=""
                        class="form-control border-0"
                        cols="30"
                        rows="8"
                        placeholder="Your Review *"
                        spellcheck="false"
                      ></textarea>
                    </div>
                  </div>
                  <div class="col-lg-12">
                    <div class="d-flex justify-content-between py-3 mb-5">
                      <div class="d-flex align-items-center">
                        <p class="mb-0 me-3">Please rate:</p>
                        <div
                          class="d-flex align-items-center"
                          style="font-size: 12px"
                        >
                          <i class="fa fa-star text-muted"></i>
                          <i class="fa fa-star"></i>
                          <i class="fa fa-star"></i>
                          <i class="fa fa-star"></i>
                          <i class="fa fa-star"></i>
                        </div>
                      </div>
                      <a
                        href="#"
                        class="btn border border-secondary text-primary rounded-pill px-4 py-3"
                      >
                        Post Comment</a
                      >
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>

          <!-- Right side bar start -->
          <div class="col-lg-4 col-xl-3">
            <div class="row g-4 fruite">
              <div class="col-lg-12">
                <div class="mb-4">
                  <h4>Danh mục sản phẩm</h4>
                  <ul class="list-unstyled fruite-categorie">
                    <c:forEach var="category" items="${categories}">
                      <li>
                        <div class="d-flex justify-content-between fruite-name">
                          <a href="#"
                            ><i
                              class="${category.name == 'Bé trai' ? 'fas fa-mars' : category.name == 'Bé gái' ? 'fas fa-venus' : 'fas fa-baby'}"
                            ></i>
                            ${category.name}</a
                          >
                          <span>${fn:length(category.products)}</span>
                        </div>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
              <div class="col-lg-12">
                <h5 class="mb-4">Sản phẩm ưa chuộng</h5>
                <c:forEach var="product" items="${featuredProducts}">
                  <div class="d-flex align-items-start justify-content-start">
                    <div
                      class="rounded flex-shrink-0 me-2"
                      style="width: 100px; height: 100px"
                    >
                      <a href="/product/${product.id}"
                        ><img
                          src="/images/product/${product.image}"
                          class="img-fluid rounded object-fit-cover"
                          alt="Image"
                      /></a>
                    </div>
                    <div class="flex-shrink-1">
                      <a href="/product/${product.id}" class="mb-2 card-title"
                        >${product.name}</a
                      >
                      <div class="d-flex mb-2">
                        <i class="fa fa-star text-warning"></i>
                        <i class="fa fa-star text-warning"></i>
                        <i class="fa fa-star text-warning"></i>
                        <i class="fa fa-star text-warning"></i>
                        <i class="fa fa-star"></i>
                      </div>
                      <div class="d-flex mb-2">
                        <h5 class="fw-bold me-2" style="font-size: 16px">
                          <fmt:formatNumber
                            type="number"
                            value="${product.price}"
                          />
                          đ
                        </h5>
                        <!-- <h5 class="text-danger text-decoration-line-through">
                          4.11 $
                        </h5> -->
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>
              <div class="col-lg-12">
                <div class="position-relative">
                  <img
                    src="/images/others/baby-banner.webp"
                    class="img-fluid w-100 rounded object-fit-cover"
                    alt=""
                  />
                  <div
                    class="position-absolute"
                    style="top: 50%; right: 10px; transform: translateY(-50%)"
                  >
                    <h3 class="text-white fw-bold">
                      Bộ <br />
                      Sưu <br />
                      Tập <br />
                      Mới
                    </h3>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- Right side bar end -->
        </div>

        <!-- Related Products start -->
        <h1 class="fw-bold mb-0">Sản phẩm tương tự</h1>
        <div class="vesitable">
          <div class="owl-carousel vegetable-carousel justify-content-center">
            <c:forEach var="product" items="${relatedProducts}">
              <div
                class="border border-primary rounded position-relative vesitable-item"
              >
                <div class="vesitable-img">
                  <a href="/product/${product.id}"
                    ><img
                      src="/images/product/${product.image}"
                      class="img-fluid w-100 rounded-top object-fit-cover"
                      alt=""
                  /></a>
                </div>
                <div
                  class="text-white bg-primary px-3 py-1 rounded position-absolute"
                  style="top: 10px; right: 10px"
                >
                  ${product.brand.name}
                </div>
                <div class="p-4 pb-0 rounded-bottom">
                  <a
                    class="text-start fw-bold card-title"
                    href="/product/${product.id}"
                  >
                    ${product.name}
                  </a>
                  <div
                    class="d-flex justify-content-between flex-lg-wrap mt-auto"
                  >
                    <p class="text-dark fs-5 fw-bold">
                      <fmt:formatNumber
                        type="number"
                        value="${product.price}"
                      />
                      đ
                    </p>
                    <button
                      href="#"
                      class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary add-to-cart-btn"
                      data-product-id="${product.id}"
                    >
                      <i class="fa fa-shopping-bag me-2 text-primary"></i>Thêm
                      vào giỏ hàng
                    </button>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
        <!-- Related Products end -->
      </div>
    </div>
    <!-- Single Product End -->

    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a
      href="#"
      class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- alert modal cho biết thành công/thất bại khi add to cart -->
    <jsp:include page="../layout/alertModal.jsp" />

    <!-- size modal for related products -->
    <jsp:include page="../layout/sizeModal.jsp" />

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
      $(document).ready(function () {
        if ("${addedProduct}" && "${addedSize}") {
          $("#alert-modal").modal("show");
        }

        $(".quantity button")
          .off("click")
          .on("click", function (e) {
            e.preventDefault();
            const input = $("#quantity-input");
            const quantity = parseInt(input.val());
            const button = $(this);

            if (button.hasClass("btn-minus") && quantity > 1) {
              input.val(quantity - 1);
            } else if (button.hasClass("btn-plus")) {
              input.val(quantity + 1);
            }
          });

        $(".add-to-cart-btn").click(function () {
          if ("${userId}") {
            $("#rightSideModal").modal("show");
          } else {
            window.location.href = "/login";
          }
        });

        $(".add-to-cart-btn").click(function () {
          const productId = $(this).data("product-id");

          // Make an AJAX request to fetch the sizes for the selected product
          $.ajax({
            url: "/api/product", // URL to fetch sizes
            method: "GET",
            data: { id: productId },
            timeout: 600000,
            success: function (product) {
              console.log({ product });
              console.log(product.image);
              $("#size-modal-form").attr(
                "action",
                "/add-product-to-cart/" + product.id
              );
              $("#size-modal-img").attr(
                "src",
                "/images/product/" + product.image
              );
              $("#size-modal-name").text(product.name);
              $("#size-modal-brand").text(product.brand);
              const sizeSelect = $("#size-modal-size-radios");
              sizeSelect.empty();
              $.each(product.sizes, function (index, size) {
                const sizeTag =
                  "<label for=size-" +
                  size.id +
                  ' class="size-tag col-auto me-2 mb-2">' +
                  size.name +
                  '<input required id="size-' +
                  size.id +
                  '" type="radio" name="sizeId" value="' +
                  size.id +
                  '" class="d-none"/></label>';
                sizeSelect.append(sizeTag);
              });
              $("#size-modal-price").text(
                new Intl.NumberFormat("vi-VN", {
                  style: "currency",
                  currency: "VND",
                }).format(parseFloat(product.price))
              );
            },
            error: function () {
              alert("Something errors, please try again later!");
            },
          });
        });
      });
    </script>
  </body>
</html>
