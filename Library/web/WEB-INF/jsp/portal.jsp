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
        <script>
            function BookCodeFilter() {
              // Declare variables
              var td, i, txtValue;
              var input = document.getElementById("BookInput");
              var filter = input.value.toUpperCase();
              var table = document.getElementById("BorrowedTable");
              var tr = table.getElementsByTagName("tr");

              // Loop through all table rows, and hide those that don't match the search query
              for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                  txtValue = td.textContent || td.innerText;
                  if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                  } else {
                    tr[i].style.display = "none";
                  }
                }
              }
            }
            
            function PersonFilter() {
              // Declare variables
              var td, i, txtValue;
              var input = document.getElementById("PersonInput");
              var filter = input.value.toUpperCase();
              var table = document.getElementById("BorrowedTable");
              var tr = table.getElementsByTagName("tr");

              // Loop through all table rows, and hide those that don't match the search query
              for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[1];
                if (td) {
                  txtValue = td.textContent || td.innerText;
                  if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                  } else {
                    tr[i].style.display = "none";
                  }
                }
              }
            }
            
            function ReturnDateFilter() {
              // Declare variables
              var i, txtValue;
              var filter = document.getElementById("LateInput").checked;
              var table = document.getElementById("BorrowedTable");
              var tr = table.getElementsByTagName("tr");

              // Loop through all table rows, and hide those that don't match the search query
              if (filter==true){
                  for (i = 1; i < tr.length; i++) {
                    //turn return date into Date object
                    var date = tr[i].getElementsByTagName("td")[3].innerText;
                    var year = date.split("-")[0];
                    var month = date.split("-")[1];
                    var day = date.split("-")[2];
                    var rdate=new Date(year, month-1, day, 0, 0, 0);
                    //Get today's date
                    var now=new Date();
                    
                    if (now>rdate){
                        tr[i].style.display = "";
                    }else{
                        tr[i].style.display = "none";
                    }
                  }
                }else{
                    for (i = 1; i < tr.length; i++) {
                      tr[i].style.display = "";
                  }
                }
              }
            
            
            function sortTable(n) {
              var shouldSwitch, switchcount = 0;
              var table = document.getElementById("BorrowedTable");
              var switching = true;
              // Set the sorting direction to ascending:
              var dir = "asc";
              /* Make a loop that will continue until no switching has been done: */
              while (switching) {
                // Start by saying: no switching is done:
                switching = false;
                var rows = table.rows;
                /* Loop through all table rows (except the first, which contains table headers): */
                var i;
                for (i = 1; i < (rows.length - 1); i++) {
                  // Start by saying there should be no switching:
                  shouldSwitch = false;
                  /* Get the two elements you want to compare, one from current row and one from the next: */
                  var x = rows[i].getElementsByTagName("TD")[n];
                  var y = rows[i + 1].getElementsByTagName("TD")[n];
                  /* Check if the two rows should switch place, based on the direction, asc or desc: */
                  if (dir == "asc") {
                    if (isNaN(x.innerHTML)){
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                          // If so, mark as a switch and break the loop:
                          shouldSwitch = true;
                          break;
                        }
                    }else{
                        if (Number(x.innerHTML) > Number(y.innerHTML)) {
                          shouldSwitch = true;
                          break;
                        }
                    }
                  } else if (dir == "desc") {
                    if (isNaN(x.innerHTML)){
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                          // If so, mark as a switch and break the loop:
                          shouldSwitch = true;
                          break;
                        }
                    }else{
                        if (Number(x.innerHTML) < Number(y.innerHTML)) {
                          shouldSwitch = true;
                          break;
                        }
                    }
                  }
                }
                if (shouldSwitch) {
                  /* If a switch has been marked, make the switch and mark that a switch has been done: */
                  rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                  switching = true;
                  // Each time a switch is done, increase this count by 1:
                  switchcount ++;
                } else {
                  /* If no switching has been done AND the direction is "asc", set the direction to "desc" and run the while loop again. */
                  if (switchcount == 0 && dir == "asc") {
                    dir = "desc";
                    switching = true;
                  }
                }
              }
            }
        </script>
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
                
                <p>Note: in real life, books would be scanned. Inputting the book code is the most feasible option in this case.</p>
                <label>Search by book code:</label><br>
                <input type="text" id="BookInput" onkeyup="BookCodeFilter()"><br>
                <label>Search by person type:</label><br>
                <input type="text" id="PersonInput" onkeyup="PersonFilter()"><br>
                <label>Search late books:</label><br>
                <input type="checkbox" id="LateInput" onchange="ReturnDateFilter()"><br>
                
                <table id="BorrowedTable">
                    <tr>
                        <th onclick="sortTable(0)">Book code</th>
                        <th onclick="sortTable(1)">Person type</th>
                        <th onclick="sortTable(2)">Borrowdate</th>
                        <th onclick="sortTable(3)">Returndate</th>
                        <th onclick="sortTable(4)">Fine</th>
                    </tr>
                    <c:forEach items="${borrows}" var="borrow">
                        <tr>
                            <td>${borrow.bookcode}</td>
                            <td>${borrow.persontype}</td>
                            <td>${borrow.outdate}</td>
                            <td>${borrow.indate}</td>
                            <td>${borrow.fine}</td>
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
