/*!
    * Start Bootstrap - SB Admin v7.0.7 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2023 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */
// 
// Scripts
// 

window.addEventListener('DOMContentLoaded', event => {

    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle between refreshes
        // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
        //     document.body.classList.toggle('sb-sidenav-toggled');
        // }
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }

});

$(document).ready(function () {
    $("#sidenavAccordion").find("a.nav-link").each(function () {
        const href = $(this).attr("href");
        const pathname = window.location.pathname;
        if (pathname === href || (href !== "/admin" && pathname.startsWith(href)))
            $(this).addClass("active");
    });
});

function goBack() {
    // console.log(document.referrer);
    if (!document.referrer || (new URL(document.referrer)).host !== window.location.host || document.referrer === window.location.href)
        window.location.pathname = $(".breadcrumb-item.active").prev().children("a").attr("href");
    else
        window.location.href = document.referrer;
}


