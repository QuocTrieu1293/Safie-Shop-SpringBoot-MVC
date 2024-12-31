
$(document).ready(function () {
  $("#size-modal .error-message").css("visibility", "hidden");
  $("#size-modal-form").submit(function (e) {
    e.preventDefault();

    // check user đã login hay chưa. userId lấy từ session trong file header.jsp
    if (!userId) {
      $.toast({
        text: "<span style='font-size: 14px'>Bạn cần đăng nhập tài khoản. <a href='/login'>Đăng nhập</a></span>", // Text that is to be shown in the toast
        heading: 'Lỗi', // Optional heading to be shown on the toast
        icon: 'error', // Type of toast icon
        showHideTransition: 'fade', // fade, slide or plain
        allowToastClose: true, // Boolean value true or false
        hideAfter: 2500, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
        stack: false, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
        position: 'bottom-left', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values
        textAlign: 'left',  // Text alignment i.e. left, right or center
        loader: true,  // Whether to show loader or not. True by default
        loaderBg: '#c5d6c3',  // Background color of the toast loader
      });
      return;
    }

    if (!this.checkValidity()) {
      $(this).find(".error-message").css("visibility", "visible");
      return;
    }

    const csrf = $(this).find(".csrf");
    const csrf_name = csrf.attr("name");
    const csrf_value = csrf.attr("value");
    const sizeId = $(this).find("input[name='sizeId'][type='radio']:checked").val();
    $.post(`/api/product/add-to-cart/${$(this).data("product")}`, { [csrf_name]: csrf_value, sizeId, quantity: 1 },
      function ({ productName, size, quantity, cartSum }) {
        // console.log({ productName, size, quantity, cartSum });
        $.toast({
          text: `<span style='font-size: 14px'><b>${quantity}</b> sản phẩm đã được thêm vào giỏ hàng</span>`, // Text that is to be shown in the toast
          heading: 'Giỏ hàng', // Optional heading to be shown on the toast
          icon: 'success', // Type of toast icon
          showHideTransition: 'fade', // fade, slide or plain
          allowToastClose: true, // Boolean value true or false
          hideAfter: 2500, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
          stack: false, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
          position: 'bottom-left', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values
          textAlign: 'left',  // Text alignment i.e. left, right or center
          loader: true,  // Whether to show loader or not. True by default
          loaderBg: '#c5d6c3',  // Background color of the toast loader
        });

        const cart = $("#cart-sum");
        if (cartSum > 0 && cart.hasClass("d-none")) {
          cart.addClass("d-flex");
          cart.removeClass("d-none");
        } else if (cartSum == 0) {
          cart.addClass("d-none");
          cart.removeClass("d-flex");
        }

        $("#cart-sum").text(cartSum);
      })

  });

  $("#size-modal").on("hide.bs.modal", function () {
    const errorMessage = $(this).find(".error-message");
    if (errorMessage.css("visibility") === "visible")
      errorMessage.css("visibility", "hidden");
  })

  // if (addedProduct && addedSize) {
  //   $("#alert-modal").modal("show");
  // }

  $("[size-modal-trigger]").click(function () {

    const productId = $(this).data("product-id");

    // Make an AJAX request to fetch the sizes for the selected product
    $.ajax({
      url: "/api/product/" + productId, // URL to fetch sizes
      method: "GET",
      timeout: 600000,
      success: function (product) {
        // console.log({ product });
        $("#size-modal-form").data("product", productId);
        $("#size-modal-img").attr(
          "src",
          "/images/product/" + product.image
        );
        $("#size-modal-name").text(product.name);
        $("#size-modal-brand").text(product.brand);
        $("#size-modal-category").text(product.category);
        const sizeSelect = $("#size-modal-size-radios");
        sizeSelect.empty();
        $.each(product.sizes, function (_, size) {
          const sizeTag =
            "<label for=size-" +
            size.id +
            ' class="my-size-tag col-auto me-2 mb-2">' +
            size.name +
            '<input required id="size-' +
            size.id +
            '" type="radio" name="sizeId" value="' +
            size.id + '"/></label>'
          sizeSelect.append(sizeTag);
        });
        sizeSelect.children().click(function () {
          const errorMessage = $("#size-modal .error-message");
          if (errorMessage.css("visibility") === "visible")
            errorMessage.css("visibility", "hidden");
        });
        $("#size-modal-price").text(
          new Intl.NumberFormat("vi-VN", {
            style: "currency",
            currency: "VND",
          }).format(parseFloat(product.price))
        );

        // Show modal after fetch product data success by ajax
        $("#size-modal").modal("show");
      },
      error: function () {
        alert("Something errors, please try again later!");
      },
    });
  });

  // $("#size-modal-form").submit(function (event) {
  //   event.preventDefault();
  //   var selectedSize = $("#sizeSelect").val();
  //   // Handle adding the product to the cart with the selected size
  //   // You can send an AJAX request to your server here
  //   alert("Product added to cart with size: " + selectedSize);
  //   $("#sizeModal").modal("hide");
  // });
});