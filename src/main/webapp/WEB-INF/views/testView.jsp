<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <form:form action="/test/form" method="post">
      <div style="margin-bottom: 15px">
        <label for="inputText" style="margin-left: 10px">Input Text:</label>
        <input type="text" id="inputText" name="inputText" />
      </div>
      <div style="margin-bottom: 15px">
        <label for="multipleSelect" style="margin-left: 10px"
          >Multiple Select:</label
        >
        <select
          id="multipleSelect"
          name="multipleSelect"
          multiple
          style="min-width: 150px; padding: 5px"
        >
          <option value="Trieu">Trieu</option>
          <option value="Ngan">Ngan</option>
          <option value="Thai">Thai</option>
          <option value="Dung">Dung</option>
        </select>
      </div>
      <button>submit</button>
    </form:form>
  </body>
</html>
