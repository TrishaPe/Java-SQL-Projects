<%-- 
    Document   : MisDatos
    Created on : Dec 10, 2019, 3:32:57 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <title>Mis datos</title>
    </head>
    <body>
        <jsp:include page="plantillas/header2_half1.jsp"/>
            
            <li class="active"><a href="misdatos.htm">Mis datos</a></li>
                <c:if test="${empleado.dept_cod==1 || empleado.funcion=="gestor"}">
                    <li><a href="empdatos.htm">Datos empleados</a></li>
                </c:if>
            <li><a href="animal.htm">Animales</a></li>
            <li><a href="peticiones.htm?peticiones=inicio">Pedidos</a></li>
        
        <jsp:include page="plantillas/header2_half2.jsp"/>
        
        <div class="container">
            <h1>Datos empleado ${empleado.nombre}</h1>
            Apellidos: ${empleado.apellidos}<br/>
            Codigo empleado: ${empleado.codigo}<br/>
            Departamento: ${empleado.departamento}<br/>
            Funcion: ${empleado.funcion}<br/>
            Direccion: ${empleado.direccion}<br/>
            Telefono: ${empleado.telefono}<br/>
        </div>

        
        <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
    </body>
</html>
