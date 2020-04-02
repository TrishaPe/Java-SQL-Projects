package repositories;

import java.sql.*;
import java.util.*;
import models.Book;
import models.Borrow;
import models.Person;

public class RepoPortal {
    Connection cn;

    public RepoPortal() throws SQLException{
        //Create database connection
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        this.cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
    }
    
    public Person login(String username, String password) throws SQLException{
        Connection cnx = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
        PreparedStatement sentenciax=cnx.prepareStatement("select username from person where username=?");
        sentenciax.setString(1, password);
        ResultSet resx=sentenciax.executeQuery();

        Person person=new Person();
        if (resx.next()){
            cnx.close();
            PreparedStatement sentencia=cn.prepareStatement("select * from person where username=? and pass=?");
            sentencia.setString(1, username);
            sentencia.setString(2, password);
            ResultSet res=sentencia.executeQuery();
            if (res.next()){
                person.setCode(res.getInt("person_cod"));
                person.setName(res.getString("pname"));
                person.setType(res.getString("type"));
                person.setAddress(res.getString("address"));
                return person;
            }else{
                cnx.close();
                person.setName("error");
            }
        }else{
            cnx.close();
            person.setName("naught");
        }
        return person;
        
    }
    
    private Book setBook(Book book, ResultSet res) throws SQLException{
        //set most of the attributes of the Book object (genre will be arranged separately)
        book.setBookcode(res.getInt("book_cod"));
        book.setIsbn(res.getString("isbn"));
        book.setTitle(res.getString("title"));
        book.setAutcode(res.getInt("author_cod"));
        book.setAutname(res.getString("name"));
        book.setNotes(res.getString("notes"));
        return book;
    }
    
    private ArrayList<Book> deleteExtra(ArrayList<Book> books){
        //Deleting the first instance of a book with multiple genres - that is, the one that hasn't had the second genre
        //concatenated with the first one and thus only has one genre.
        Collections.reverse(books);
        int code2=0;
        
        ArrayList<Book> toRemove = new ArrayList();
 
        for (Book book:books){
            if (book.getBookcode()==code2){
                toRemove.add(book);
                continue;
            }
            code2=book.getBookcode();
        }
        books.removeAll(toRemove);
        
        //Another Collections.reverse could be done here to get books back in Primary Key order, but JSP page will
        //order by title or author.
        return books;
    }
    
    public ArrayList<Book> getAllBooks() throws SQLException{
        ArrayList<Book> books=new ArrayList();
        //get all books from database, put into ArrayList as Book objects
        Statement sentencia=cn.createStatement();
        String booksql="select books.book_cod, books.isbn, books.title, books.author_cod, authors.name, books.notes, bookgenre.genre from books join authors on books.author_cod=authors.author_cod left join (select books.book_cod, title, genre from genrejunction join books on books.book_cod = genrejunction.book_cod join genres on genres.genre_cod = genrejunction.genre_cod) bookgenre on books.book_cod=bookgenre.book_cod order by book_cod";
        //booksql gives book code, isbn, title, author code, author name, notes and genre ordered by book code
        //Query is ordered by Primary Key to concatenate genres and erase duplicates. JSP page will have filters to order by author or title.
        ResultSet res=sentencia.executeQuery(booksql);
        //the following two variables facilitate concatenating genres, if a book has two
        int code=0;
        String genre="string";
        while (res.next()){
            Book book=new Book();
            setBook(book, res);
            if (code==res.getInt("book_cod")){
                genre=genre+", "+res.getString("genre");
                book.setGenre(genre);
            }else{
                book.setGenre(res.getString("genre"));
            }
            code=res.getInt("book_cod");
            genre=res.getString("genre");
            books.add(book);
        }
        
        deleteExtra(books);
        
        return books;
    }
    
    public ArrayList<Book> getPersonBooks(int personcode) throws SQLException{
        //Gets the books borrowed by the logged-in person. See getPersonBorrows for the borrow dates and fines.
        ArrayList<Book> books=new ArrayList();
        //get all books from database, put into ArrayList as Book objects
        Statement sentencia=cn.createStatement();
        String borrowersql="select books.book_cod, books.isbn, books.title, authors.name from books join authors on books.author_cod=authors.author_cod left join (select books.book_cod, person.person_cod from books join borrowed on books.book_cod = borrowed.book_cod join person on person.person_cod = borrowed.person_cod) borrower on books.book_cod=borrower.book_cod where borrower.person_cod="+personcode;
        //borrowersql gives book code (to extend lease), isbn, title, and author name - only for books borrowed by Person
        ResultSet res=sentencia.executeQuery(borrowersql);
        
        while (res.next()){
            Book book=new Book();
            setBook(book, res);
            books.add(book);
        }
        deleteExtra(books);
        
        return books;
    }
    
    public ArrayList<Borrow> getPersonBorrows(int personcode) throws SQLException{
        ArrayList<Borrow> borrows=new ArrayList();
        Statement sentencia=cn.createStatement();
        String borrowsql="select borrowed.book_cod, borrowed.borrowdate, borrowed.returndate, person.type from borrowed join person on borrowed.person_cod=person.person_cod where borrowed.person_cod="+personcode;
        //borrowsql gives book code, borrow date, return date, and person type for Person
        ResultSet res=sentencia.executeQuery(borrowsql);
        while (res.next()){
            Borrow borrow=new Borrow();
            borrow.setBookcode(res.getInt("book_cod"));
            borrow.setPersoncode(personcode);
            borrow.setPersontype(res.getString("type"));
            borrow.setOutdate(res.getDate("borrowdate"));
            borrow.setIndate(res.getDate("returndate"));
            borrow.setFine();
            borrows.add(borrow);
        }
        return borrows;
    }
    
    
    public ArrayList<Borrow> getAllBorrows() throws SQLException{
        ArrayList<Borrow> borrows=new ArrayList();
        Statement sentencia=cn.createStatement();
        String allborrowsql="select borrowed.book_cod, borrowed.borrowdate, borrowed.returndate, person.person_cod, person.type from borrowed join person on borrowed.person_cod=person.person_cod";
        //allborrowsql gives book code, borrow date, return date, person code, person name and person type for all borrows.
        ResultSet res=sentencia.executeQuery(allborrowsql);
        while (res.next()){
            Borrow borrow=new Borrow();
            borrow.setBookcode(res.getInt("book_cod"));
            borrow.setPersoncode(res.getInt("person_cod"));
            borrow.setPersontype(res.getString("type"));
            borrow.setOutdate(res.getDate("borrowdate"));
            borrow.setIndate(res.getDate("returndate"));
            borrow.setFine();
            borrows.add(borrow);
        }
        return borrows;
    }
    
    
    
}
