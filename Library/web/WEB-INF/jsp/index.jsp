<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Spring Web MVC project</title>
    </head>

    <body>
    <header>
        <form action="portal.htm">
            <label>Username:</label><input type="text" name="txtUser"/>
            <label>Password:</label><input type="password" name="txtPass"/>
            <button type="submit" value="submit">Login</button>
        </form>
    </header>

    </head>
        <h2>Welcome to the library of Springfield</h2>
        <div>
            Login: can login with username and password and will be directed to one of three possible portals.
            Portals: staff, student or faculty (one page). Student and faculty will be functionally the same (and thus will be
            the same page) but will have different amounts of time to borrow books, different limits on number of
            books available to borrow. Differences between what staff and students/faculty can see: everyone can see
            that a book has been borrowed and when it should be returned but only staff can see who borrowed a book
            someone else borrowed.
        </div>
        <div>
            <ul>
                <li><a href="booklist.htm">List of books</a></li>
                <li>Events</li>
            </ul>
        </div>

        
        
        
        
    </body>
</html>
