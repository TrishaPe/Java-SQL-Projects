package controladores;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Empleado;
import modelos.Proveedor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import repositorios.RepoAnimal;

public class ContAnimales implements Controller{
    RepoAnimal repo;
    HttpSession sesion;
    
    public ContAnimales(){
        this.repo=new RepoAnimal();
    }
    
    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("Animales");
        sesion=hsr.getSession();
        sesion.setAttribute("animal", null); //Esto quita el animal guardado al volver de AnimalDatos
        
        Empleado emp=(Empleado) sesion.getAttribute("empleado");
        int dept=emp.getDept_cod();
        String funcion=emp.getFuncion();
        if (dept==1){
            sesion.setAttribute("animales",repo.getAnimales());
            ArrayList<Proveedor> departamentos=repo.getDepartamentos();
            sesion.setAttribute("departamentos", departamentos);
        }else if (dept!=1 && funcion.equals("gestor")){
            sesion.setAttribute("animales",repo.getAnimales());
        }else{
            sesion.setAttribute("animales",repo.getAnimales(dept));
        }
        return mv;
    }
}
