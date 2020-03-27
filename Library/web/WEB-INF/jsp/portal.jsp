<%-- 
    Document   : portal
    Created on : Mar 23, 2020, 5:28:40 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Portal de usuario</h1>
        
        STAFF
        -view of all books that have been borrowed
        --> button to view late books and fines, send letters to borrowers
        --> option to label a book as requested by person x (so said person will be notified when it is brought in and book won't be leased to anyone else).
        --> Book checkout, book checkin (this automatically shows incurred fines). Automatic notice if checked-in book is requested.
        --> Manage books (add, delete, add notes)
        
        FACULTY/STUDENTS
        -view of books they have borrowed, button to extend once (will be inactive after that)
        
        
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
