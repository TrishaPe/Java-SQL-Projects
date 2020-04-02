package controllers;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Book;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import repositories.RepoPortal;

public class ContBooklist implements Controller{

    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("booklist");
        RepoPortal repo=new RepoPortal();
        ArrayList<Book> books=repo.getAllBooks();
        mv.addObject("books", books);
        return mv;
    }
    
    
    
}
