<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.iesbelen.model.Usuario" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Usuario</title>
    <style>
        .clearfix::after {
            content: "";
            display: block;
            clear: both;
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
    </style>
</head>
<body>

<div id="contenedora" style="float:none; margin: 0 auto;width: 900px;">
    <form action="${pageContext.request.contextPath}/tienda/usuarios/crear/" method="post">
        <div class="clearfix">
            <div style="float: left; width: 50%">
                <h1>Crear Usuario</h1>
            </div>
            <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">
                <div style="position: absolute; left: 39%; top : 39%;">
                    <input type="submit" value="Crear"/>
                </div>
            </div>
        </div>

        <div class="clearfix">
            <hr/>
        </div>

        <div style="margin-top: 6px;" class="clearfix">
            <div style="float: left;width: 50%">
                Usuario
            </div>
            <div style="float: none;width: auto;overflow: hidden;">
                <input name="usuario"/>
            </div>
        </div>


        <div style="margin-top: 6px;" class="clearfix">
            <div style="float: left;width: 50%">
                password
            </div>
            <div style="float: none;width: auto;overflow: hidden;">
                <input name="password"/>
            </div>
        </div>

        <div style="margin-top: 6px;" class="clearfix">
            <div style="float: left;width: 50%">
                rol
            </div>
            <div style="float: none;width: auto;overflow: hidden;">
                    <select name="rol">
                        <option value="administrador">administrador</option>
                        <option value="Vendedor">Vendedor</option>
                        <option value="Trabajador">Trabajador</option>
                </select>
            </div>
        </div>

    </form>
</div>


</body>
</html>
