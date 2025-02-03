<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
  .modal-dialog-right {
    position: absolute;
    right: 0;
    margin: 0;
    height: 100%;
  }

  .modal-dialog-right .modal-content {
    height: 100%; /* Make the modal fill the viewport height */
    border-radius: 0; /* Remove border-radius for a seamless design */
  }
</style>

<div
  class="modal fade"
  id="size-modal"
  tabindex="-1"
  aria-labelledby="Right side size modal"
  aria-hidden="true"
>
  <div class="modal-dialog modal-dialog-right modal-fullscreen-sm-down">
    <!-- Right-aligned and responsive -->
    <div class="modal-content">
      <div class="modal-header">
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <form
        action="#"
        id="size-modal-form"
        class="flex-grow-1 d-flex flex-column"
        novalidate
      >
        <div class="modal-body container-fluid">
          <div class="row g-3 mb-2">
            <div class="col-4">
              <img
                id="size-modal-img"
                src="/images/avatar/user_placeholder.png"
                alt=""
                class="w-100"
                style="object-fit: cover"
              />
            </div>
            <div class="col-8">
              <p
                id="size-modal-name"
                class="fw-bold mb-1"
                style="font-size: 16px; color: #45595b"
              >
                Quần áo trẻ em Bobicraft - Áo thun bé trai cổ viền tròn xám -
                Cotton hữu cơ organic an toàn
              </p>
              <p style="font-size: 13px" class="fw-medium mb-0">
                Thương hiệu: <span id="size-modal-brand">Bobi craft</span>
              </p>
              <p style="font-size: 13px" class="fw-medium">
                Danh mục: <span id="size-modal-category">Bé trai</span>
              </p>
            </div>
          </div>

          <div>
            <div class="mb-1 col-12 mx-0 px-0">
              <span class="fw-medium" style="font-size: 16px; color: #45595b"
                >Sizes:</span
              >
              <span
                style="font-size: 13px; color: #d9534f"
                class="ms-1 error-message"
              >
                *Vui lòng chọn size sản phẩm
              </span>
            </div>
            <div class="row mx-0 px-0" id="size-modal-size-radios">
              <!-- <label for="sizeId-1" class="my-size-tag col-auto me-2 mb-2">
                12-18 tháng
                <input
                  id="sizeId-1"
                  type="radio"
                  name="sizeId"
                  value="sizeId"
                  required
                />
              </label> -->
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-between mt-auto">
          <p id="size-modal-price" class="text-dark fs-3 fw-bold">255.000 ₫</p>
          <button type="submit" class="btn btn-primary fs-5 py-2 px-3">
            Thêm vào giỏ hàng
          </button>
        </div>
        <input
          type="hidden"
          class="csrf"
          name="${_csrf.parameterName}"
          value="${_csrf.token}"
        />
      </form>
    </div>
  </div>
</div>
