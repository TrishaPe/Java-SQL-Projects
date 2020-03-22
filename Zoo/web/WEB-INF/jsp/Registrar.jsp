<%-- 
    Document   : Registrar
    Created on : Nov 5, 2019, 11:08:30 AM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar</title>
        <style>
            html, body {
              height: 100%;
              margin: 0;
            }
            
            .wrapper {
              min-height: 100%;

              /* Equal to height of footer */
              /* But also accounting for potential margin-bottom of last child */
              margin-bottom: -50px;
            }
            
            .footer,
            .push {
              height: 50px;
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <c:choose><%--Si ya estamos logueados, pintamos eso--%>
                <c:when test="${sessionScope.cliente!=null}">
                    Ya estás logueado. Solo aceptamos una cuenta por persona.
                </c:when>
                <c:otherwise><%--Si no hay cliente logueado, pedimos datos para registrar uno--%>
                    <form action="registrar.htm">
                        <label>Nombre: </label><input type="text" name="txtNombre" required/><br/>
                        <label>Apellidos: </label><input type="text" name="txtApe" required/><br/>
                        <label>Correo: </label><input type="text" name="txtCorreo" required/><br/>
                        <label>Usuario: </label><input type="text" name="txtUsuario" required/><br/>
                        <label>Contraseña: </label><input type="text" name="txtCont1" required/><br/>
                        <label>Confirme contraseña: </label><input type="text" name="txtCont2" required/><br/>
                        <input type="checkbox" name="chkNews" value="1"/><label>Quiero recibir mensualmente el correo de las noticias del Zoo.</label><br/>
                        <button type="submit">Registrar</button>
                    </form>

                    <c:choose><%--Si ya existe cliente sin perfil, añadimos usuario y contraseña; si ya existe con usuario, decimos que el perfil ya existe.
                        Cuando no existe nada en la base de datos, creamos un perfil completo.--%>
                        <c:when test="${resultado=="existe"}">
                            perfil completo ya existe (correo, nombre, apellidos). Has olvidado tu usuario y contraseña?
                        </c:when>
                        <c:when test="${resultado=="error"}">
                            hubo un error al insertar
                        </c:when>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <a href="index.htm">Inicio</a>
            <div class="push"></div>
        </div>
        <footer class="footer">
            Nunca es necesario imprimir los tickets. Con solamente tener el billete que te enviamos por correo en la pantalla del móvil, estás dentro.
        </footer>
    </body>
</html>
