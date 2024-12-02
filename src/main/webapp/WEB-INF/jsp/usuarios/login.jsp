<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login de Usuario</title>
    <style>
        .error {
            color: red;
        }
         body {
             text-align: center;
             font-family: Arial, sans-serif;
             margin: 0;
             background: rgb(143, 188, 192);
             background: fixed linear-gradient(30deg, rgba(143, 188, 192, 1) 7%, rgba(220, 223, 218, 1) 36%, rgba(235, 230, 223, 1) 64%, rgba(143, 188, 192, 1) 88%);
             padding: 0;
         }

        h1 {
            color: rgb(134, 28, 51);
            font-size: 40px;
        }

        h3 {
            color: rgb(134, 28, 91);
        }
    </style>
</head>
<body>
<div id="contenedora" style="float:none; margin: 0 auto;width: 900px;">
<h1>Login de Usuario</h1>
<form action="${pageContext.request.contextPath}/tienda/usuarios/login" method="post">
    <div class="clearfix">
        <hr/>
    </div>
    <div style="margin-top: 6px;" class="clearfix">
        <div style="float: left;width: 50%">
            <label for="usuario">Usuario:</label>
        </div>
        <div style="float: none;width: auto;overflow: hidden;">
            <input type="text" id="usuario" name="usuario" required>
        </div>
    </div>


    <div style="margin-top: 6px;" class="clearfix">
        <div style="float: left;width: 50%">
            <label for="password">Contraseña:</label>
        </div>
        <div style="float: none;width: auto;overflow: hidden;">
            <input type="password" id="password" name="password" required>
        </div>
    </div>

    <div>
        <input type="submit" value="Iniciar Sesión">
    </div>
</form>
</div>
<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<p style="color:red;"><%= error %>
</p>
<%
    }
%>
</body>
</html>
