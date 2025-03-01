<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="Safie shop" />
    <meta name="author" content="Quoc Trieu" />
    <title>Admin Dashboard</title>
    <link rel="manifest" href="/site.webmanifest" />
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
      integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
  </head>
  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="../layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Product Detail</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="/admin/product">Products</a>
              </li>
              <li class="breadcrumb-item active">Detail</li>
            </ol>
            <hr />
            <div class="row g-3">
              <div
                class="col-md-3 col-12 d-flex justify-content-center align-items-start"
              >
                <img
                  src="/images/product/${product.image}"
                  alt="product"
                  style="max-width: 200px; object-fit: cover"
                  class="rounded"
                />
              </div>
              <div class="col-md-7 col-12">
                <div class="card">
                  <div class="card-header">Product information</div>
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>ID:</b></div>
                        <div class="col">${product.id}</div>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Name:</b></div>
                        <div class="col">${product.name}</div>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Price:</b></div>
                        <div class="col">${product.price}</div>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Short description:</b></div>
                        <div class="col">${product.shortDesc}</div>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Detail description:</b></div>
                        <div class="col">${product.detailDesc}</div>
                      </div>
                    </li>

                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Quantity:</b></div>
                        <div class="col">${product.quantity}</div>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Sold:</b></div>
                        <div class="col">${product.sold}</div>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Category:</b></div>
                        <div class="col">${product.category.name}</div>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Brand:</b></div>
                        <div class="col">${product.brand.name}</div>
                      </div>
                    </li>
                    <li class="list-group-item">
                      <div class="row">
                        <div class="col-3"><b>Sizes:</b></div>
                        <div class="col">
                          <div class="row g-1">
                            <c:forEach var="size" items="${product.sizes}">
                              <span class="me-3 col text-nowrap"
                                >${size.name}</span
                              >
                            </c:forEach>
                          </div>
                        </div>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <a role="button" class="btn btn-success my-3" onclick="goBack()"
              >Back</a
            >
          </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="/js/scripts.js"></script>
  </body>
</html>
