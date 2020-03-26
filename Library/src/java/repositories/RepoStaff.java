package repositories;

import java.sql.*;

public class RepoStaff {
    Connection cn;
    
    public RepoStaff() throws SQLException{
        //Create database connection
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        this.cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
    }
    
    
    
    
}
