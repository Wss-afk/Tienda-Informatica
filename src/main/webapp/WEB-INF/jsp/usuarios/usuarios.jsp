<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@page import="org.iesbelen.model.Usuario" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Usuarios</title>
    <style>
        .clearfix::after {
            content: "";
            display: block;
            clear: both;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/fragmentos/header.jspf" %>
<%@ include file="/WEB-INF/jsp/fragmentos/nav.jspf" %>

<div id="contenedora" style="float:none; margin: 0 auto;width: 900px;">
    <div class="clearfix">
        <div style="float: left; width: 50%">
            <h1>Usuarios</h1>
        </div>
        <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">
            <div style="position: absolute; left: 39%; top : 39%;">

                <form action="${pageContext.request.contextPath}/tienda/usuarios/crear">
                    <input type="submit" value="Crear">
                </form>

            </div>

        </div>
    </div>
    <div class="clearfix">
        <hr/>
    </div>
    <div class="clearfix">
        <div style="float: left;width: 19%">ID</div>
        <div style="float: left;width: 19%">Usuario</div>
        <div style="float: left;width: 19%">Password</div>
        <div style="float: left;width: 19%">Rol</div>
        <div style="float: none;width: auto;overflow: hidden;">Acción</div>
    </div>
    <div class="clearfix">
        <hr/>
    </div>
    <%
        List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
        if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
            for (Usuario user : listaUsuarios) {
    %>

    <div style="margin-top: 6px;" class="clearfix">
        <div style="float: left;width: 19%"><%= user.getIdUsuario()%>
        </div>
        <div style="float: left;width: 19%"><%= user.getUsuario()%>
        </div>
        <div style="float: left;width: 19%"><%= user.getPassword().substring(2,5)%>
        </div>
        <div style="float: left;width: 19%"><%= user.getRol()%>
        </div>

        <div style="float: none;width: 24%;overflow: hidden;">
            <form action="${pageContext.request.contextPath}/tienda/usuarios/<%= user.getIdUsuario()%>"
                  style="display: inline;">
                <input type="submit" value="Ver Detalle"/>
            </form>
            <form action="${pageContext.request.contextPath}/tienda/usuarios/editar/<%= user.getIdUsuario()%>"
                  style="display: inline;">
                <input type="submit" value="Editar"/>
            </form>
            <form action="${pageContext.request.contextPath}/tienda/usuarios/borrar/" method="post"
                  style="display: inline;">
                <input type="hidden" name="__method__" value="delete"/>
                <input type="hidden" name="codigo" value="<%= user.getIdUsuario()%>"/>
                <input type="submit" value="Eliminar" onclick="return confirm('¿Estás seguro de que deseas eliminar este usuario? Que despues me lloras')"/>
            </form>
        </div>
    </div>

    <%
        }
    } else {
    %>
    No hay registros de usuarios
    <% } %>
</div>
</body>
</html>
