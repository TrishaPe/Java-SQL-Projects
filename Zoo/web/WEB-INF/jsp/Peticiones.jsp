<%-- 
    Document   : Peticiones
    Created on : Dec 10, 2019, 3:35:41 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <title>Pedidos y peticiones</title>
        <style>
            table, td{
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px;
            }
            
            .petnueva{
                border: 1px solid black;
                width: 60%;
                padding: 5px;
            }
            
            label{
                vertical-align: top;
            }
        </style>
    </head>
    <body>
        <jsp:include page="plantillas/header2_half1.jsp"/>
            
            <li><a href="misdatos.htm">Mis datos</a></li>
                <c:if test="${empleado.dept_cod==1 || empleado.funcion=="gestor"}">
                    <li><a href="empdatos.htm">Datos empleados</a></li>
                </c:if>
            <li><a href="animal.htm">Animales</a></li>
            <li class="active"><a href="peticiones.htm?peticiones=inicio">Pedidos</a></li>
        
        <jsp:include page="plantillas/header2_half2.jsp"/>
        
        <div class="container">
        <h1>Pedidos y peticiones</h1>
        
        <div><%--Pedidos--%>
        <h3>Pedidos de camino</h3>
        <c:choose>
            <c:when test="${empleado.funcion=="CFO"}">
                <form action="peticiones.htm">
                    <table>
                        <thead><tr><th>Contenido</th><th>Precio</th><th>Proveedor</th><th>Fecha prevista</th><th>Llegado</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pedidos}" var="ped">
                                <tr>
                                    <td>${ped.contenido}</td>
                                    <td>€ ${ped.precio}</td>
                                    <td>${ped.proveedor}</td>
                                    <td>${ped.fecha}</td>
                                    <td><input type="checkbox" name="llegado" value="${ped.pedido_cod}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <button type="input" name="peticiones" value="confirmllega">Guardar</button> 
                </form>
                <c:if test="${llega==1}">
                    <h4>Guardado con éxito</h4>
                </c:if>
                <c:if test="${llega==0}">
                    <h4>Error</h4>
                </c:if>
            </c:when>
            <c:when test="${empleado.dept_cod==1 && empleado.funcion!="CFO"}">
                <table>
                    <thead><tr><th>Contenido</th><th>Precio</th><th>Proveedor</th><th>Fecha prevista</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pedidos}" var="ped">
                            <tr>
                                <td>${ped.contenido}</td>
                                <td>€ ${ped.precio}</td>
                                <td>${ped.proveedor}</td>
                                <td>${ped.fecha}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <table>
                    <thead><tr><th>Contenido</th><th>Fecha prevista</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pedidos}" var="ped">
                            <tr>
                                <td>${ped.contenido}</td>
                                <td>${ped.fecha}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
        </div>
            
        <div><%--Pendientes--%>
            <h3>Peticiones pendientes</h3>
            <table>
                <tr>
                    <th>Especie</th>
                    <th>Departamento</th>
                    <th>Contenido</th>
                    <th>Fecha</th>
                </tr>
                <c:forEach items="${peticiones}" var="pet">
                    <tr>
                        <td>${pet.especie}</td>
                        <td>${pet.departamento}</td>
                        <td>${pet.contenido}</td>
                        <td>${pet.fecha}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        
        <%--Peticion nueva--%>
        <h3>Registrar una petición</h3>
        <div class="petnueva">
            <form action="peticiones.htm">
                <label style="margin-right: 80px">Contenido: </label>
                <textarea cols="20" rows="5" max="50" name="contenido" required></textarea><br/>
                <label style="margin-right: 100px">Especie: </label><input type="text" name="especie" required/><br/>
                <label style="margin-right: 7px">Codigo Departamento: </label><input type="number" name="dept" required/><br/>
                <label style="margin-right: 76px">Fecha meta: </label><input type="date" name="fecha" required/><br/>
                <button type="submit" name="peticiones" value="pedir">Enviar</button>
            </form>
            <c:if test="${resped>0}">
                <h4>Enviado correctamente</h4>
            </c:if>
            <c:if test="${resped==0}">
                <h4>Error</h4>
            </c:if>
        </div>
        
        <div><%--Historial--%>
            <h3>Historial de pedidos</h3>
            <table>
                <thead><tr><th>Contenido</th><th>Precio</th><th>Fecha</th><th>Proveedor</th></tr></thead>
                <tbody>
                    <c:forEach items="${historial}" var="ped">
                        <tr>
                            <td>${ped.contenido}</td>
                            <td>${ped.precio}</td>
                            <td>${ped.fecha}</td>
                            <td>${ped.proveedor}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        </div>
        
        <div class="container">
            <a href="portemp.htm?portemp=inicio">Volver</a><br/>
        </div>
        
        <footer class="pt-4 my-md-5 pt-md-5 border-top">
          <br/>
        </footer>
        <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
    </body>
</html>
