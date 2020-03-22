package controladores;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Cliente;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import repositorios.RepoCliente;

public class ContRegistrar implements Controller{
    RepoCliente repo;
    ModelAndView mv;
    
    public ContRegistrar(){
        repo=new RepoCliente();
    }

    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        Cliente nuevo=new Cliente();
        if (hsr.getParameter("txtCont1").equals(hsr.getParameter("txtCont2"))){
            nuevo.setNombre(hsr.getParameter("txtNombre"));
            nuevo.setApellidos(hsr.getParameter("txtApe"));
            nuevo.setCorreo(hsr.getParameter("txtCorreo"));
            nuevo.setUsuario(hsr.getParameter("txtUsuario"));
            nuevo.setContraseña(hsr.getParameter("txtCont1"));
            if (hsr.getParameter("chkNews")!=null){
                nuevo.setNews(true);
            }else{
                nuevo.setNews(false);
            }
            
            String resultado=repo.registrarUsuario(nuevo);
            if (resultado.equals("hecho")){//si todo va bien, vamos al portal de cliente con Session
                mv=new ModelAndView("PortCliente");
                HttpSession sesion=hsr.getSession();
                sesion.setAttribute("cliente", nuevo);
            }else{//si hay un problema, nos quedamos en la pagina de registro con mensaje de qué pasó
                mv=new ModelAndView("Registrar");
                mv.addObject("resultado", resultado);
            }
        }
        return mv;
    }
    
}
