<%-- 
    Document   : LogEmp
    Created on : Dec 1, 2019, 4:58:37 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="plantillas/Bootstrap_head.jsp"/>
    
    
    <style>
        .form-signin, .mensaje{
            max-width: 400px;
            padding: 15px;
            margin: 0 auto;
        }
    </style>
  </head>

  <body>
    <div class="container">
      <form class="form-signin" action="portemp.htm">
        <h2 class="form-signin-heading">Entrada de Empleados</h2>
        <input type="text" name="txtUsuario" id="inputEmail" class="form-control" placeholder="Usuario" required autofocus/>
        <input type="text" name="txtContraseña" id="inputPassword" class="form-control" placeholder="Contraseña" required/>
        <br/>
        <button class="btn btn-lg btn-primary btn-block" type="submit" name="portemp" value="inicio">Sign in</button>
      </form>
    </div> <!-- /container -->
    <div class="container">
      <div class="mensaje">
          <c:if test="${mensaje=="contraseña"}">
            <h4>La contraseña está mal</h4>
          </c:if>
          <c:if test="${mensaje=="usuario"}">
            <h4>No se encuentra este usuario. Posiblemente está mal escrito.</h4>
          </c:if>
      </div>
    </div>
    
    <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
  </body>
</html>
