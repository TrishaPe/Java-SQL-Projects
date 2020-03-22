<%-- 
    Document   : Animales
    Created on : Dec 17, 2019, 8:12:32 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <title>Datos animales</title>
        <style>
            td, th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="plantillas/header2_half1.jsp"/>
            
            <li><a href="misdatos.htm">Mis datos</a></li>
                <c:if test="${empleado.dept_cod==1 || empleado.funcion=="gestor"}">
                    <li><a href="empdatos.htm">Datos empleados</a></li>
                </c:if>
            <li class="active"><a href="animal.htm">Animales</a></li>
            <li><a href="peticiones.htm?peticiones=inicio">Pedidos</a></li>
        
        <jsp:include page="plantillas/header2_half2.jsp"/>
        
        <div class="container">
        <c:choose>
            <c:when test="${empleado.dept_cod==1}">
                <h1>Lista de animales</h1>
                <form action="animaldatos.htm">
                    <button type="submit" name="adatos" value="preañadir">Añadir animal</button>
                </form>
                
                <c:forEach items="${departamentos}" var="dept">
                <h4>Departamento ${dept.nombre}</h4>
                <form action="animaldatos.htm">
                    <table>
                        <thead><tr>
                            <th>Seleccionar</th>
                            <th>Codigo</th>
                            <th>Especie</th>
                            <th>Nombre</th>
                            <th>Sexo</th>
                            <th>Empleado</th>
                            <th>Notas</th>
                        </tr></thead>
                        <tbody>
                            <c:forEach items="${animales}" var="ani">
                                <c:if test="${ani.dept_cod==dept.codigo}">
                                <tr>
                                    <td><input type="radio" name="anidatos" value="${ani.animal_cod}"/></td>
                                    <td>${ani.animal_cod}</td>
                                    <td>${ani.especie}</td>
                                    <td>${ani.nombre}</td>
                                    <td>${ani.sexo}</td>
                                    <td>${ani.emp_cod}</td>
                                    <td>${ani.notas}</td>
                                </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                    <button type="submit" name="adatos" value="inicio">Modificar</button>
                </form>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <h1>Lista de animales departamento ${empleado.dept_cod}</h1>
                <form action="animaldatos.htm">
                    <table>
                        <thead><tr>
                            <th>Seleccionar</th>
                            <th>Codigo</th>
                            <th>Especie</th>
                            <th>Nombre</th>
                            <th>Sexo</th>
                            <th>Empleado</th>
                            <th>Notas</th>
                        </tr></thead>
                        <tbody>
                        <c:forEach items="${animales}" var="ani">
                            <tr>
                                <td><input type="radio" name="anidatos" value="${ani.animal_cod}"/></td>
                                <td>${ani.animal_cod}</td>
                                <td>${ani.especie}</td>
                                <td>${ani.nombre}</td>
                                <td>${ani.sexo}</td>
                                <td>${ani.emp_cod}</td>
                                <td>${ani.notas}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <button type="submit" name="adatos" value="inicio">Modificar</button>
                </form>
            </c:otherwise>
        </c:choose>
        <a href="portemp.htm?portemp=inicio">Volver</a>
        </div>
        
        <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
    </body>
</html>