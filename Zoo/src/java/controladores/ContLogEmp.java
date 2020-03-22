package controladores;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Empleado;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import repositorios.RepoEmp;

public class ContLogEmp implements Controller{

    ModelAndView mv;
    
    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView ("LogEmp");
        HttpSession sesion=hsr.getSession();
        sesion.setAttribute("vacaciones", null);
        sesion.setAttribute("citas", null);
        sesion.setAttribute("ordenes", null);
        return mv;
    }
    
}
