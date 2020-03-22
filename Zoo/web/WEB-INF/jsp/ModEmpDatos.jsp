<%-- 
    Document   : ModEmpDatos
    Created on : Dec 12, 2019, 6:56:13 PM
    Author     : Trisha
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos empleado</title>
        <style>
            input, select{
                margin-bottom: 10px;
            }
            
            label{
                margin-bottom: 5px;
                min-width: 128px;
            }

        </style>
    </head>
    <body>
        <jsp:include page="plantillas/header2.jsp"/>
        <div class="container-fluid">
        <c:choose>
            <c:when test="${accion.equals("añadir")}">
                <h1>Añadir empleado</h1>
                    <form action="moddatos.htm">
                        <div class="col-xs-3"><label>Número empleado: </label></div><input type="text" name="codigo"/><br/>
                        <div class="col-xs-3"><label>Nombre: </label></div><input type="text" name="nombre"/><br/>
                        <div class="col-xs-3"><label>Apellidos: </label></div><input type="text" name="apellidos"/><br/>
                        <div class="col-xs-3"><label>Dirección: </label></div><input type="text" name="direccion"/><br/>
                        <div class="col-xs-3"><label>Teléfono: </label></div><input type="text" name="telefono"/><br/>
                        <div class="col-xs-3"><label>Salario: </label></div><input type="text" name="salario"/><br/>
                        <div class="col-xs-3"><label>Función: </label></div>
                        <select name="funcion" class="browser-default custom-select">
                            <c:forEach items="${funciones}" var="fun">
                                <option value="${fun}">${fun}</option>
                            </c:forEach>
                        </select><br>
                        <div class="col-xs-3"><label>Departamento: </label></div>
                        <select name="dept" class="browser-default custom-select">
                            <c:forEach items="${departamentos}" var="dept">
                                <option value="${dept.codigo}">${dept.nombre}</option>
                            </c:forEach>
                        </select><br>
                        <button type="submit" name="modif" value="añadir">Añadir</button>
                    </form>
            </c:when>
            <c:otherwise>
                <h1>Modificar datos empleado</h1>
                <div>
                    <form action="moddatos.htm">
                        <label>Número empleado: </label>${sub.codigo}<input type="hidden" name="codigo" value="${sub.codigo}"/><br/>
                        <label>Nombre: </label>${sub.nombre}<br/>
                        <label>Apellidos: </label>${sub.apellidos}<br/>
                        <label>Dirección: </label><input type="text" name="direccion" value="${sub.direccion}"/><br/>
                        <label>Teléfono: </label><input type="text" name="telefono" value="${sub.telefono}"/><br/>
                        <label>Función: </label><input type="text" name="funcion" value="${sub.funcion}"/><br/>
                        <label>Departamento: </label><input type="text" name="dept" value="${sub.dept_cod}"/><br/>
                        <label>Salario: </label><input type="text" name="salario" value="${sub.salario}"/><br/>
                        <button type="submit" name="modif" value="modif">Modificar</button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
        <c:if test="${resultado=="bien"}">
            <div>
                <h4>Cambio realizado</h4>
            </div>
        </c:if>

        <c:if test="${resultado=="mal"}">
            <div>
                <h4>Error</h4>
            </div>
        </c:if>
        </div>
        <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
    </body>
</html>
