package controllers;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Choice;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import repositories.RepoStory;

public class ContStory extends MultiActionController{
    
    RepoStory repo;
    
    public ContStory() throws SQLException{
        this.repo=new RepoStory();
    }
    
    public ModelAndView onLoad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("Winterfair");
        
        HashMap paragraph=repo.getParagraph(1);
        ArrayList<Choice> choices = repo.getChoices(1);
        
        mv.addObject("paragraph", paragraph);
        mv.addObject("choices", choices);
        
        return mv;
        
    }
    
    public ModelAndView follow(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("Winterfair");
        
        //int number = Integer.parseInt(hsr.getParameter("number"));
        
        return mv;
    }
    
}
