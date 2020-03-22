package controladores;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Empleado;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import repositorios.RepoEmp;

public class ContEmpDatos implements Controller{
    RepoEmp repo;
    HttpSession sesion;
    
    public ContEmpDatos(){
        this.repo=new RepoEmp();
    }
    

    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("EmpDatos");
        sesion=hsr.getSession();
        sesion.setAttribute("sub", null);
        sesion.setAttribute("funciones", null);
        sesion.setAttribute("departamentos", repo.getDepartamentos());
        Empleado emp=(Empleado) sesion.getAttribute("empleado");
        int dept=emp.getDept_cod();
        ArrayList <Empleado> subordinados=null;
        
        if (dept!=1){
            subordinados=repo.getSubordinados(dept);
        }else{
            subordinados=repo.getSubordinados1();
        }
        sesion.setAttribute("subordinados", subordinados);
        
        return mv;
    }
    
}
