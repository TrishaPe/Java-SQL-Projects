<%-- 
    Document   : PortCliente
    Created on : Nov 7, 2019, 12:07:42 AM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <title>Portal cliente</title>
    </head>
    <body>
        <jsp:include page="plantillas/header.jsp"/>
        <div>
        <c:choose><%--controlamos contraseña y usuario. Si todo está bien, guardamos objeto Cliente en sesion.--%>
            <c:when test="${usuario=='mal'}"><!--En el Repo controlamos primero el usuario. Cuando no se reconoce, salta este mensaje con opcion a registrar-->
                <h3>El usuario está mal o no tienes cuenta.</h3>
                <form action="base.htm">
                    <button type="submit" name="pagina" value="registrar">Registrar</button>
                </form>
            </c:when>
            <c:when test="${contraseña=='mal'}"><!--Después se controla la contraseña, que aqui está equivocada-->
                <h3>La contraseña está mal.</h3>
            </c:when>
            <c:otherwise><!--Si ambos están bien, pintamos los datos de cliente y damos opciones modificar, ver abono, y borrar cuenta-->
                <c:choose>
                    <c:when test="${not empty cliente}">
                        <div>
                            Nombre: <c:out value="${cliente.nombre}"/><br/>
                            Apellidos: <c:out value="${cliente.apellidos}"/><br/>
                            Correo electrónico: <c:out value="${cliente.correo}"/><br/>
                            Nombre de usuario: <c:out value="${cliente.usuario}"/><br/>
                        </div>

                        <div>
                            <form action="cliente.htm">
                                <button type="submit" name="caccion" value="anteModificar">Modificar datos</button>
                                <button type="submit" name="caccion" value="abono">Ver abono</button>
                                <button type="submit" name="caccion" value="borrar">Borrar cuenta</button><%--Convierte usuario y contraseña en nulos--%>
                            </form>
                        </div>

                        <c:if test="${seleccion eq 'modificar'}"><!-- Modificar -->
                        <div>

                            Modificar datos personales:
                            <form action="cliente.htm">
                                Nombre: <input type="text" name="txtNombre" value="${cliente.nombre}"/><br/>
                                Apellidos: <input type="text" name="txtApe" value="${cliente.apellidos}"/><br/>
                                Correo electrónico: <input type="text" name="txtCorreo" value="${cliente.correo}"/><br/>
                                Nombre de usuario: <input type="text" name="txtUsuario" value="${cliente.usuario}"/><br/>
                                Contraseña: <input type="text" name="txtContraseña" required/><br/>
                                <button type="submit" name="caccion" value="modificar">Modificar</button>
                            </form>
                            <c:if test="${modif=='exito'}"><h3 color="blue">Cambio realizado.</h3></c:if>
                            <c:if test="${modif=='equivocado'}"><h3 color="red">La contraseña no es justa.</h3></c:if>
                            <c:if test="${modif=='error'}"><h3 color="red">Algo está mal. El cambio no se puede realizar.</h3></c:if>

                            Modificar contraseña:
                            <form action="cliente.htm">
                                Contraseña actual: <input type="text" name="txtContraseña" required/><br/>
                                Contraseña nueva: <input type="text" name="txtCont1" required/><br/>
                                Confirme contraseña: <input type="text" name="txtCont2" required/><br/>
                                <button type="submit" name="caccion" value="contModificar">Modificar</button>
                            </form>
                            <c:if test="${contmodif=='exito'}"><h3 color="blue">Cambio realizado.</h3></c:if>
                            <c:if test="${contmodif=='equivocado'}"><h3 color="red">La contraseña no es justa.</h3></c:if>
                            <c:if test="${contmodif=='desigual'}"><h3 color="red">La contraseñas no son iguales.</h3></c:if>
                        </div></c:if>


                        <c:if test="${seleccion=='abono'}"><!-- Abono -->
                            <div>
                                <c:choose>
                                    <c:when test="${abono=='vacio'}">
                                        <h3>No tienes abono activo.</h3>
                                        <form action="comprabono.htm?comprar=inicio">
                                            <button type="submit">Comprar billetes o abono</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        Tipo de abono: <c:out value="${abono.abono}"/><br/>
                                        Fecha de inicio: <c:out value="${abono.fechain}"/><br/>
                                        Fecha de caducidad: <c:out value="${abono.fechafin}"/><br/>
                                    </c:otherwise>
                                </c:choose> 
                            </div>
                        </c:if>

                        <c:if test="${seleccion=='borrar'}"><!-- Borrar -->
                            <div>
                                <h3>Seguro que quieres borrar tu perfil?</h3>
                                <h4>
                                    Aviso: guardaremos tus datos por si tienes abono, o por si en algún momento pides uno.
                                    Si vuelves a crear un perfil nuevo, lo volveremos a conectar con los datos que ya tenemos, incluído el abono que tengas.
                                    No compartimos tus datos con nadie; los guardamos por tu comodidad. Pero si quieres que los borremos
                                    de nuestro sistema, envía un correo a GDPR@zoocity.es.
                                </h4>
                                <form action="cliente.htm">
                                    Contraseña: <input type="text" name="txtContraseña" required/><br/>
                                    <button type="submit" name="caccion" value="cBorrar">Borrar</button>
                                </form>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <h3>Lo sentimos, no encontramos tus datos.</h3>
                        <p>Si todavía no tienes cuenta, regístrate para poder acceder al portal de clientes.</p>
                        <p>En caso de que sí tienes cuenta, reintenta el logueo, y si el problema persiste, contacta el correo x o telefono y</p>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
        </div>
        <a href="index.htm">Inicio</a>
    </body>
</html>
