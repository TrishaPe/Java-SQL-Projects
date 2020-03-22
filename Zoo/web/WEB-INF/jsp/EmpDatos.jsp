<%-- 
    Document   : EmpDatos
    Created on : Dec 10, 2019, 3:33:06 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <title>Empleados Departamento</title>
        <style>
            th, td{
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="plantillas/header2_half1.jsp"/>
            
            <li><a href="misdatos.htm">Mis datos</a></li>
            <li class="active"><a href="empdatos.htm">Datos empleados</a></li>
            <li><a href="animal.htm">Animales</a></li>
            <li><a href="peticiones.htm?peticiones=inicio">Pedidos</a></li>
        
        <jsp:include page="plantillas/header2_half2.jsp"/>
      
      <div class="container">
        <h3>Datos de empleados</h3>
        <c:choose>
            <c:when test="${empleado.dept_cod==1||empleado.funcion=="gestor"}">
                <form action="moddatos.htm">
                    <button type="submit" name="modif" value="preAñadir">Añadir empleado</button>
                </form>
                
                <c:forEach items="${departamentos}" var="dept">
                <h4>Departamento ${dept.nombre}</h4>
                <form action="moddatos.htm">
                    <table>
                        <thead><tr>
                            <th>Seleccionar</th>
                            <th>Codigo</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Función</th>
                            <th>Salario</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                        </tr></thead>
                        <tbody>
                            <c:forEach items="${subordinados}" var="sub">
                                <c:if test="${sub.departamento==dept.nombre}">
                                <tr>
                                    <td><input type="radio" name="moddatos" value="${sub.codigo}"/></td>
                                    <td>${sub.codigo}</td>
                                    <td>${sub.nombre}</td>
                                    <td>${sub.apellidos}</td>
                                    <td>${sub.funcion}</td>
                                    <td>${sub.salario}</td>
                                    <td>${sub.direccion}</td>
                                    <td>${sub.telefono}</td>
                                </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                    <button type="submit" name="modif" value="abrir">Más información</button>
                </form>
                </c:forEach>
                <a href="portemp.htm?portemp=inicio">Volver</a>
            </c:when>
            <c:otherwise>
                <h4>Departamento ${empleado.departamento}</h4>
                <table>
                    <thead><tr>
                        <th>Codigo</th>
                        <th>Nombre</th>
                        <th>Apellidos</th>
                        <th>Función</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                    </tr></thead>
                    <tbody>
                        <c:forEach items="${subordinados}" var="sub">
                            <tr>
                                <td>${sub.codigo}</td>
                                <td>${sub.nombre}</td>
                                <td>${sub.apellidos}</td>
                                <td>${sub.funcion}</td>
                                <td>${sub.direccion}</td>
                                <td>${sub.telefono}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <a href="portemp.htm?portemp=inicio">Volver</a>
            </c:otherwise>
        </c:choose>
      </div>
      <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
    </body>
</html>
