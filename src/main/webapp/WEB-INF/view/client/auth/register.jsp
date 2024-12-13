<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Register User</title>
    <link href="css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  </head>
  <body class="bg-primary">
    <div id="layoutAuthentication">
      <div id="layoutAuthentication_content">
        <main>
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-lg-7">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                  <div class="card-header">
                    <h3 class="text-center font-weight-light my-4">
                      Create Account
                    </h3>
                  </div>
                  <div class="card-body">
                    <form:form
                      modelAttribute="registerUser"
                      method="post"
                      action="/register"
                      novalidate="true"
                      id="form"
                    >
                      <div class="row mb-3">
                        <div class="col-md-6">
                          <div class="form-floating mb-3 mb-md-0">
                            <c:set var="firstNameBindErrors"
                              ><form:errors
                                path="firstName"
                                cssClass="invalid-feedback server-validate-feedback"
                            /></c:set>
                            <form:input
                              class="form-control ${not empty firstNameBindErrors ? 'is-invalid' : ''}"
                              id="inputFirstName"
                              type="text"
                              placeholder="Enter your first name"
                              path="firstName"
                              required="true"
                            />
                            <label for="inputFirstName">First name</label>
                            ${firstNameBindErrors}
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-floating">
                            <c:set var="lastNameBindErrors"
                              ><form:errors
                                path="lastName"
                                cssClass="invalid-feedback server-validate-feedback"
                            /></c:set>
                            <form:input
                              class="form-control ${not empty lastNameBindErrors ? 'is-invalid' : ''}"
                              id="inputLastName"
                              type="text"
                              placeholder="Enter your last name"
                              path="lastName"
                              required="true"
                            />
                            <label for="inputLastName">Last name</label>
                            ${lastNameBindErrors}
                          </div>
                        </div>
                      </div>

                      <!-- email -->
                      <div>
                        <c:set var="emailBindErrors"
                          ><form:errors
                            path="email"
                            cssClass="invalid-feedback server-validate-feedback"
                        /></c:set>
                        <div class="form-floating mb-3">
                          <form:input
                            class="form-control ${not empty emailBindErrors ? 'is-invalid' : ''}"
                            id="inputEmail"
                            type="email"
                            placeholder="name@example.com"
                            path="email"
                            required="true"
                          />
                          <label for="inputEmail">Email address</label>
                          ${emailBindErrors}
                        </div>
                      </div>

                      <div class="row mb-3">
                        <div class="col-md-6">
                          <c:set var="passwordBindErrors"
                            ><form:errors
                              path="password"
                              cssClass="invalid-feedback server-validate-feedback"
                          /></c:set>
                          <div class="form-floating mb-3 mb-md-0">
                            <form:input
                              class="form-control ${not empty passwordBindErrors ? 'is-invalid' : ''}"
                              id="inputPassword"
                              type="password"
                              placeholder="Create a password"
                              path="password"
                              required="true"
                            />
                            <label for="inputPassword">Password</label>
                            ${passwordBindErrors}
                          </div>
                        </div>
                        <div class="col-md-6">
                          <c:set var="CfPasswordBindErrors"
                            ><form:errors
                              path="confirmPassword"
                              cssClass="invalid-feedback server-validate-feedback"
                          /></c:set>
                          <div class="form-floating mb-3 mb-md-0">
                            <form:input
                              class="form-control ${not empty CfPasswordBindErrors ? 'is-invalid' : ''}"
                              id="inputPasswordConfirm"
                              type="password"
                              placeholder="Confirm password"
                              path="confirmPassword"
                              required="true"
                            />
                            <label for="inputPasswordConfirm"
                              >Confirm Password</label
                            >
                            ${CfPasswordBindErrors}
                          </div>
                        </div>
                      </div>
                      <div class="mt-4 mb-0">
                        <div class="d-grid">
                          <button
                            type="submit"
                            class="btn btn-primary btn-block"
                          >
                            Create Account
                          </button>
                        </div>
                      </div>
                    </form:form>
                  </div>
                  <div class="card-footer text-center py-3">
                    <div class="small">
                      <a href="/login">Have an account? Go to login</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="js/scripts.js"></script>
    <script>
      $(document).ready(() => {
        $("#form").submit(function (e) {
          if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
          }

          $(this).addClass("was-validated");
          $(".server-validate-feedback").remove();
          $(".client-validate-feedback").removeClass("d-none");
        });

        $(".form-control").on("input", function () {
          $(this).removeClass("is-invalid");
          $(this).siblings(".server-validate-feedback").remove();
          $(".client-validate-feedback").removeClass("d-none");
        });
      });
    </script>
  </body>
</html>
