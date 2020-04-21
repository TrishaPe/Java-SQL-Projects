package controllers;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Borrow;
import org.springframework.web.servlet.ModelAndView;
import models.Person;
import org.springframework.web.servlet.mvc.Controller;
import repositories.RepoPortal;


public class ContPortal implements Controller{
    
    
    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        //initialize a few necessary entities
        ModelAndView mv=new ModelAndView("portal");
        RepoPortal repo=new RepoPortal();
        HttpSession session=hsr.getSession();
        
        //get login credentials
        String username=hsr.getParameter("txtUser");
        String password="error";
        if (hsr.getParameter("txtPass")!= ""){
            password=hsr.getParameter("txtPass");
        }
        //check credentials
        Person person=repo.login(username, password);
        if (person.getName().equals("error")){ //wrong password
            mv.addObject("error", "pass");
        }else if (person.getName().equals("naught")){ //wrong username
            mv.addObject("error", "name");
        }else{ //everything ok --> load Person object in session
            session.setAttribute("user", person);
            
            //load correct list of borrowed books depending on person type
            if (person.getType().equals("staff")){ //Staff get a list of all borrowed books
                ArrayList<Borrow> borrows=repo.getAllBorrows();
                session.setAttribute("borrows", borrows);
            }else{ //everyone else just gets their own borrowed books
                ArrayList<Borrow> borrows=repo.getPersonBorrows(person.getCode());
            }
        }
        return mv;
    }
    
}

