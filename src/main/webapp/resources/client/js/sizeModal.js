$(document).ready(function () {
  $("#size-modal .error-message").css("visibility", "hidden");
  $("form#size-modal-form").submit(function (e) {
    if (!this.checkValidity()) {
      e.preventDefault();
      $(this).find(".error-message").css("visibility", "visible");
    }
  });
  $("#size-modal").on("hide.bs.modal", function () {
    const errorMessage = $(this).find(".error-message");
    if (errorMessage.css("visibility") === "visible")
      errorMessage.css("visibility", "hidden");
  })

  if (addedProduct && addedSize) {
    $("#alert-modal").modal("show");
  }

  $("[size-modal-trigger]").click(function () {
    if (!"${userId}") {
      window.location.href = "/login";
      return;
    }
    // console.log("still run below code");

    const productId = $(this).data("product-id");

    // Make an AJAX request to fetch the sizes for the selected product
    $.ajax({
      url: "/api/product", // URL to fetch sizes
      method: "GET",
      data: { id: productId },
      timeout: 600000,
      success: function (product) {
        // console.log({ product });
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