<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <h1 style="text-align: center; margin-top: 30px;">Hello from JSP</h1>
  
  <p> <%=(new java.util.Date()).toLocaleString()%> </p>
  <p> ${test} </p>
  <p>trieu: ${trieu} </p>
</body>
</html>