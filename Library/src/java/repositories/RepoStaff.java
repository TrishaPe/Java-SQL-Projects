package repositories;

import java.sql.*;

public class RepoStaff {
    Connection cn;
    
    public RepoStaff() throws SQLException{
        //Create database connection
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        this.cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
    }
    
    public int DeleteBook(int code){
        int affected=0;
        return affected;
    }
    
    public int AddBook(String title, String author){
        int success=0;
        return success;
    }
    
    
}
