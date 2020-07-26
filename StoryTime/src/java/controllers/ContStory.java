package controllers;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Choice;
//import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import repositories.RepoStory;

public class ContStory implements Controller{
    
    RepoStory repo;
    
    public ContStory() throws SQLException{
        this.repo=new RepoStory();
    }
    
    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("Winterfair");
        
        HashMap paragraph=repo.GetParagraph(2);
        ArrayList<Choice> choices = repo.getChoices(1);
        
        mv.addObject("paragraph", paragraph);
        mv.addObject("choices", choices);
        
        
        return mv;
        
        //int number = Integer.parseInt(hsr.getParameter("number"));
    }
    
    
    
}
