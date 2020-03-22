package controladores;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Cliente;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import repositorios.RepoCliente;

public class ContIndex extends MultiActionController{
    ModelAndView mv;
    
    public ModelAndView info(HttpServletRequest hsr, HttpServletResponse hsr1){
        mv=new ModelAndView("Informacion");
        return mv;
    }
    
    public ModelAndView entradas(HttpServletRequest hsr, HttpServletResponse hsr1){
        mv=new ModelAndView("Abonos");
        return mv;
    }
    
    public ModelAndView noticias(HttpServletRequest hsr, HttpServletResponse hsr1){
        mv=new ModelAndView("Noticias");
        return mv;
    }
    
    public ModelAndView carousel(HttpServletRequest hsr, HttpServletResponse hsr1){
        mv=new ModelAndView("carousel");
        return mv;
    }
    
    public ModelAndView login(HttpServletRequest hsr, HttpServletResponse hsr1){
        
        mv=new ModelAndView("PortCliente");
        HttpSession sesion=hsr.getSession();
        String usuario=hsr.getParameter("txtUsuario");
        String password=hsr.getParameter("txtContraseña");
        RepoCliente repo=new RepoCliente();
        Cliente cliente=repo.getCliente(usuario, password);
        
        if (cliente.getNombre().equals("error")){
            mv.addObject("contraseña", "mal");
        }else if (cliente.getNombre().equals("nada")){
            mv.addObject("usuario", "mal");
        }else{
            sesion.setAttribute("cliente", cliente);
        }
        
        return mv;
    }
  
    public ModelAndView registrar(HttpServletRequest hsr, HttpServletResponse hsr1){
        mv=new ModelAndView("Registrar");
        return mv;
    }
    
}
