<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@page import="org.iesbelen.model.FabricanteDTO" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fabricantes</title>
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
<main>
    <section>
        <div id="contenedora" style="float:none; margin: 0 auto;width: 900px;">
            <div class="clearfix">
                <div style="float: left; width: 50%">
                    <h1>Fabricantes</h1>
                </div>
                <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">
                    <div style="position: absolute; left: 39%; top : 39%;">

                        <form action="${pageContext.request.contextPath}/tienda/fabricantes/crear">
                            <input type="submit" value="Crear">
                        </form>

                    </div>

                </div>
            </div>
            <div class="clearfix">
                <hr/>
            </div>
            <div class="clearfix">
                <div style="float: left;width: 25%">Código</div>
                <div style="float: left;width: 25%">Nombre</div>
                <div style="float: left;width: 25%">Productos</div>
                <div style="float: none;width: auto;overflow: hidden;">Acción</div>
            </div>
            <div class="clearfix">
                <hr/>
            </div>
            <%
                if (request.getAttribute("listaFabricantesDTO") != null) {
                    List<FabricanteDTO> listaFabricanteDTO = (List<FabricanteDTO>) request.getAttribute("listaFabricantesDTO");

                    for (FabricanteDTO fab : listaFabricanteDTO) {
            %>

            <div style="margin-top: 6px;" class="clearfix">
                <div style="float: left;width: 25%"><%= fab.getIdFabricante()%>
                </div>
                <div style="float: left;width: 25%"><%= fab.getNombre()%>
                </div>
                <div style="float: left;width: 25%"><%= fab.getNumProductos()%>
                </div>

                <div style="float: none;width: auto;overflow: hidden;">
                    <form action="${pageContext.request.contextPath}/tienda/fabricantes/<%= fab.getIdFabricante()%>"
                          style="display: inline;">
                        <input type="submit" value="Ver Detalle"/>
                    </form>
                    <form action="${pageContext.request.contextPath}/tienda/fabricantes/editar/<%= fab.getIdFabricante()%>"
                          style="display: inline;">
                        <input type="submit" value="Editar"/>
                    </form>
                    <form action="${pageContext.request.contextPath}/tienda/fabricantes/borrar/" method="post"
                          style="display: inline;">
                        <input type="hidden" name="__method__" value="delete"/>
                        <input type="hidden" name="codigo" value="<%= fab.getIdFabricante()%>"/>
                        <input type="submit" value="Eliminar"/>
                    </form>
                </div>
            </div>

            <%
                }
            } else {
            %>
            No hay registros de fabricante
            <% } %>
        </div>
        <div style="float:none; margin-left: 60%; margin-top: 30px;width: 900px;">
            <form action="${pageContext.request.contextPath}/tienda/fabricantes/">
                <select name="ordenar" id="ordenar">
                    <option value="" disabled selected>Ordenar por</option>
                    <option value="nombre">Nombre</option>
                    <option value="codigo">Código</option>
                </select>
                <select name="modo" id="modo">
                    <option value="" disabled selected>Modo</option>
                    <option value="asc">Ascendente</option>
                    <option value="desc">Descendente</option>
                </select>
                <input type="submit" value="Ordenar"/>
            </form>
        </div>
    </section>
</main>
<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>
</body>
</html>