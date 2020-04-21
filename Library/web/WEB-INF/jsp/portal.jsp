<%-- 
    Document   : portal
    Created on : Mar 23, 2020, 5:28:40 PM
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
        <c:choose>
            <c:when test="${error=='pass'}">
                <h1>password error</h1>
            </c:when>
            <c:when test="${error=='name'}">
                <h1>username error</h1>
            </c:when>
            <c:when test="${user.type=='faculty' || user.type=='student'}">
                <h1>User portal</h1>
                FACULTY/STUDENTS<br>
                -view of books they have borrowed, button to extend once (will be inactive after that)
            </c:when>
            <c:otherwise>
                <h1>User portal</h1>
                STAFF<br>
                -view of all books that have been borrowed<br>
                
                <table>
                    <tr><th>Book code</th><th>Person type</th><th>Borrowdate</th><th>Returndate</th><th>Fine</th></tr>
                    <c:forEach items="${borrows}" var="borrow">
                        <tr><td>${borrow.bookcode}</td><td>${borrow.persontype}</td><td>${borrow.outdate}</td><td>${borrow.indate}</td><td>${borrow.fine}</td></tr>
                    </c:forEach>
                </table>
                
                <ul>
                    <li>button to view late books and fines, send letters to borrowers</li>
                    <li>option to label a book as requested by person x (so said person will be notified when it is brought in and book won't be leased to anyone else).</li>
                    <li>Book checkout, book checkin (this automatically shows incurred fines). Automatic notice if checked-in book is requested.</li>
                    <li>Manage books (add, delete, add notes)</li>
                </ul>
            </c:otherwise>
        </c:choose>
        
        <div>
            <input list="countries" type="text"/>
            <datalist id="countries"><%--fill with all book titles for add book--%>
                <option value="Belgium"/>
                <option value="France"/>
                <option value="Germany"/>
                <option value="Spain"/>
            </datalist>
        </div>
        
    </body>
</html>
