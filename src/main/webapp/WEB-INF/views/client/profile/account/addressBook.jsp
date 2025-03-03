<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Sổ địa chỉ</title>
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
    <link rel="manifest" href="/static/site.webmanifest" />
    <link rel="icon" type="image/x-icon" href="/static/favicon.ico" />

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

    <!-- Address Book Page Start -->
    <!-- Add address modal -->
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
              Thêm mới địa chỉ
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <form:form
            action="${not empty formAction ? formAction : '/profile/account/address'}"
            method="post"
            id="address-modal-form"
            cssClass="modal-body bg-neutral-gray"
            modelAttribute="addressDto"
            novalidate="true"
          >
            <div>
              <h4 class="fw-medium text-black" style="font-size: 16px">
                Thông tin người nhận
              </h4>
              <div class="mb-3">
                <c:set var="nameBindError">
                  <form:errors
                    path="fullName"
                    cssClass="invalid-feedback server-validate-feedback"
                  />
                </c:set>
                <form:label path="fullName" cssClass="form-label mb-1"
                  >Họ và tên</form:label
                >
                <form:input
                  type="text"
                  id="fullName"
                  path="fullName"
                  cssClass="form-control ${not empty nameBindError ? 'is-invalid' : ''}"
                  spellcheck="false"
                  placeholder="Nhập họ và tên"
                  required="true"
                />
                <div class="invalid-feedback">Thông tin bắt buộc nhập</div>
                ${nameBindError}
              </div>
              <div class="mb-3">
                <c:set var="phoneBindError">
                  <form:errors
                    path="phone"
                    cssClass="invalid-feedback server-validate-feedback"
                  />
                </c:set>
                <form:label path="phone" cssClass="form-label mb-1"
                  >Số điện thoại</form:label
                >
                <form:input
                  type="text"
                  id="phone"
                  path="phone"
                  cssClass="form-control ${not empty phoneBindError ? 'is-invalid' : ''}"
                  spellcheck="false"
                  placeholder="Nhập số điện thoại"
                  pattern="\d{10}"
                  required="true"
                />
                <div class="invalid-feedback">
                  Thông tin bắt buộc. SĐT gồm 10 chữ số.
                </div>
                ${phoneBindError}
              </div>
            </div>

            <hr class="my-4" />

            <!-- Địa chỉ nhận hàng -->
            <div>
              <h4 class="fw-medium text-black" style="font-size: 16px">
                Địa chỉ nhận hàng
              </h4>

              <!-- city -->
              <div class="mb-3">
                <c:set var="cityBindError">
                  <form:errors
                    path="city"
                    cssClass="invalid-feedback server-validate-feedback"
                  />
                </c:set>
                <form:label path="city" cssClass="form-label mb-1"
                  >Tỉnh/Thành phố</form:label
                >
                <form:select
                  path="city"
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
              </div>

              <!-- district -->
              <div class="mb-3">
                <c:set var="districtBindError">
                  <form:errors
                    path="district"
                    cssClass="invalid-feedback server-validate-feedback"
                  />
                </c:set>
                <form:label path="district" cssClass="form-label mb-1"
                  >Quận/Huyện</form:label
                >
                <form:select
                  path="district"
                  id="district"
                  cssClass="form-select ${not empty districtBindError ? 'is-invalid' : ''}"
                  required="true"
                >
                  <form:option value="" label="Chọn Quận/Huyện" />
                </form:select>
                <div class="invalid-feedback">
                  Thông tin bắt buộc. Vui lòng điền đủ.
                </div>
                ${districtBindError}
              </div>

              <!-- ward -->
              <div class="mb-3">
                <c:set var="wardBindError">
                  <form:errors
                    path="ward"
                    cssClass="invalid-feedback server-validate-feedback"
                  />
                </c:set>
                <form:label path="ward" cssClass="form-label mb-1"
                  >Phường/Xã</form:label
                >
                <form:select
                  path="ward"
                  id="ward"
                  cssClass="form-select ${not empty wardBindError ? 'is-invalid' : ''}"
                  required="true"
                >
                  <form:option value="" label="Chọn Phường/Xã" />
                </form:select>
                <div class="invalid-feedback">
                  Thông tin bắt buộc. Vui lòng điền đủ.
                </div>
                ${wardBindError}
              </div>

              <!-- street -->
              <div class="mb-3">
                <c:set var="streetBindError">
                  <form:errors
                    path="street"
                    cssClass="invalid-feedback server-validate-feedback"
                  />
                </c:set>
                <form:label path="street" cssClass="form-label mb-1"
                  >Địa chỉ cụ thể</form:label
                >
                <form:input
                  type="text"
                  id="street"
                  path="street"
                  cssClass="form-control ${not empty streetBindError ? 'is-invalid' : ''}"
                  spellcheck="false"
                  placeholder="Nhập địa chỉ cụ thể"
                  required="true"
                />
                <div class="invalid-feedback">
                  Thông tin bắt buộc. Vui lòng điền đủ.
                </div>
                ${streetBindError}
              </div>

              <!-- type -->
              <div class="d-flex justify-content-between mb-3">
                <form:label path="type" cssClass="col-form-label"
                  >Loại địa chỉ</form:label
                >
                <div class="d-flex gap-3">
                  <div>
                    <form:radiobutton
                      cssClass="btn-check"
                      id="home"
                      path="type"
                      value="HOME"
                      checked="true"
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
                      path="type"
                      value="OFFICE"
                    />
                    <label
                      class="btn btn-outline-primary rounded-pill"
                      for="office"
                      ><i class="bi bi-building-fill"></i> Văn phòng</label
                    >
                  </div>
                </div>
              </div>
            </div>

            <hr class="my-4" />

            <!-- default -->
            <div class="d-flex justify-content-between align-items-center">
              <form:label path="defaultAddress" cssClass="col-form-label"
                >Đặt làm địa chỉ mặc định</form:label
              >
              <div class="form-switch form-check">
                <form:checkbox
                  id="defaultAddress"
                  path="defaultAddress"
                  cssClass="form-check-input"
                  role="switch"
                />
              </div>
            </div>

            <form:input type="hidden" path="cityId" />
            <form:input type="hidden" path="districtId" />
            <form:input type="hidden" path="wardId" />
          </form:form>
          <div class="modal-footer mt-auto">
            <button
              id="address-modal-submit"
              class="btn btn-primary rounded-pill flex-grow-1 p-2"
            >
              Xác nhận
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Remove address confirm modal -->
    <div
      class="modal fade"
      id="remove-confirm-modal"
      tabindex="-1"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header" style="border: none">
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body d-flex flex-column align-items-center">
            <img
              src="/images/others/cart-trash.png"
              alt=""
              style="width: 241px"
            />
            <span class="fw-bold text-red">Xác nhận xoá địa chỉ</span>
            <span style="color: black"
              >Bạn chắc chắn muốn xóa địa chỉ này ra khỏi sổ địa chỉ?</span
            >
          </div>
          <div class="modal-footer justify-content-center" style="border: none">
            <button
              type="button"
              class="btn btn-outline-dark col-5 rounded-3 p-3"
              data-bs-dismiss="modal"
            >
              Trở về
            </button>
            <form:form
              id="delete-confirm-form"
              action=""
              method="post"
              class="col-5"
            >
              <button class="btn btn-danger rounded-3 p-3 w-100">Xoá</button>
            </form:form>
          </div>
        </div>
      </div>
    </div>

    <div
      class="container container-fluid py-md-4"
      style="margin-top: 180px; min-height: 85vh"
    >
      <div class="row flex-nowrap">
        <div class="col-auto">
          <jsp:include page="../sideNav.jsp" />
        </div>
        <div class="col" style="min-width: 830px">
          <div class="p-4 pb-5">
            <div class="d-flex justify-content-between mb-4">
              <h2 class="fs-3 text-nowrap me-5">Sổ địa chỉ nhận hàng</h2>
              <button
                class="btn btn-primary rounded-pill text-nowrap"
                data-bs-toggle="modal"
                data-bs-target="#address-modal"
                id="add-address-btn"
              >
                Thêm địa chỉ mới
              </button>
            </div>
            <c:choose>
              <c:when test="${not empty addressList}">
                <div class="list-group shadow-sm rounded-2">
                  <c:forEach
                    var="address"
                    items="${addressList}"
                    varStatus="status"
                  >
                    <div
                      class="list-group-item list-group-item-action d-flex gap-4 p-3 border-start-0 border-end-0 border-top-0 align-items-center ${status.last ? 'border-bottom-0' : ''}"
                      style="cursor: default; min-width: fit-content"
                    >
                      <div class="col d-flex gap-2 align-items-center">
                        <div
                          class="rounded-circle position-relative flex-shrink-0 ${status.first ? 'bg-light-primary-2' : 'bg-secondary'}"
                          style="width: 48px; height: 48px"
                        >
                          <i
                            class="${address.type == 'HOME' ? 'bi bi-house-door-fill' : 'bi bi-building-fill'} fs-3 ${status.first ? 'text-primary' : 'text-black'} position-absolute top-50 start-50 translate-middle"
                          ></i>
                        </div>
                        <div class="flex-grow-1">
                          <div class="d-flex align-items-center flex-nowrap">
                            <span class="fw-medium text-nowrap"
                              >${address.fullName}</span
                            >
                            <span
                              class="border-start border-2 ps-2 ms-2"
                              style="font-size: 15px"
                              >${address.phone}</span
                            >
                            <c:if test="${status.first}">
                              <span
                                class="ms-3 rounded-pill px-2 py-1 text-primary border-light-primary border fw-medium text-nowrap"
                                style="
                                  font-size: 13px;
                                  background-color: #ede3da;
                                "
                              >
                                Mặc định
                              </span>
                            </c:if>
                          </div>
                          <div
                            class="col d-flex flex-column text-nowrap text-dark fw-medium"
                            style="font-size: 14px"
                          >
                            <span>${address.street}</span>
                            <span
                              >${address.ward}, ${address.district},
                              ${address.city}</span
                            >
                          </div>
                        </div>
                      </div>
                      <div
                        class="col-auto text-nowrap d-flex flex-nowrap ms-auto"
                      >
                        <span
                          role="button"
                          class="col fw-medium text-primary fs-6 update-address-btn"
                          data-address-id="${address.id}"
                          >Sửa</span
                        >
                        <span
                          role="button"
                          class="col fw-medium fs-6 border-start border-2 ms-2 ps-2 delete-address-btn"
                          data-address-id="${address.id}"
                          data-bs-toggle="modal"
                          data-bs-target="#remove-confirm-modal"
                        >
                          Xoá
                        </span>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </c:when>
              <c:otherwise>
                <div
                  class="d-flex flex-column justify-content-center align-items-center text-center"
                >
                  <img src="/images/others/empty_address_book.png" alt="" />
                  <span class="fs-5 fw-medium text-nowrap"
                    >Bạn chưa lưu địa chỉ nào</span
                  >
                  <span class="fw-medium">
                    Cập nhật địa chỉ ngay để có trải nghiệm mua hàng nhanh nhất.
                  </span>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
    <!-- Address Book Page End -->

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

      const resetForm = function () {
        $(
          "#fullName, #phone, #city, #district, #ward, #street,#cityId, #districtId, #wardId"
        ).val("");
        $("#type").val("HOME");
        $("#defaultAddress").prop("checked", false);
        $("#address-modal-form *").removeClass("is-invalid");
        $("#address-modal-form .server-validate-feedback").remove();
        $("#district, #ward").prop("disabled", true);
      };

      $(document).ready(function () {
        // Add Address Modal //
        // getAddress("city").then((data) => console.log("api call done", data));

        // Validate fail from server
        if ($("#address-modal-form .server-validate-feedback").length > 0) {
          $("#address-modal-form .server-validate-feedback")
            .siblings(".invalid-feedback:not(.server-validate-feedback)")
            .addClass("d-none");
          // reselect address like city, district, ward
          getAddress("city")
            .then(() => {
              if ($("#city").hasClass("is-invalid")) {
                $("#city, #district, #ward, #cityId, #districtId, #wardId").val(
                  ""
                );
                $("#district, #ward").prop("disabled", true);
                return Promise.reject("invalid at city");
              }
              const city_id = $("#cityId").val();
              $("#city")
                .find("option[data-id=" + city_id + "]")
                .prop("selected", true);
              return getAddress("district", city_id);
            })
            .then(() => {
              if ($("#district").hasClass("is-invalid")) {
                $("#district, #districtId, #ward, #wardId").val("");
                $("#ward").prop("disabled", true);
                return Promise.reject("invalid at district");
              }
              const district_id = $("#districtId").val();
              $("#district")
                .find("option[data-id=" + district_id + "]")
                .prop("selected", true);
              return getAddress("ward", district_id);
            })
            .then(() => {
              if ($("#ward").hasClass("is-invalid")) {
                $("#ward, #wardId").val("");
                return Promise.reject("invalid at ward");
              }
              const ward_id = $("#wardId").val();
              $("#ward")
                .find("option[data-id=" + ward_id + "]")
                .prop("selected", true);
            })
            .catch((e) => console.log(">>> ADDRESS BOOK VALIDATE ERR:", e))
            .finally(() => {
              $("#address-modal").removeClass("fade");
              $("#address-modal").modal("show");
              $("#address-modal").addClass("fade");
            });
        } else {
          resetForm();
        }

        // Handle event
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

        $("#add-address-btn").click(function () {
          getAddress("city");
          const form = $("#address-modal-form");
          form.attr("method", "post");
          form.attr("action", "/profile/account/address");
        });
        $(".update-address-btn").click(function () {
          const addressId = $(this).data("address-id");
          const form = $("#address-modal-form");

          $.get("/api/address/" + addressId, function (data) {
            $("#address-modal").modal("show");

            form
              .find("input[type='text'], input[type='hidden']")
              .each(function () {
                const id = $(this).attr("id");
                if (id in data) $(this).val(data[id]);
              });
            form
              .find("input[name='type'][value='" + data.type + "']")
              .prop("checked", true);
            $("#defaultAddress").prop("checked", data.defaultAddress);

            getAddress("city").then(() =>
              $("#city")
                .find("option[data-id=" + data.cityId + "]")
                .prop("selected", true)
            );
            getAddress("district", data.cityId).then(() =>
              $("#district")
                .find("option[data-id=" + data.districtId + "]")
                .prop("selected", true)
            );
            getAddress("ward", data.districtId).then(() =>
              $("#ward")
                .find("option[data-id=" + data.wardId + "]")
                .prop("selected", true)
            );
          }).fail((response) => {
            if (response.status === 401) {
              window.location.href = "/login?invalid=true";
            }
          });

          form.attr("action", "/profile/account/address/update/" + addressId);
        });
        $(".delete-address-btn").click(function () {
          const addressId = $(this).data("address-id");
          $("#delete-confirm-form").attr(
            "action",
            "/profile/account/address/delete/" + addressId
          );
        });

        $("#address-modal").on("hide.bs.modal", function () {
          resetForm();
        });

        $("#address-modal-submit").click(function () {
          $("#address-modal-form").submit();
        });
        $("#address-modal-form").submit(function (e) {
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
        $("#address-modal-form")
          .find("input, select")
          .on("input change", function () {
            $(this).siblings(".server-validate-feedback").remove();
            $(this)
              .siblings(".invalid-feedback:not(.server-validate-feedback)")
              .removeClass("d-none");

            if (!this.checkValidity()) $(this).addClass("is-invalid");
            else $(this).removeClass("is-invalid");
          });
      });
    </script>
  </body>
</html>
