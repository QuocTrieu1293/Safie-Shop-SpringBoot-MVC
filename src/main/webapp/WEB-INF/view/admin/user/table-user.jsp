<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
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
            <h1>Table users</h1>
            <a href="/admin/user/create" class="btn btn-primary btn-lg"
              >Create a user</a
            >
          </div>
          <hr />
          <table class="table table-hover table-bordered">
            <thead>
              <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Full Name</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody class="table-group-divider">
              <c:forEach var="user" items="${userList}">
                <tr>
                  <td>${user.id}</td>
                  <td>${user.email}</td>
                  <td>${user.fullName}</td>
                  <td>
                    <a
                      href="/admin/user/${user.id}"
                      class="btn btn-success me-2"
                      >View</a
                    >
                    <a
                      href="/admin/user/update/${user.id}"
                      class="btn btn-warning me-2"
                      >Update</a
                    >
                    <a href="#" class="btn btn-danger">Delete</a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </body>
</html>
