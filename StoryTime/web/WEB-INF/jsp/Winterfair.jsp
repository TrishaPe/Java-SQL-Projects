<%-- 
    Document   : Winterfair
    Created on : Jul 25, 2020, 7:08:17 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Winter Fair story</h1>
        
        <div>
            ${paragraph[2]}<br/>
        </div>
        
        <div>
            <c:forEach items="${choices}" var="choice">
                ${choice.option} = ${choice.target}<br/>
            </c:forEach>
        </div>
        
    </body>
</html>
