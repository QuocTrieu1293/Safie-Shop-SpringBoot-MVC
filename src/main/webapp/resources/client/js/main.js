
// alert modal for success or failure
const alertModal = function (message, type) {
    $("#alert-modal-message").text(message);
    if (type === 'success')
        $("#alert-modal-icon").html('<i class="bi bi-check-circle fs-1 text-success"/>');
    else if (type === "error")
        $("#alert-modal-icon").html('<i class="bi bi-x-circle fs-1 text-red"></i>');
    $("#alert-modal").modal("show");
    setTimeout(() => $("#alert-modal").modal("hide"), 5000);
}
$(document).ready(function () {
    if (successMessage) alertModal(successMessage, "success");
    else if (errorMessage) alertModal(errorMessage, "error");
});

(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner();

    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', -87);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });

    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });

    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });

    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });

    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })
    });

    $("a.nav-item, a.nav-link").each(function () {
        if ($(this).attr("href") === window.location.pathname &&
            $(this).next("ul").length === 0 // xem sideNav.jsp, cụ thể khi nấn vào `Tài khoản của tôi` thì mặc định `Hồ sơ` active
        ) {

            $(this).addClass("active");
            $(this).attr("aria-current", "page");
        }
    })
    $(".nav .nav").each(function () {
        if ($(this).find(".nav-item.active, .nav-link.active").length === 0)
            $(this).hide();
    }) // ẩn các ul cấp 2 ko có item active (xem sideNav.jsp)

    // Product search at header
    const url = new URL(window.location.href);
    const searchParams = url.searchParams;
    let searchHistory = JSON.parse(localStorage.getItem("SEARCH_HISTORY")) ?? [];

    function searchProduct(keyword) {
        keyword = keyword.trim();
        if (keyword) {
            const idx = searchHistory.findIndex(item => item.toLowerCase().trim() === keyword.toLowerCase());
            if (idx > -1)
                searchHistory.splice(idx, 1);
            else if (searchHistory.length >= 5)
                searchHistory.pop();
            searchHistory.unshift(keyword);
            localStorage.setItem("SEARCH_HISTORY", JSON.stringify(searchHistory));
        }

        if (url.pathname !== "/products") {
            let href = "/products";
            if (keyword)
                href += `?search=${encodeURIComponent(keyword)}`;
            window.location.href = href;
        } else {
            if (keyword)
                searchParams.set("search", keyword);
            else
                searchParams.delete("search")
            searchParams.delete("page");
            window.location.href = url.toString();
        }
    }

    const debounce = (callback, delay = 600) => {
        let timeout;

        return (...args) => {
            clearTimeout(timeout);
            timeout = setTimeout(() => callback(...args), delay);
        }
    };

    const getSuggestSearch = debounce((search) => {
        $("#product-search-suggest").addClass("d-none");
        $("#search-not-found").addClass("d-none");
        $("#search-loading-spinner").fadeIn("fast");

        $.get(`/api/product/search?q=${encodeURIComponent(search.trim())}`, function (products) {
            // console.log(products);
            $("#product-search-suggest").children().last().empty();
            if (products.length === 0) {
                $("#search-not-found").find("span").text(search.trim());

                if ($("#product-search").val().trim().length >= 2) {
                    $("#search-loading-spinner").fadeOut(function () {
                        $("#product-search-suggest").addClass("d-none");
                        $("#search-not-found").removeClass("d-none");
                    });
                } else {
                    $("#search-loading-spinner").hide();
                }
            } else {
                products.forEach(({ id, productName, price, image }) => {
                    const item = $(`
                        <a href="/product/${id}" class="row mx-auto mb-2 g-3">
                            <div class="col-3">
                            <img
                                src="/images/product/${image}"
                                alt="${productName}"
                                class="w-100"
                                style="object-fit: cover"
                            />
                            </div>
                            <div class="col">
                            <h6 class="my-card-title">
                                ${productName}
                            </h6>
                            <p class="fw-medium mb-0" style="color: black">
                                ${new Intl.NumberFormat("vi-VN", { style: "currency", currency: "VND" }).format(parseFloat(price))}
                            </p>
                            </div>
                        </a>
                    `);
                    item.appendTo($("#product-search-suggest").children().last());
                });

                if ($("#product-search").val().trim().length >= 2) {
                    $("#search-loading-spinner").fadeOut(function () {
                        $("#product-search-suggest").removeClass("d-none");
                        $("#search-not-found").addClass("d-none");
                    });
                } else {
                    $("#search-loading-spinner").hide();
                }
            }

        });
    });
    // end Product search at header

    $(document).ready(function () {
        const productSearch = $("#product-search");
        const productSearchBtn = $("#product-search-btn");
        const productSearchClear = $("#product-search-clear");

        $("#searchModal").on('shown.bs.modal', () => {
            productSearch.trigger("focus");
        });

        // $("#searchModal").on("show.bs.modal", function () {
        // });

        // fill productSearch
        if (
            window.location.pathname === "/products" &&
            searchParams.has("search")
        ) {
            productSearch.val(searchParams.get("search").trim());
        } else {
            productSearchClear.addClass("d-none");
        }

        $("#search-loading-spinner").hide();

        // Display product search history
        if (searchHistory.length > 0) {
            searchHistory.forEach(search => {
                const item = $("<div></div>", { class: "d-flex align-items-center mb-2 px-2 py-1 list-group-item-action rounded", role: "button" });
                item.append($("<i></i>", { class: "bi bi-clock me-2" }), search, $("<i></i>", { class: "bi bi-x ms-auto link-secondary d-none fs-5 lh-1" }));
                item.on("mouseenter", function () {
                    $(this).children().last().removeClass("d-none");
                });
                item.on("mouseleave", function () {
                    $(this).children().last().addClass("d-none");
                });
                item.on("click", function () {
                    searchProduct(search);
                });
                item.children().last().on("click", function (e) {
                    e.stopPropagation();
                    searchHistory = searchHistory.filter(s => s !== search);
                    localStorage.setItem("SEARCH_HISTORY", JSON.stringify(searchHistory));
                    item.remove();
                    if (searchHistory.length === 0) {
                        $("#product-search-history").addClass("d-none");
                    }
                });

                $("#product-search-history").children().last().append(item);
            });
        }

        if (!productSearch.val().trim() && searchHistory.length > 0)
            $("#product-search-history").removeClass("d-none");
        else if (productSearch.val().trim())
            getSuggestSearch(productSearch.val().trim());

        // $("#searchModal").modal('show')

        productSearchBtn.click(function () {
            searchProduct(productSearch.val().trim());
        });

        productSearchClear.click(function () {
            productSearch.val("");
            productSearchClear.addClass("d-none");
            productSearch.focus();

            if (searchHistory.length > 0)
                $("#product-search-history").removeClass("d-none");

            $("#product-search-suggest").addClass("d-none");
            $("#search-not-found").addClass("d-none");
        });

        productSearch.on("input", function () {
            const val = $(this).val();

            // Ẩn / Hiện clear search btn
            if (val && productSearchClear.hasClass("d-none"))
                productSearchClear.removeClass("d-none");
            else if (!val && !productSearchClear.hasClass("d-none"))
                productSearchClear.addClass("d-none");

            // Suggest search query using Ajax + Debounce for better performance
            if (val.trim().length >= 2) {
                $("#product-search-history").addClass("d-none");
                getSuggestSearch(val.trim());
            } else {
                if (searchHistory.length > 0)
                    $("#product-search-history").removeClass("d-none");
                $("#product-search-suggest").addClass("d-none");
                $("#search-not-found").addClass("d-none");
            }

        });
        productSearch.keydown(function (e) {
            if (e.key === "Enter") {
                searchProduct(productSearch.val().trim());
            }
        });

        $("#product-search-history-clear").on("click", function () {
            $("#product-search-history").addClass("d-none");
            $("#product-search-history").children().last().empty();
            localStorage.removeItem("SEARCH_HISTORY");
        })
    });

})(jQuery);

