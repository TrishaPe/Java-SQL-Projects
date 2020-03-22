<%-- 
    Document   : AnimalDatos
    Created on : Dec 10, 2019, 3:35:13 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <title>Datos Animal</title>
        
        <style>
            td, th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px;
            }
            
            img{
                width: 300px;
            }
            
            label{
                min-width:100px;
            }
            
            input[type=file] {
                display: inline;
            }
        </style>
    </head>
    <body>
        <jsp:include page="plantillas/header2.jsp"/>
        <c:choose>
            <c:when test="${tipo=="añadir"}">
              <div class="container">
                <h1>Añadir animal nuevo</h1>
                <form action="animaldatos.htm">
                    <label>Especie: </label><input type="text" name="especie" required/><br/>
                    <label>Nombre: </label><input type="text" name="nombre"required/><br/>
                    <label>Sexo: </label><input type="text" name="sexo"required/><br/>
                    <label>Dieta: </label><input type="text" name="dieta" required/><br/>
                    <label>Departamento: </label>
                    <select name="dept" required>
                        <c:forEach items="${departamentos}" var="dept">
                            <option value="${dept.codigo}">${dept.nombre}</option>
                        </c:forEach>
                    </select><br/>
                    <label>Empleado: </label>
                    <select name="empleado" required>
                        <c:forEach items="${empleados}" var="emp">
                            <option value="${emp}">${emp}</option>
                        </c:forEach>
                    </select><br/>
                    <label>Foto: </label><input type="file" name="foto" accept="image/*" required><br/>
                    <label style="vertical-align:top;">Comentarios: </label><textarea name="comentario" rows="5" cols="20" maxlength="50"></textarea><br/>
                    <button type="submit" name="adatos" value="añadir">Añadir</button>
                </form>
                <c:if test="${resultado==1}">
                    Añadido correctamente
                </c:if>
                <c:if test="${resultado==0}">
                    Error
                </c:if>
              </div>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${empleado.dept_cod==1||empleado.funcion=="gestor"}">
                        <div class="container">
                            <h1>Datos animal ${animal.nombre}</h1>
                            <table> <%--OJO hay que añadir citas!--%>
                                <tr><td  rowspan="7"><img src="images/${animal.foto}"/></td><td>Nombre: ${animal.nombre}</td></tr>
                                <tr><td>Especie: ${animal.especie}</td></tr>
                                <tr><td>Sexo: ${animal.sexo}</td></tr>
                                <tr><td>Empleado: ${animal.emp_cod}</td></tr>
                                <tr><td>Citas: ${animal.dieta}</td></tr>
                                <tr><td>Notas: ${animal.notas}</td></tr>
                                <tr>
                                    <td>
                                        <form action="animaldatos.htm">
                                            Comentario nuevo:<br/>
                                            <textarea name="comentario" rows="5" cols="20" maxlength="50" required></textarea><br/>
                                            <button type="submit" name="adatos" value="comentario">Guardar</button><br/>
                                        </form>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="container">
                            <h1>Datos animal ${animal.nombre}</h1>
                            <table> <%--OJO hay que añadir citas!--%>
                                <tr><td  rowspan="5"><img src="images/${animal.foto}"/></td><td>Nombre: ${animal.nombre}</td></tr>
                                <tr><td>Especie: ${animal.especie}</td></tr>
                                <tr><td>Sexo: ${animal.sexo}</td></tr>
                                <tr><td>Notas: ${animal.notas}</td></tr>
                                <tr>
                                    <td>
                                        <form action="animaldatos.htm">
                                            Comentario nuevo:<br/>
                                            <textarea name="comentario" rows="5" cols="20" maxlength="50" required></textarea><br/>
                                            <button type="submit" name="adatos" value="comentario">Guardar</button><br/>
                                        </form>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <div class="container">
                    <form action="animaldatos.htm">
                        <button type="submit" name="adatos" value="citas">Citas</button>
                        <button type="submit" name="adatos" value="notas">Notas</button>
                    </form>
                </div>
                
                <c:if test="${opcion.equals("citas")}">
                    <div class="container">
                        <c:choose>
                            <c:when test="${futura!=null}">
                                <h3>Citas en el futuro: </h3>
                                ${futura}
                                <br/>
                                <form action="animaldatos.htm">
                                    <h4>Para cerrar la cita, anota las conclusiones del veterinario:</h4><br/>
                                    <textarea name="respuesta" rows="5" cols="20" maxlength="50" required></textarea><br/>
                                    <button type="submit" name="adatos" value="cerrarcita">Cerrar cita</button>
                                </form>
                                <h3>Citas anteriores: </h3>
                                <table border="1">
                                    <tr><th>Fecha</th><th>Notas</th></tr>
                                    <c:forEach items="${pasadas}" var="cita">
                                        <tr><td>${cita.fecha}</td><td>${cita.notas}</td></tr>
                                    </c:forEach>
                                </table>
                                <br/>
                            </c:when>
                            <c:otherwise>
                                <h3>Citas en el futuro: </h3>
                                  <h4>No hay citas</h4>
                                <br/>
                                <h3>Citas anteriores: </h3>
                                  <table border="1">
                                    <tr><th>Fecha</th><th>Notas</th></tr>
                                    <c:forEach items="${pasadas}" var="cita">
                                        <tr><td>${cita.fecha}</td><td>${cita.notas}</td></tr>
                                    </c:forEach>
                                  </table>
                                <br/>
                                <form action="animaldatos.htm">
                                    <h4>Si quieres pedir una cita nueva, anota las síntomas:</h4><br/>
                                    <textarea name="notas" rows="5" cols="20" maxlength="50" required></textarea><br/>
                                    <button type="submit" name="adatos" value="pedircita">Pedir cita</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <c:if test="${opcion.equals("pedircita")}">
                    <div class="container">
                        <c:choose><c:when test="${resultado==1}">
                            <h3>Petición enviada</h3>
                        </c:when> 
                        <c:otherwise>
                            <h3>Error</h3>
                        </c:otherwise></c:choose>
                    </div>
                </c:if>

                <c:if test="${opcion.equals("notas")}">
                    <div class="container">
                    <h3>Notas anteriores: </h3>
                        <table border="1">
                            <tr><th>Fecha</th><th>Notas</th></tr>
                            <c:forEach items="${notas}" var="nota">
                                <tr><td>${nota.fecha}</td><td>${nota.notas}</td></tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
        <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
    </body>
</html>