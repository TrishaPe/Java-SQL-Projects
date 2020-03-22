package controladores;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Empleado;
import modelos.Proveedor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import repositorios.RepoEmp;

public class ContModEmpDatos extends MultiActionController{
    
    RepoEmp repo;
    HttpSession sesion;
    
    public ContModEmpDatos(){
        this.repo=new RepoEmp();
    }
    
    public ModelAndView abrir(HttpServletRequest hsr, HttpServletResponse hsr1){
        ModelAndView mv=new ModelAndView("ModEmpDatos");
        sesion=hsr.getSession();
        int codigo=Integer.parseInt(hsr.getParameter("moddatos"));
        
        //sacar información de empleado
        Empleado sub=repo.getEmp(codigo);
        sesion.setAttribute("sub", sub);
        
        return mv;
    }
    
    public ModelAndView modif(HttpServletRequest hsr, HttpServletResponse hsr1){
        ModelAndView mv=new ModelAndView("ModEmpDatos");
        sesion=hsr.getSession();
        int codigo=Integer.parseInt(hsr.getParameter("codigo"));
        String dir=hsr.getParameter("direccion");
        String tel=hsr.getParameter("telefono");
        String fun=hsr.getParameter("funcion");
        String dept=hsr.getParameter("dept");
        String sal=hsr.getParameter("salario");
        int afectados=repo.modifEmp(codigo, dir, tel, fun, dept, sal);
        if (afectados>0){
            mv.addObject("resultado", "bien");
        }else{
            mv.addObject("resultado", "mal");
        }
        Empleado sub=repo.getEmp(codigo);
        sesion.setAttribute("sub", sub);
        return mv;
    }
    
    public ModelAndView preAñadir(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("ModEmpDatos");
        sesion=hsr.getSession();
        
        //sacar funciones y departamentos para añadir emp
        ArrayList<String> func=repo.getfunciones();
        sesion.setAttribute("funciones", func);
        ArrayList<Proveedor> dept=repo.getDepartamentos();
        sesion.setAttribute("departamentos", dept);
        
        mv.addObject("accion", "añadir");
        return mv;
    }
    
    public ModelAndView añadir(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("ModEmpDatos");
        mv.addObject("accion", "añadir"); //Necesitamos esto para que la pagina ModEmpDatos abra 'añadir' en vez de 'modificar'
        
        int codigo=Integer.parseInt(hsr.getParameter("codigo"));
        String nom=hsr.getParameter("nombre");
        String ape=hsr.getParameter("apellidos");
        String dir=hsr.getParameter("direccion");
        int tel=Integer.parseInt(hsr.getParameter("telefono"));
        String fun=hsr.getParameter("funcion");
        int dept=Integer.parseInt(hsr.getParameter("dept"));
        int sal=Integer.parseInt(hsr.getParameter("salario"));
        int afectados=repo.addEmp(codigo, nom, ape, dir, tel, fun, dept, sal);
        if (afectados>0){
            mv.addObject("resultado", "bien");
        }else{
            mv.addObject("resultado", "mal");
        }
        return mv;
        
    }
    
}
