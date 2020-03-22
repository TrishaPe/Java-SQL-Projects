package controladores;

import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Empleado;
import modelos.Pedido;
import modelos.Peticion;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import repositorios.RepoPeticion;

public class ContPeticiones extends MultiActionController{
    
    RepoPeticion repo;
    HttpSession sesion;
    
    public ContPeticiones(){
        this.repo=new RepoPeticion();
    }
    
    public ModelAndView inicio(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("Peticiones");
        sesion=hsr.getSession();
        
        //sacar pedidos confirmados
        ArrayList<Pedido> pedidos=repo.getPedidos();
        sesion.setAttribute("pedidos", pedidos);
        
        //sacar peticiones pendientes
        Empleado emp=(Empleado)sesion.getAttribute("empleado");
        int codigo=emp.getDept_cod();
        ArrayList<Peticion> peticiones=new ArrayList();
        if (codigo==1){
            peticiones=repo.getPetOrdenes();
        }else{
            peticiones=repo.getPetOrdenes(codigo);
        }
        sesion.setAttribute("peticiones", peticiones);
        
        //sacar historial
        ArrayList<Pedido> historial=repo.getHistPed();
        sesion.setAttribute("historial", historial);
        
        return mv;
    }
    
    public ModelAndView confirmllega(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("Peticiones");
        String[] llegado=hsr.getParameterValues("llegado");
        int resultadollega=repo.llegado(llegado);
        
        mv.addObject("llega", resultadollega);
        return mv;
    }
    
    public ModelAndView pedir(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception{
        ModelAndView mv=new ModelAndView("Peticiones");
        sesion=hsr.getSession();
        String contenido=hsr.getParameter("contenido");
        String especie=hsr.getParameter("especie");
        int dept=Integer.parseInt(hsr.getParameter("dept"));
        Date fecha=Date.valueOf(hsr.getParameter("fecha"));
        int resultadopedir=repo.pedir(contenido, especie, dept, fecha);
        mv.addObject("resped", resultadopedir);
        
        Empleado emp=(Empleado)sesion.getAttribute("empleado");
        int codigo=emp.getDept_cod();
        ArrayList<Peticion> peticiones=new ArrayList();
        if (codigo==1){
            peticiones=repo.getPetOrdenes();
        }else{
            peticiones=repo.getPetOrdenes(codigo);
        }
        sesion.setAttribute("peticiones", peticiones);
        
        return mv;
    }
}
