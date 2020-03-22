package controladores;

import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Empleado;
import modelos.Vacaciones;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import repositorios.RepoEmp;
import repositorios.RepoPeticion;

public class ContPortEmp extends MultiActionController{
    
    RepoEmp repoemp;
    RepoPeticion repopet;
    HttpSession sesion;
    
    public ContPortEmp(){
        this.repoemp=new RepoEmp();
        this.repopet=new RepoPeticion();
    }

    public ModelAndView inicio(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView ("PortEmp");
        if(hsr.getParameter("txtUsuario")!=null){//si entramos desde la pagina de logueo
            String usuario=hsr.getParameter("txtUsuario");
            String contraseña=hsr.getParameter("txtContraseña");
            sesion=hsr.getSession();
            Empleado emp=repoemp.getEmp(usuario, contraseña);

            if (emp.getNombre().equals("error")){//contraseña mal: pintamos un mensaje en la pagina de logueo
                mv=new ModelAndView("LogEmp");
                mv.addObject("mensaje", "contraseña");
            }else if (emp.getNombre().equals("nada")){//nombre no encontrado: pintamos un mensaje en la pagina de logueo
                mv=new ModelAndView("LogEmp");
                mv.addObject("mensaje", "usuario");
            }else{//usuario y contraseña estan bien: vamos al portal justo
                mv=new ModelAndView("PortEmp");
                sesion.setAttribute("empleado", emp);
                
                if (emp.getDept_cod()==1){
                    sesion.setAttribute("vacaciones", repoemp.getPetVac());
                }else{
                    ArrayList<Vacaciones> vacaciones=repoemp.getPetVac(emp.getDept_cod());
                    sesion.setAttribute("vacaciones", vacaciones);
                }
                sesion.setAttribute("citas",repoemp.getPetVet());
                sesion.setAttribute("ordenes",repopet.getPetOrdenes());
                sesion.setAttribute("proveedores", repopet.getProveedores());
            }
        }else{//Si entramos volviendo desde las paginas mas adelante
            sesion=hsr.getSession();
            sesion.setAttribute("subordinados", null);
            sesion.setAttribute("animales", null);
            
            Empleado emp=(Empleado)sesion.getAttribute("empleado");
            
            if (emp.getDept_cod()==1){
                sesion.setAttribute("vacaciones", repoemp.getPetVac());
            }else{
                ArrayList<Vacaciones> vacaciones=repoemp.getPetVac(emp.getDept_cod());
                sesion.setAttribute("vacaciones", vacaciones);
            }
            sesion.setAttribute("citas",repoemp.getPetVet());
            sesion.setAttribute("ordenes",repopet.getPetOrdenes());
            sesion.setAttribute("proveedores", repopet.getProveedores());
            
        }
        return mv;
    }
    
    
    public ModelAndView confirmcita(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("PortEmp");
        String[] animales=hsr.getParameterValues("animales");
        Date fecha=Date.valueOf(hsr.getParameter("fecha"));
        int resultadocita=repoemp.confirmCita(fecha, animales);
        mv.addObject("resultadocita", resultadocita);
        sesion.setAttribute("citas",repoemp.getPetVet());
        return mv;
    }
    
    public ModelAndView confirmvac(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("PortEmp");
        Date fecha_in=Date.valueOf(hsr.getParameter("inicio"));
        Date fecha_fin=Date.valueOf(hsr.getParameter("final"));
        int emp_cod=Integer.valueOf(hsr.getParameter("empleado"));
        int aprobado=Integer.valueOf(hsr.getParameter("aprobado"));
        int resultadovac=repoemp.confirmVac(fecha_in, fecha_fin, emp_cod, aprobado);
        mv.addObject("resultadovac", resultadovac);
        
        sesion=hsr.getSession();
        Empleado emp=(Empleado)sesion.getAttribute("empleado");
        if (emp.getDept_cod()==1){
            sesion.setAttribute("vacaciones", repoemp.getPetVac());
        }else{
            ArrayList<Vacaciones> vacaciones=repoemp.getPetVac(emp.getDept_cod());
            sesion.setAttribute("vacaciones", vacaciones);
        }
        return mv;
    }
    
    public ModelAndView confirmpet(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("PortEmp");
        String[] peticiones=hsr.getParameterValues("peticion");//codigos de peticion
        String[] listo=hsr.getParameterValues("listo");//codigos de peticion (peticiones listas)
        String contenido=hsr.getParameter("txtcontenido");//texto
        int codigo=Integer.parseInt(hsr.getParameter("cmbprov"));//codigo de proveedor
        int precio=Integer.parseInt(hsr.getParameter("txtprecio"));
        Date fecha=Date.valueOf(hsr.getParameter("txtfecha")); //fecha
        int resultadopet=repopet.confirmPet(peticiones, listo, contenido, codigo, precio, fecha);
        mv.addObject("resultadopet", resultadopet);
        return mv;
    }
    
    public ModelAndView pedirvacaciones(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("PortEmp");
        sesion=hsr.getSession();
        Empleado emp=(Empleado)sesion.getAttribute("empleado");
        int codigo=emp.getCodigo();
        Date inicio=Date.valueOf(hsr.getParameter("fecha_in"));
        Date fin=Date.valueOf(hsr.getParameter("fecha_in"));
        String tipo=hsr.getParameter("cmbtipo");
        int resultadopedvac=repoemp.petVacaciones(codigo, inicio, fin, tipo);
        mv.addObject("resultadopedvac", resultadopedvac);
        return mv;
    }
    
    public ModelAndView desloguear(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("index");
        sesion=hsr.getSession();
        sesion.setAttribute("empleado", null);
        sesion.setAttribute("vacaciones", null);
        sesion.setAttribute("subordinados", null);
        
        sesion.setAttribute("animales", null);
        
        sesion.setAttribute("citas", null);
        sesion.setAttribute("ordenes", null);
        sesion.setAttribute("proveedores", null);
        
        sesion.setAttribute("pedidos", null);
        sesion.setAttribute("peticiones", null);
        sesion.setAttribute("historial", null);
        return mv;
    }

    
}
