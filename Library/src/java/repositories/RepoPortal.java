package repositories;

import java.sql.*;
import java.util.*;
import models.Book;

public class RepoPortal {
    Connection cn;
    
    public RepoPortal() throws SQLException{
        //Create database connection
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        this.cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
    }
    
    public ArrayList<Book> getAllBooks() throws SQLException{
        ArrayList<Book> books=new ArrayList();
        Statement sentencia=cn.createStatement();
        String sql="select books.book_cod, books.isbn, books.title, books.author_cod, authors.name, books.notes from books left join authors on books.author_cod=authors.author_cod";
        ResultSet res=sentencia.executeQuery(sql);
        while (res.next()){
            Book book=new Book();
            book.setBookcode(res.getInt("book_cod"));
            book.setIsbn(res.getInt("isbn"));
            book.setTitle(res.getString("title"));
            book.setAutcode(res.getInt("author_code"));
            book.setAutname(res.getString("name"));
            book.setNotes(res.getString("notes"));
            books.add(book);
        }
        return books;
    }
    
    public ArrayList<Book> getPersonBooks(int personcode){
        ArrayList<Book> books=new ArrayList();
        return books;
    }
    
    public ArrayList<Book> getBorrowedBooks(){
        ArrayList<Book> books=new ArrayList();
        return books;
    }
    
    
    
}
