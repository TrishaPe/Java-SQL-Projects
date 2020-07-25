<%-- 
    Document   : booklist
    Created on : Apr 2, 2020, 8:44:42 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of books</title>
    </head>
    <body>
        <h1></h1>
        
        <table>
            <thead>
                <tr><th>Book title</th><th>Author</th><th>Present</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${books}" var="book">
                    <tr>
                        <td>${book.title}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
