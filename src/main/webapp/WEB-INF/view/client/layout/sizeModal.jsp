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

<div
  class="modal fade"
  id="rightSideModal"
  tabindex="-1"
  aria-labelledby="rightSideModalLabel"
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
        method="post"
        id="size-modal-form"
        class="flex-grow-1 d-flex flex-column"
      >
        <div class="modal-body container-fluid">
          <div class="row g-3 mb-2">
            <div class="col-4">
              <img
                id="size-modal-img"
                src="/images/avatar/user_placeholder.png"
                alt=""
                class="img-fluid object-fit-cover"
              />
            </div>
            <div class="col-8">
              <p
                id="size-modal-name"
                class="fw-bolder mb-1"
                style="font-size: 16px; color: #45595b"
              >
                Quần áo trẻ em Bobicraft - Áo thun bé trai cổ viền tròn xám -
                Cotton hữu cơ organic an toàn
              </p>
              <p style="font-size: 13px" class="fw-bold">
                Thương hiệu: <span id="size-modal-brand">Bobi craft</span>
              </p>
            </div>
          </div>

          <div>
            <p
              class="fw-bolder mb-1 col-12 mx-0 px-0"
              style="font-size: 16px; color: #45595b"
            >
              Size:
            </p>
            <div class="row mx-0 px-0" id="size-modal-size-radios">
              <!-- <label for="sizeId-1" class="size-tag col-auto me-2 mb-2">
                12-18 tháng
                <input
                  id="sizeId-1"
                  type="radio"
                  name="sizeId"
                  value="sizeId"
                  class="d-none"
                />
              </label> -->
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-between mt-auto">
          <p id="size-modal-price" class="text-dark fs-3 fw-bolder">
            255.000 ₫
          </p>
          <button type="submit" class="btn btn-primary fs-5 py-2 px-3">
            Thêm vào giỏ hàng
          </button>
        </div>
        <input
          type="hidden"
          name="${_csrf.parameterName}"
          value="${_csrf.token}"
        />
      </form>
    </div>
  </div>
</div>
