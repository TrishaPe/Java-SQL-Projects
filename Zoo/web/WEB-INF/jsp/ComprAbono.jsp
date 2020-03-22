<%-- 
    Document   : ComprAbono
    Created on : Dec 31, 2019, 2:06:05 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comprar billetes</title>
        <style>
            th, td{
                padding: 5px;
            }
        </style>
        <script src="js/jquery-3.4.1.min.js" type="text/javascript"></script>
        <script>
            $(document).ready(function(){
                $("input").change(function(){
                    var nombre=$(this).attr("id");
                    var cantidad=parseInt($(this).val());
                    var html="";
                    if (nombre==="txt_1"){
                        $("#carrito tr").each(function(){
                            if ($(this).text().indexOf("adulto") > -1){
                                $(this).replaceWith("<tr><td>"+($("#abono_1").text())+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_1").text())*cantidad)+"</td></tr>");
                            }
                        });
                        if ($("#carrito").text().indexOf("adulto") === -1){
                                html+="<tr><td>"+$("#abono_1").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_1").text())*cantidad)+"</td></tr>";
                            $("#carrito").append(html);
                        }
                    }else if (nombre==="txt_2"){
                        $("#carrito tr").each(function(){
                            if ($(this).text().indexOf("niño") > -1){
                                $(this).replaceWith("<tr><td>"+$("#abono_2").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_2").text())*cantidad)+"</td></tr>");
                            }
                        });
                        if ($("#carrito").text().indexOf("niño") === -1){
                                html+="<tr><td>"+$("#abono_2").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_2").text())*cantidad)+"</td></tr>";
                            $("#carrito").append(html);
                        }
                    }else if (nombre==="txt_3"){
                        $("#carrito tr").each(function(){
                            if ($(this).text().indexOf("ositos 1/2") > -1){
                                $(this).replaceWith("<tr><td>"+$("#abono_3").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_3").text())*cantidad)+"</td></tr>");
                            }
                        });
                        if ($("#carrito").text().indexOf("ositos 1/2") === -1){
                                html+="<tr><td>"+$("#abono_3").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_3").text())*cantidad)+"</td></tr>";
                            $("#carrito").append(html);
                        }
                    }else if (nombre==="txt_4"){
                        $("#carrito tr").each(function(){
                            if ($(this).text().indexOf("ositos completo") > -1){
                                $(this).replaceWith("<tr><td>"+$("#abono_4").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_4").text())*cantidad)+"</td></tr>");
                            }
                        });
                        if ($("#carrito").text().indexOf("ositos completo") === -1){
                                html+="<tr><td>"+$("#abono_4").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_4").text())*cantidad)+"</td></tr>";
                            $("#carrito").append(html);
                        }
                    }else if (nombre==="txt_5"){
                        $("#carrito tr").each(function(){
                            if ($(this).text().indexOf("buhitos 1/2") > -1){
                                $(this).replaceWith("<tr><td>"+$("#abono_5").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_5").text())*cantidad)+"</td></tr>");
                            }
                        });
                        if ($("#carrito").text().indexOf("buhitos 1/2") === -1){
                                html+="<tr><td>"+$("#abono_5").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_5").text())*cantidad)+"</td></tr>";
                            $("#carrito").append(html);
                        }
                    }else{
                        $("#carrito tr").each(function(){
                            if ($(this).text().indexOf("buhitos completo") > -1){
                                $(this).replaceWith("<tr><td>"+$("#abono_6").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_6").text())*cantidad)+"</td></tr>");
                            }
                        });
                        if ($("#carrito").text().indexOf("buhitos completo") === -1){
                                html+="<tr><td>"+$("#abono_6").text()+"</td><td>"+cantidad+"</td><td>"+(parseInt($("#precio_6").text())*cantidad)+"</td></tr>";
                            $("#carrito").append(html);
                        }
                    }
                });
            });
        </script>
    </head>
    <body>
        <jsp:include page="plantillas/header.jsp"/>
        <form action="comprabono.htm">
            <div class="container">
                <h1>Billetes y abonos</h1>
                <table>
                    <thead><tr><th>Nombre</th><th>Definición</th><th>Precio</th><th>Selección</th></tr></thead>
                    <tbody>
                        <c:forEach items="${abonos}" var="ab">
                            <tr>
                                <td id="abono_${ab.codigo}">${ab.abono}</td>
                                <td id="tipo_${ab.codigo}">${ab.tipo}</td>
                                <td id="precio_${ab.codigo}">${ab.precio}</td>
                                <td>
                                    <input type="number" name="cantidad_${ab.codigo}" id="txt_${ab.codigo}" min="0"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <br/>
            
            <div class="container">
                <table><thead><tr><th>Tipo</th><th>Cantidad</th><th>Precio</th></tr></thead>
                    <tbody id="carrito">
                    </tbody>
                </table>
                <button type="submit" name="comprar" value="comprar">Comprar</button>
            </div>
        </form>
        <br/>
        
        <div class="container">
            <c:if test="${resultado==1}">
                Compra correcta
            </c:if>
            <c:if test="${resultado<1}">
                Error
            </c:if>
        </div>
        <br/>
        
        <div class="container">
            <a href="index.htm">Volver</a>
        </div>
        
        <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
    </body>
</html>
