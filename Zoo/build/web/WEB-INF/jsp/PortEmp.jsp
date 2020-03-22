<%-- 
    Document   : PortEmp
    Created on : Dec 1, 2019, 8:53:24 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <title>Portal Empleado</title>
        <style>
            .veterinario, .vacaciones, .ordenes, .peticionvac{
                border: 1px solid black;
                width: 60%;
                padding: 10px;
            }
            
            td, th{
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="plantillas/header2.jsp"/>
        <div class="container">
            <h4>Buenos días ${empleado.nombre}</h4>
        </div>

        <div class="container">
            <c:if test="${empleado.dept_cod==1}">
            <div class="veterinario"><%--peticiones de veterinario--%>
                <h4>Peticiones citas de veterinario</h4>
                <form>
                    <table>
                        <thead>
                            <tr>
                                <th>Codigo Animal</th>
                                <th>Especie</th>
                                <th>Síntomas</th>
                                <th>Selección</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${citas}" var="cita">
                                <tr>
                                    <td>${cita.animal_cod}</td>
                                    <td>${cita.especie}</td>
                                    <td>${cita.notas}</td>
                                    <td><input type="checkbox" name="animales" value="${cita.animal_cod}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <input type="date" name="fecha" required/>
                    <button type="submit" name="portemp" value="confirmcita">Enviar</button>
                </form>
                <c:if test="${resultadocita>0}">
                    <h4>Cita guardada</h4>
                </c:if>
                <c:if test="${resultadocita==0}">
                    <h4>Error</h4>
                </c:if>
            </div>
            </c:if>
            
            <br/>
            
            <c:if test="${empleado.dept_cod==1||empleado.funcion=="gestor"}">
            <div class="vacaciones"><%--peticiones de vacaciones--%>
                <h4>Peticiones de vacaciones</h4>
                <c:choose>
                    <c:when test="${not empty vacaciones}">
                        <c:choose>
                            <c:when test="${empleado.dept_cod==1}"><%--empleado es de administración--%>
                                <form>
                                    <table class="vactable">
                                        <thead>
                                            <tr>
                                                <th>Fecha inicio</th>
                                                <th>Fecha fin</th>
                                                <th>Empleado</th>
                                                <th>Aprobado</th>
                                                <th>Enviar</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${vacaciones}" var="vac">
                                                <tr>
                                                    <td><input type="date" name="inicio" value="${vac.fecha_in}"/></td>
                                                    <td><input type="date" name="final" value="${vac.fecha_fin}"/></td>
                                                    <td>${vac.emp_cod}</td><input type="hidden" name="empleado" value="${vac.emp_cod}"/>
                                                    <td>
                                                        <label>Si</label><input type="radio" name="aprobado" value="1"/>
                                                        <label>No</label><input type="radio" name="aprobado" value="0"/>
                                                    </td>
                                                    <td>
                                                        <button type="submit" name="portemp" value="confirmvac">Enviar</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </form>
                            </c:when>
                            <c:otherwise><%--empleado es gestor de dept--%>
                                <form>
                                    <table class="vactable">
                                        <thead>
                                            <tr>
                                                <th>Fecha inicio</th>
                                                <th>Fecha fin</th>
                                                <th>Empleado</th>
                                                <th>Aprobado</th>
                                                <th>Enviar</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${vacaciones}" var="vac">
                                                <c:if test="${vac.dept_cod==empleado.dept_cod}">
                                                    <tr>
                                                        <td><input type="date" name="inicio" value="${vac.fecha_in}"/></td>
                                                        <td><input type="date" name="final" value="${vac.fecha_fin}"/></td>
                                                        <td>${vac.emp_cod}</td><input type="hidden" name="empleado" value="${vac.emp_cod}"/>
                                                        <td>
                                                            <label>Si</label><input type="radio" name="aprobado" value="1"/>
                                                            <label>No</label><input type="radio" name="aprobado" value="0"/>
                                                        </td>
                                                        <td>
                                                            <button type="submit" name="portemp" value="confirmvac">Enviar</button>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <h4>No hay peticiones ahora</h4>
                    </c:otherwise>
                </c:choose> 
                <c:if test="${resultadovac>0}">
                    <h4>Enviado</h4>
                </c:if>
                <c:if test="${resultadovac==0}">
                    <h4>Error</h4>
                </c:if>
            </div>
            </c:if>
            
            <br/>
            
            <c:if test="${empleado.funcion=="CFO"}">
            <div class="ordenes"><%--peticiones de ordenes--%>
                <h4>Peticiones de materiales</h4>
                <c:choose>
                    <c:when test="${not empty ordenes}">
                        <form>
                            <div class="datatabla">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Departamento</th>
                                            <th>Contenido</th>
                                            <th>Selección</th>
                                            <th>Listo</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${ordenes}" var="pet">
                                            <tr>
                                                <td>${pet.dept_cod}</td>
                                                <td>${pet.contenido}</td>
                                                <td><input type="checkbox" name="peticion" value="${pet.peticion_cod}"</td>
                                                <td><input type="checkbox" name="listo" value="${pet.peticion_cod}"</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="divorden">
                                <label>Pedido</label><br/>
                                <textarea rows="5" cols="25" name="txtcontenido" required></textarea><br/>
                                <label>Proveedor: </label>
                                <select name="cmbprov" required>
                                    <c:forEach items="${proveedores}" var="prov">
                                        <option value="${prov.codigo}">${prov.nombre}</option>
                                    </c:forEach>
                                </select><br/>
                                <label>Precio: </label>
                                <input type="number" name="txtprecio" required/>
                                <label>Fecha: </label>
                                <input type="date" name="txtfecha" required/>
                                <button type="submit" name="portemp" value="confirmpet">Guardar</button>
                            </div>
                        </form>
                        <c:if test="${resultadopet>0}">
                            <h4>Pedido guardado</h4>
                        </c:if>
                        <c:if test="${resultadopet==0}">
                            <h4>Error</h4>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <h4>No hay peticiones ahora</h4>
                    </c:otherwise>
                </c:choose>
            </div>
            </c:if>
        </div>
        
        <br>        
        
        <div class="container">
            <div class="peticionvac"><%--pedir vacaciones--%>
                <form action="portemp.htm">
                    Pedir vacaciones:<br/>
                    Fecha de inicio: <input type="date" name="fecha_in" required/><br/>
                    Fecha de fin <input type="date" name="fecha_fin" required/><br/>
                    Tipo: 
                    <select name="cmbtipo" required>
                        <option>vacaciones</option>
                        <option>nacimiento</option>
                        <option>fallecimiento</option>
                        <option>matrimonio</option>
                        <option>mudanza</option>
                        <option>enfermedad</option>
                    </select><br/>
                    <button type="submit" name="portemp" value="pedirvacaciones">Enviar</button>
                </form>

                <c:if test="${resultadopedvac>0}">
                    <h4>Petición enviado</h4>
                </c:if>
                <c:if test="${resultadopedvac==0}">
                    <h4>Error</h4>
                </c:if>
            </div>
        </div>
        <%--<script scr="js/Calendar.js"></script>--%>
      <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
      <footer class="pt-4 my-md-5 pt-md-5 border-top">
          <br/>
      </footer>
    </body>
</html>
