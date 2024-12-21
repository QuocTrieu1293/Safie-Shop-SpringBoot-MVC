<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<div id="alert-modal" class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-flex justify-content-center fs-1 text-success">
        <i class="fa-solid fa-check"></i>
      </div>
      <div class="modal-body">
        <p style="font-size: 16px">
          <span style="font-size: 20px">${addedQuantity}</span>x
          <b>${addedProduct}</b>
        </p>
        <p>Size <b>${addedSize}</b> đã thêm vào giỏ hàng</p>
      </div>
    </div>
  </div>
</div>
