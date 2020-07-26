package repositories;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Choice;

public class RepoStory {
    
    Connection cn;
    
    public RepoStory() throws SQLException{
        //Create database connection
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        this.cn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
    }
    
    public HashMap<Long, String> GetParagraph(int number){
        try {
            HashMap<Long, String> paragraph = new HashMap();
            
            String sql="select * from winterfair where paragraph_nr=?";
            PreparedStatement st=cn.prepareStatement(sql);
            st.setInt(1, number);
                        
            ResultSet res=st.executeQuery();
            
            while (res.next()){
                paragraph.put(Long.valueOf(number), res.getString("text"));
            }
            return paragraph;
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoStory.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList getChoices (int number){
        try {
            ArrayList<Choice> choices = new ArrayList();

            PreparedStatement st=cn.prepareStatement("select * from storyconnections where paragraph_nr=?");
            st.setInt(1, number);
            
            ResultSet res = st.executeQuery();
            while (res.next()){
                Choice choice = new Choice();
                choice.setOrigin(number);
                choice.setOption(res.getString("choice"));
                choice.setTarget(res.getInt("choice_nr"));
                choices.add(choice);
            }

            return choices;
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoStory.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
}
