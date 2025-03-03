<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Đặt hàng</title>
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

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet" />
    <link href="/css/mycss.css" rel="stylesheet" />

    <style>
      #address-modal .list-group > .list-group-item-action.active {
        box-shadow: none;
        background-color: var(--bs-light-primary-2);
        border: solid 1px var(--bs-primary);
      }
    </style>
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

    <!-- Checkout Page Start -->
    <div class="container-fluid" style="margin-top: 180px">
      <div class="container py-md-4">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-5">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item">
              <a href="/cart">Giỏ hàng</a>
            </li>
            <li class="breadcrumb-item active fw-medium">Đặt hàng</li>
          </ol>
        </nav>
        <h1 class="mb-4">Thông tin đơn hàng</h1>
        <form:form
          action="/checkout"
          method="post"
          id="checkout-form"
          modelAttribute="checkoutDTO"
          novalidate="true"
        >
          <div class="row g-5">
            <!-- Thông tin đặt hàng -->
            <div class="col-md-12 col-lg-5">
              <!-- Thông tin người đặt -->
              <div class="rounded-1 shadow bg-secondary py-3 px-2 mb-5">
                <h3 class="fs-4 p-2">Người đặt hàng</h3>
                <table
                  class="table table-borderless fw-medium text-dark"
                  style="border-spacing: 15px 0px; border-collapse: separate"
                >
                  <tr>
                    <td class="p-0 text-end">
                      <label class="col-form-label" for="user-fullName">
                        Họ tên:
                      </label>
                    </td>
                    <td class="p-0">
                      <input
                        type="text"
                        class="form-control-plaintext"
                        id="user-fullName"
                        value="${cart.user.fullName}"
                        disabled
                      />
                    </td>
                  </tr>
                  <tr>
                    <td class="p-0 text-end">
                      <label for="email" class="col-form-label">Email:</label>
                    </td>
                    <td class="p-0">
                      <input
                        id="email"
                        type="email"
                        class="form-control-plaintext"
                        value="${cart.user.email}"
                        disabled
                      />
                    </td>
                  </tr>
                </table>
              </div>

              <!-- Receive Info -->
              <div class="rounded-1 shadow bg-secondary py-3 px-2 mb-5">
                <div class="d-flex justify-content-end">
                  <c:if test="${not empty receiveInfos}">
                    <span
                      role="button"
                      style="font-size: 15px"
                      class="fw-bold text-decoration-underline text-primary"
                      data-bs-toggle="modal"
                      data-bs-target="#address-modal"
                    >
                      Chọn từ sổ địa chỉ
                      <i class="bi bi-journal-text ms-1 fs-5"></i>
                    </span>
                  </c:if>
                </div>
                <h3 class="fs-4 p-2">Thông tin nhận hàng</h3>
                <table
                  id="receive-info"
                  class="table table-borderless fw-medium text-dark"
                  style="border-spacing: 15px 15px; border-collapse: separate"
                >
                  <!-- Receiver Name -->
                  <tr>
                    <td class="p-0 text-end">
                      <form:label
                        cssClass="col-form-label"
                        path="receiveInfo.fullName"
                        for="fullName"
                      >
                        Họ tên<sup>*</sup>
                      </form:label>
                    </td>
                    <td class="p-0">
                      <c:set var="receiverNameBindError">
                        <form:errors
                          path="receiveInfo.fullName"
                          cssClass="invalid-feedback server-validate-feedback"
                        />
                      </c:set>
                      <form:input
                        type="text"
                        cssClass="form-control ${not empty receiverNameBindError ? 'is-invalid' : ''}"
                        path="receiveInfo.fullName"
                        required="true"
                        spellcheck="false"
                        id="fullName"
                      />
                      <div class="invalid-feedback">
                        Thông tin bắt buộc nhập
                      </div>
                      ${receiverNameBindError}
                    </td>
                  </tr>

                  <!-- Receiver Phone -->
                  <tr>
                    <td class="p-0 text-end">
                      <form:label
                        cssClass="col-form-label"
                        path="receiveInfo.phone"
                        for="phone"
                      >
                        Số điện thoại<sup>*</sup>
                      </form:label>
                    </td>
                    <td class="p-0">
                      <c:set var="receiverPhoneBindError">
                        <form:errors
                          path="receiveInfo.phone"
                          cssClass="invalid-feedback server-validate-feedback"
                        />
                      </c:set>
                      <form:input
                        type="tel"
                        cssClass="form-control ${not empty receiverPhoneBindError ? 'is-invalid' : ''}"
                        path="receiveInfo.phone"
                        required="true"
                        spellcheck="false"
                        pattern="\d{10}"
                        id="phone"
                      />
                      <div class="invalid-feedback">SĐT gồm 10 chữ số.</div>
                      ${receiverPhoneBindError}
                    </td>
                  </tr>

                  <!-- city -->
                  <tr>
                    <td class="p-0 text-end">
                      <form:label
                        path="receiveInfo.city"
                        for="city"
                        cssClass="col-form-label"
                      >
                        Tỉnh/Thành phố
                      </form:label>
                    </td>
                    <td class="p-0">
                      <c:set var="cityBindError">
                        <form:errors
                          path="receiveInfo.city"
                          cssClass="invalid-feedback server-validate-feedback"
                        />
                      </c:set>
                      <form:select
                        path="receiveInfo.city"
                        id="city"
                        cssClass="form-select ${not empty cityBindError ? 'is-invalid' : ''}"
                        required="true"
                      >
                        <form:option value="" label="Chọn Tỉnh/Thành phố" />
                      </form:select>
                      <div class="invalid-feedback">
                        Thông tin bắt buộc. Vui lòng điền đủ.
                      </div>
                      ${cityBindError}
                    </td>
                  </tr>

                  <!-- district -->
                  <tr>
                    <td class="p-0 text-end">
                      <form:label
                        for="district"
                        path="receiveInfo.district"
                        cssClass="col-form-label"
                        >Quận/Huyện</form:label
                      >
                    </td>
                    <td class="p-0">
                      <c:set var="districtBindError">
                        <form:errors
                          path="receiveInfo.district"
                          cssClass="invalid-feedback server-validate-feedback"
                        />
                      </c:set>
                      <form:select
                        id="district"
                        path="receiveInfo.district"
                        cssClass="form-select ${not empty districtBindError ? 'is-invalid' : ''}"
                        required="true"
                      >
                        <form:option value="" label="Chọn Quận/Huyện" />
                      </form:select>
                      <div class="invalid-feedback">
                        Thông tin bắt buộc. Vui lòng điền đủ.
                      </div>
                      ${districtBindError}
                    </td>
                  </tr>

                  <!-- ward -->
                  <tr>
                    <td class="p-0 text-end">
                      <form:label
                        for="ward"
                        path="receiveInfo.ward"
                        cssClass="col-form-label"
                        >Phường/Xã</form:label
                      >
                    </td>
                    <td class="p-0">
                      <c:set var="wardBindError">
                        <form:errors
                          path="receiveInfo.ward"
                          cssClass="invalid-feedback server-validate-feedback"
                        />
                      </c:set>
                      <form:select
                        id="ward"
                        path="receiveInfo.ward"
                        cssClass="form-select ${not empty wardBindError ? 'is-invalid' : ''}"
                        required="true"
                      >
                        <form:option value="" label="Chọn Phường/Xã" />
                      </form:select>
                      <div class="invalid-feedback">
                        Thông tin bắt buộc. Vui lòng điền đủ.
                      </div>
                      ${wardBindError}
                    </td>
                  </tr>

                  <tr>
                    <!-- street -->
                    <td class="p-0 text-end">
                      <form:label
                        path="receiveInfo.street"
                        cssClass="col-form-label"
                        for="street"
                        >Địa chỉ cụ thể</form:label
                      >
                    </td>
                    <td class="p-0">
                      <c:set var="streetBindError">
                        <form:errors
                          path="receiveInfo.street"
                          cssClass="invalid-feedback server-validate-feedback"
                        />
                      </c:set>
                      <form:input
                        type="text"
                        path="receiveInfo.street"
                        cssClass="form-control ${not empty streetBindError ? 'is-invalid' : ''}"
                        spellcheck="false"
                        placeholder="Nhập địa chỉ cụ thể"
                        required="true"
                        id="street"
                      />
                      <div class="invalid-feedback">
                        Thông tin bắt buộc. Vui lòng điền đủ.
                      </div>
                      ${streetBindError}
                    </td>
                  </tr>
                  <tr>
                    <!-- type -->
                    <td class="p-0 text-end" style="vertical-align: middle">
                      <form:label
                        path="receiveInfo.type"
                        cssClass="col-form-label"
                        >Loại địa chỉ</form:label
                      >
                    </td>
                    <td class="d-flex justify-content-end gap-2">
                      <div>
                        <form:radiobutton
                          cssClass="btn-check"
                          id="home"
                          path="receiveInfo.type"
                          value="HOME"
                        />
                        <label
                          class="btn btn-outline-primary rounded-pill"
                          for="home"
                          ><i class="bi bi-house-door-fill"></i> Nhà</label
                        >
                      </div>

                      <div>
                        <form:radiobutton
                          cssClass="btn-check"
                          id="office"
                          path="receiveInfo.type"
                          value="OFFICE"
                        />
                        <label
                          class="btn btn-outline-primary rounded-pill"
                          for="office"
                          ><i class="bi bi-building-fill"></i> Văn phòng</label
                        >
                      </div>
                    </td>
                    <form:input
                      type="hidden"
                      id="cityId"
                      path="receiveInfo.cityId"
                    />
                    <form:input
                      type="hidden"
                      id="districtId"
                      path="receiveInfo.districtId"
                    />
                    <form:input
                      type="hidden"
                      id="wardId"
                      path="receiveInfo.wardId"
                    />
                  </tr>
                </table>
              </div>

              <div class="p-3 mb-4 shadow rounded-1 bg-secondary">
                <h3 class="fs-5">Lời nhắn cho cửa hàng (nếu có)</h3>
                <form:textarea
                  path="orderNotes"
                  cssClass="form-control"
                  spellcheck="false"
                  cols="30"
                  rows="11"
                  placeholder="Ví dụ: Hãy gọi tôi trước khi giao hàng 10 phút"
                ></form:textarea>
              </div>
            </div>

            <!-- các Sản phẩm -->
            <div
              class="col-md-12 col-lg-7 rounded-1 p-5 border-secondary border-1 shadow bg-neutral-gray"
            >
              <div class="table-responsive">
                <table class="table">
                  <thead>
                    <tr>
                      <th scope="col" style="width: 120px; min-width: 120px">
                        Sản phẩm
                      </th>
                      <th scope="col" style="width: 30%; min-width: 150px">
                        Tên
                      </th>
                      <th scope="col" class="text-nowrap">Đơn giá</th>
                      <th scope="col" class="text-nowrap">Số lượng</th>
                      <th scope="col" class="text-nowrap">Thành tiền</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="item" items="${cart.cartDetails}">
                      <tr>
                        <th scope="row">
                          <div class="d-flex align-items-center mt-3">
                            <img
                              src="/images/product/${item.product.image}"
                              class="w-100 rounded-circle"
                              style="
                                width: 100px;
                                height: 100px;
                                object-fit: cover;
                              "
                              alt=""
                            />
                          </div>
                        </th>
                        <td class="mt-3" style="text-align: justify">
                          ${item.product.name}
                        </td>
                        <td class="mt-3 text-nowrap">
                          <fmt:formatNumber
                            type="number"
                            value="${item.product.price}"
                          />
                          đ
                        </td>
                        <td class="mt-3 text-nowrap text-center">
                          ${item.quantity}
                        </td>
                        <td class="mt-3 text-nowrap">
                          <fmt:formatNumber
                            type="number"
                            value="${item.price}"
                          />
                          đ
                        </td>
                      </tr>
                    </c:forEach>

                    <tr>
                      <th scope="row"></th>
                      <td class="py-5"></td>
                      <td class="py-5"></td>
                      <td class="py-5">
                        <p class="mb-0 text-dark py-3 fw-bold">Tạm tính</p>
                      </td>
                      <td class="py-5">
                        <div class="py-3 border-bottom border-top">
                          <p class="mb-0 text-dark fw-semibold">
                            <fmt:formatNumber
                              type="number"
                              value="${totalPrice}"
                            />
                            đ
                          </p>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th></th>
                      <td class="py-5">
                        <p class="mb-0 text-dark py-4 fw-bold">
                          Loại giao hàng
                        </p>
                      </td>
                      <td colspan="3" class="py-5 align-content-center">
                        <div
                          class="form-check d-flex justify-content-end align-items-center"
                        >
                          <input
                            type="checkbox"
                            class="form-check-input bg-primary border-0 m-2"
                            id="Shipping-1"
                            name="Shipping-1"
                            value="Shipping"
                            checked
                            disabled
                          />
                          <label class="form-check-label" for="Shipping-1"
                            >Giao hàng miễn phí</label
                          >
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th></th>
                      <td class="py-5">
                        <p class="mb-0 text-dark text-uppercase py-3 fw-bold">
                          Tổng số tiền
                        </p>
                      </td>
                      <td class="py-5"></td>
                      <td class="py-5"></td>
                      <td class="py-5">
                        <div class="py-3 border-bottom border-top">
                          <p class="mb-0 text-dark fw-medium">
                            <fmt:formatNumber
                              type="number"
                              value="${totalPrice}"
                            />
                            đ
                          </p>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div
                class="row g-4 text-center align-items-center justify-content-center border-bottom py-3"
              >
                <div class="col-12">
                  <div class="form-check text-start my-3 col-auto">
                    <form:radiobutton
                      cssClass="form-check-input bg-primary border-0"
                      id="cod"
                      path="paymentMethod"
                      value="COD"
                      checked="true"
                    />
                    <label class="form-check-label fw-bold fs-6" for="cod"
                      >Thanh toán trực tiếp khi nhận hàng (COD)</label
                    >
                  </div>
                </div>
              </div>
              <div
                class="row g-4 text-center align-items-center justify-content-center border-bottom py-3"
              >
                <div class="col-12">
                  <div class="row">
                    <div class="col-auto d-flex align-items-center">
                      <div class="form-check text-start my-3">
                        <form:radiobutton
                          cssClass="form-check-input bg-primary border-0"
                          id="vnpay"
                          path="paymentMethod"
                          value="VNPAY"
                        />
                        <label class="form-check-label fw-bold fs-6" for="vnpay"
                          >Ví điện tử VNPAY</label
                        >
                      </div>
                    </div>
                    <div class="col-auto">
                      <img
                        src="/images/others/vnpay-logo.jpg"
                        alt=""
                        style="width: 100px; object-fit: cover"
                      />
                    </div>
                  </div>
                </div>
              </div>

              <div
                class="row g-4 text-center align-items-center justify-content-center pt-4"
              >
                <button
                  class="btn py-3 px-4 text-uppercase w-100 text-white fw-bold"
                  style="background-color: #0d6efd"
                >
                  Đặt hàng
                </button>
              </div>
            </div>
          </div>
        </form:form>
      </div>
    </div>
    <!-- Checkout Page End -->

    <!-- Start address modal -->
    <c:if test="${not empty receiveInfos}">
      <div
        class="modal fade"
        id="address-modal"
        tabindex="-1"
        aria-labelledby="address-modal-title"
        aria-hidden="true"
      >
        <div
          class="modal-dialog modal-dialog-right modal-fullscreen-sm-down modal-dialog-scrollable"
        >
          <!-- Right-aligned and responsive -->
          <div class="modal-content" style="min-width: 432px">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="address-modal-title">
                Chọn thông tin nhận hàng
              </h1>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>
            <div class="modal-body bg-neutral-gray">
              <div class="list-group">
                <c:forEach
                  var="item"
                  items="${receiveInfos}"
                  varStatus="status"
                >
                  <button
                    class="${not status.first ? 'mt-1' : ''} p-3 rounded-1 shadow-sm list-group-item list-group-item-action"
                    data-address-id="${item.id}"
                  >
                    <div style="color: black" class="fw-medium">
                      <span>${item.fullName}</span>
                      <span class="ps-2 ms-2 border-start border-2"
                        >${item.phone}</span
                      >
                    </div>
                    <div
                      class="fw-medium text-dark mb-1"
                      style="font-size: 14px"
                    >
                      <div>${item.street}</div>
                      <div>${item.ward}, ${item.district}, ${item.city}</div>
                    </div>
                    <div class="d-flex gap-2">
                      <span
                        class="px-2 py-1 fw-medium rounded bg-secondary text-dark"
                        style="font-size: 12px"
                        >${item.type == 'HOME' ? 'Nhà' : 'Văn phòng'}</span
                      >
                      <c:if test="${status.first}">
                        <span
                          class="rounded px-2 py-1 text-primary border-light-primary border fw-medium text-nowrap"
                          style="font-size: 12px; background-color: #ede3da"
                        >
                          Mặc định
                        </span>
                      </c:if>
                    </div>
                  </button>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>
      </div>
    </c:if>

    <!-- End address modal -->

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
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <script>
      const getAddress = async function (type, id) {
        let param1, param2;
        // switch case sử dụng strict comparison (===)
        switch (type) {
          case "city": {
            param1 = 1;
            param2 = 0;
            break;
          }
          case "district": {
            param1 = 2;
            param2 = id;
            break;
          }
          case "ward": {
            param1 = 3;
            param2 = id;
            break;
          }
          default:
            return;
        }

        $("#" + type).prop("disabled", true);
        // console.log("api calling ...");
        const res = await $.getJSON(
          "https://esgoo.net/api-tinhthanh/" + param1 + "/" + param2 + ".htm"
        );
        // console.log(res);
        if (res.error === 0) {
          const data = res.data;
          $.each(data, function (_, item) {
            $("#" + type).append(
              "<option data-id='" +
                item.id +
                "' value='" +
                item.full_name +
                "'>" +
                item.full_name +
                "</option>"
            );
          });
          $("#" + type).prop("disabled", false);
        } else {
          alert("Fail to fetch address API. Try reloading this page!");
          Array.from({ length: 3 }, (_, i) =>
            $("#" + type).append(
              "<option data-id='-1' value='test sample " +
                i +
                "'>test sample " +
                i +
                "</option>"
            )
          );
          $("#" + type).prop("disabled", false);
          throw new Error("Fail to load " + type + " API");
        }
      };

      $(document).ready(function () {
        // $("#address-modal").modal("show");

        getAddress("city")
          .then(() => {
            const city_id = $("#cityId").val();

            if ($("#city").hasClass("is-invalid") || !city_id) {
              $("#city, #district, #ward, #cityId, #districtId, #wardId").val(
                ""
              );
              $("#district, #ward").prop("disabled", true);
              return Promise.reject("invalid at city");
            }

            $("#city")
              .find("option[data-id=" + city_id + "]")
              .prop("selected", true);
            return getAddress("district", city_id);
          })
          .then(() => {
            const district_id = $("#districtId").val();

            if ($("#district").hasClass("is-invalid") || !district_id) {
              $("#district, #districtId, #ward, #wardId").val("");
              $("#ward").prop("disabled", true);
              return Promise.reject("invalid at district");
            }

            $("#district")
              .find("option[data-id=" + district_id + "]")
              .prop("selected", true);
            return getAddress("ward", district_id);
          })
          .then(() => {
            const ward_id = $("#wardId").val();

            if ($("#ward").hasClass("is-invalid") || !ward_id) {
              $("#ward, #wardId").val("");
              return Promise.reject("invalid at ward");
            }

            $("#ward")
              .find("option[data-id=" + ward_id + "]")
              .prop("selected", true);
          })
          .catch((e) => console.log(">>> ADDRESS BOOK VALIDATE ERR:", e));

        if ($("#checkout-form .server-validate-feedback").length > 0) {
          $("#checkout-form .server-validate-feedback")
            .siblings(".invalid-feedback:not(.server-validate-feedback)")
            .addClass("d-none");
        }

        // handle events
        $("#city").change(function () {
          // console.log($(this).find("option:selected"));
          $("#district").children(":not(:first-child)").remove();
          $("#ward").children(":not(:first-child)").remove();
          $("#ward").prop("disabled", true);
          $("#district").prop("disabled", true);

          if ($(this).val()) {
            const city_id = $(this).find("option:selected").data("id");
            $("#cityId").val(city_id);
            getAddress("district", city_id);
          } else {
            $("#cityId").val("");
          }
          $(this).blur();
        });
        $("#district").change(function () {
          $("#ward").children(":not(:first-child)").remove();
          $("#ward").prop("disabled", true);
          if ($(this).val()) {
            const district_id = $(this).find("option:selected").data("id");
            $("#districtId").val(district_id);
            getAddress("ward", district_id);
          } else {
            $("#districtId").val("");
          }
          $(this).blur();
        });
        $("#ward").change(function () {
          const ward_id = $(this).find("option:selected").data("id");
          $("#wardId").val(ward_id);

          $(this).blur();
        });

        $("#checkout-form").submit(function (e) {
          if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();

            $(this)
              .find("input, select")
              .each(function () {
                if (!this.checkValidity()) $(this).addClass("is-invalid");
              });
          }
        });
        $("#checkout-form")
          .find("input, select")
          .on("input change", function () {
            $(this).siblings(".server-validate-feedback").remove();
            $(this)
              .siblings(".invalid-feedback:not(.server-validate-feedback)")
              .removeClass("d-none");

            if (!this.checkValidity()) $(this).addClass("is-invalid");
            else $(this).removeClass("is-invalid");
          });

        $("#address-modal .list-group-item-action").click(function () {
          // khi click ra ngoài thì modal không tắt
          $("#address-modal").data("bs-backdrop", "static");
          $("#address-modal").data("bs-keyboard", "false");

          const addressId = $(this).data("address-id");
          $.get("/api/address/" + addressId, function (data) {
            console.log(data);

            const form = $("#checkout-form");
            form
              .find("input[type='text'], input[type='hidden']")
              .each(function () {
                const id = $(this).attr("id");
                if (id in data) $(this).val(data[id]);
              });
            form
              .find("input[name='receiveInfo.type'][value='" + data.type + "']")
              .prop("checked", true);

            Promise.all([
              getAddress("city"),
              getAddress("district", data.cityId),
              getAddress("ward", data.districtId),
            ])
              .then(() => {
                $("#city")
                  .find("option[data-id=" + data.cityId + "]")
                  .prop("selected", true);
                $("#district")
                  .find("option[data-id=" + data.districtId + "]")
                  .prop("selected", true);
                $("#ward")
                  .find("option[data-id=" + data.wardId + "]")
                  .prop("selected", true);
              })
              .catch((e) => console.log(">>> ERR call address api:", e))
              .finally(() => {
                $("#address-modal").modal("hide");
                $("#address-modal").removeData("bs-backdrop");
                $("#address-modal").removeData("bs-keyboard");
              });
          }).fail(function (response) {
            if (response.status === 401) {
              window.location.href = "/login?invalid=true";
            }
          });
        });
      });
    </script>
  </body>
</html>
