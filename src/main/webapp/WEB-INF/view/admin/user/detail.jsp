<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Detail ${user.id}</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <script
      defer
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <script
      defer
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
    ></script>
  </head>
  <body>
    <div class="container mt-5">
      <div class="row">
        <div class="col">
          <div class="d-flex align-items-center justify-content-between">
            <h1>User Detail</h1>
          </div>
          <hr />
          <div class="card" style="width: 60%">
            <div class="card-header">User information</div>
            <ul class="list-group list-group-flush">
              <li class="list-group-item">ID: ${user.id}</li>
              <li class="list-group-item">Email: ${user.email}</li>
              <li class="list-group-item">FullName: ${user.fullName}</li>
              <li class="list-group-item">Address: ${user.address}</li>
            </ul>
          </div>
          <a href="/admin/user" class="btn btn-success mt-3">Back</a>
        </div>
      </div>
    </div>
  </body>
</html>
