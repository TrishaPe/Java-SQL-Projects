package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;


public class ContPortal extends MultiActionController{

    public ModelAndView login(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("portal");
        //if login ok: load person in session
        //if person is staff
            //load all borrowed books and borrows
            //calculate all fines based on person_type, make 'fines' arraylist with only overdue books
            //match 'fines' arraylist with borrows arraylist and add 'fines' field to borrows table in view
        //else
            //person loaded (in login), load borrows, calculate fines based on person.type
        return mv;
    }
    
}

