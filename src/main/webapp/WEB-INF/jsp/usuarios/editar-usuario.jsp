<%--
  Created by IntelliJ IDEA.
  User: wang1
  Date: 22-Nov-24
  Time: 11:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.iesbelen.model.Usuario"%>
<%@page import="java.util.Optional"%>
<html>
<head>
    <title>Editar Usuario</title>
    <style>
        .clearfix::after {
            content: "";
            display: block;
            clear: both;
        }
    </style>
</head>
<body>

<div id="contenedora" style="float:none; margin: 0 auto;width: 900px;" >
    <form action="${pageContext.request.contextPath}/tienda/usuarios/editar/" method="post" >
        <input type="hidden" name="__method__" value="put" />
        <div class="clearfix">
            <div style="float: left; width: 50%">
                <h1>Editar Usuario</h1>
            </div>
            <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">

                <div style="position: absolute; left: 39%; top : 39%;">
                    <input type="submit" value="Guardar" />
                </div>

            </div>
        </div>

        <div class="clearfix">
            <hr/>
        </div>
        <% 	Optional<Usuario> optUser = (Optional<Usuario>)request.getAttribute("usuario");
            if (optUser.isPresent()) {
        %>

        <div style="margin-top: 6px;" class="clearfix">
            <div style="float: left;width: 50%">
                <label>Código</label>
            </div>
            <div style="float: none;width: auto;overflow: hidden;">
                <input name="idUsuario" value="<%= optUser.get().getIdUsuario() %>" readonly="readonly"/>
            </div>
        </div>
        <div style="margin-top: 6px;" class="clearfix">
            <div style="float: left;width: 50%">
                <label>Usuario</label>
            </div>
            <div style="float: none;width: auto;overflow: hidden;">
                <input name="usuario" value="<%= optUser.get().getUsuario() %>"/>
            </div>
        </div>
        <div style="margin-top: 6px;" class="clearfix">
            <div style="float: left;width: 50%">
                <label>Password</label>
            </div>
            <div style="float: none;width: auto;overflow: hidden;">
                <input name="password" value="<%= optUser.get().getPassword() %>"/>
            </div>
        </div>
        <div style="margin-top: 6px;" class="clearfix">
            <div style="float: left;width: 50%">
                <label>Rol</label>
            </div>
            <div style="float: none;width: auto;overflow: hidden;">
                <input name="rol" value="<%= optUser.get().getRol() %>"/>
            </div>
        </div>

        <% 	} else { %>

        request.sendRedirect("usuarios/");

        <% 	} %>
    </form>
</div>

</body>
</html>
