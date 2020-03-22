<%-- 
    Document   : Abonos
    Created on : Nov 5, 2019, 10:22:58 AM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="plantillas/Bootstrap_head.jsp"/>
        <title>Entradas</title>
    </head>
    <body>
        <jsp:include page="plantillas/header.jsp"/>

        <div class="container">
        <h1>Tipos de abonos disponibles</h1>
        <div>
            <h4>Adulto: 1 persona mayor a 12 años</h4>
            €21,45
        </div>
        <div>
            <h4>Niño: 1 persona hasta 12 años</h4>
            €18,25
        </div>
        <div>
            <h4>Ositos 1/2: 2 adultos y 2 niños hasta 12 años. Acceso durantes 6 meses.</h4>
            €139,49
        </div>
        <div>
            <h4>Ositos completo: 2 adultos y 2 niños hasta 12 años. Acceso durantes 12 meses.</h4>
            €275,75
        </div>
        <div>
            <h4>Buhitos 1/2: 2 adultos y hasta 6 niños hasta 12 años. Acceso durantes 6 meses.</h4>
            €219,45
        </div>
        <div>
            <h4>Ositos completo: 2 adultos y hasta 6 niños hasta 12 años. Acceso durantes 12 meses.</h4>
            €445,75
        </div>
        </div>
        <br/>
        
        <div class="container">
        <p> Olvídate de la cola! <a href="comprabono.htm?comprar=inicio">Compra tus entradas aquí</a></p>
        
        <a href="index.htm">Inicio</a>
        </div>
    </body>
</html>
