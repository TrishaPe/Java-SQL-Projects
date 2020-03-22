package controladores;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Animal;
import modelos.Cita;
import modelos.Empleado;
import modelos.Proveedor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import repositorios.RepoAnimal;

public class ContAnimalDatos extends MultiActionController{
    
    RepoAnimal repo;
    HttpSession sesion;
    
    public ContAnimalDatos(){
        this.repo=new RepoAnimal();
    }
    
    public ModelAndView preañadir(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("AnimalDatos");
        mv.addObject("tipo", "añadir");
        sesion=hsr.getSession();
        
        ArrayList<Integer> empleados=repo.getEmpleados();
        sesion.setAttribute("empleados", empleados);
        
        ArrayList<Proveedor> dept=repo.getDepartamentos();
        sesion.setAttribute("departamentos", dept);
        
        return mv;
    }
    
    public ModelAndView añadir(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("AnimalDatos");
        mv.addObject("tipo", "añadir"); //necesitamos añadir esto para que la pagina abra 'añadir' en vez de buscar datos
        Animal animal=new Animal();
        animal.setEspecie(hsr.getParameter("especie"));
        animal.setNombre(hsr.getParameter("nombre"));
        animal.setSexo(hsr.getParameter("sexo"));
        animal.setDieta(hsr.getParameter("dieta"));
        animal.setNotas(hsr.getParameter("comentario"));
        animal.setDept_cod(Integer.parseInt(hsr.getParameter("dept")));
        animal.setEmp_cod(Integer.parseInt(hsr.getParameter("empleado")));
        animal.setFoto(hsr.getParameter("foto"));
        int resultado=repo.añadir(animal);
        mv.addObject("resultado", resultado);
        return mv;
    }
    
    public ModelAndView inicio(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("AnimalDatos");
        sesion=hsr.getSession();
        Empleado emp=(Empleado) sesion.getAttribute("empleado");
        int dept=emp.getDept_cod();
        String funcion=emp.getFuncion();
        int codigo=Integer.parseInt(hsr.getParameter("anidatos"));
        
        Animal animal=repo.getAnimal(codigo);
        
        sesion.setAttribute("animal", animal);

        return mv;
    }
    
    public ModelAndView comentario(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("AnimalDatos");
        Animal animal=(Animal) sesion.getAttribute("animal");
        int codigo=animal.getAnimal_cod();
        String comentario=hsr.getParameter("comentario");
        
        int resultado=repo.addNotas(codigo, comentario);
        mv.addObject("resultado", resultado);
        return mv;
    }
    
    public ModelAndView citas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("AnimalDatos");
        Animal animal=(Animal) sesion.getAttribute("animal");
        int codigo=animal.getAnimal_cod();
        mv.addObject("opcion", "citas");
        //buscar las citas: las futuras en una tabla, y las pasadas en otra
        String cita=repo.getCitaFut(codigo);
        if (cita!=""){
            mv.addObject("futura", cita);
        }
        ArrayList<Cita> citas=repo.getCitaPas(codigo);
        mv.addObject("pasadas", citas);
        return mv;
    }
    
    public ModelAndView cerrarcita(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("AnimalDatos");
        mv.addObject("opcion", "pedircita");
        //pedir cita
        Animal animal=(Animal) sesion.getAttribute("animal");
        int codigo=animal.getAnimal_cod();
        String notas=hsr.getParameter("respuesta");
        int resultado=repo.cerrarCita(codigo, notas);
        
        mv.addObject("resultado", resultado);
        return mv;
    }
    
    public ModelAndView pedircita(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("AnimalDatos");
        mv.addObject("opcion", "pedircita");
        //pedir cita
        Animal animal=(Animal) sesion.getAttribute("animal");
        int codigo=animal.getAnimal_cod();
        String notas=hsr.getParameter("notas");
        int resultado=repo.pedirCita(codigo, notas);
        
        mv.addObject("resultado", resultado);
        return mv;
    }
    
    public ModelAndView notas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("AnimalDatos");
        mv.addObject("opcion", "notas");
        //sacar notas
        Animal animal=(Animal) sesion.getAttribute("animal");
        int codigo=animal.getAnimal_cod();
        ArrayList<Cita> notas=repo.getNotas(codigo);
        mv.addObject("notas", notas);
        return mv;
    }
    
    
}
