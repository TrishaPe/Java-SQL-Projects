package controladores;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Abono;
import modelos.Cliente;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import repositorios.RepoCliente;

public class ContPortCliente extends MultiActionController{
    
    ModelAndView mv;
    HttpSession sesion;
    int codigo;
    RepoCliente repo;
    
    public ContPortCliente(){
        mv=new ModelAndView("PortCliente");
        repo=new RepoCliente();
    }
    
    public ModelAndView inicio(HttpServletRequest hsr, HttpServletResponse hsr1){
        mv=new ModelAndView("PortCliente");
        return mv;
    }
    
    public ModelAndView anteModificar(HttpServletRequest hsr, HttpServletResponse hsr1){
        //ponemos el formulario para modificar los datos de cliente
        mv.clear();
        mv=new ModelAndView("PortCliente");
        mv.addObject("seleccion", "modificar");
        
        return mv;
    }
    
    public ModelAndView modificar(HttpServletRequest hsr, HttpServletResponse hsr1){
        //modificamos los datos
        
        //RECOGER DATOS RECIBIDOS
        sesion=hsr.getSession();
        Cliente cliente=(Cliente) sesion.getAttribute("cliente");
        codigo=cliente.getCodigo();
        Cliente nuevo=new Cliente();
        nuevo.setNombre(hsr.getParameter("txtNombre"));
        nuevo.setApellidos(hsr.getParameter("txtApe"));
        nuevo.setCorreo(hsr.getParameter("txtCorreo"));
        nuevo.setUsuario(hsr.getParameter("txtUsuario"));
        nuevo.setContraseña(hsr.getParameter("txtContraseña"));
        nuevo.setCodigo(codigo);
        
        //COMPARAR CONTRASEÑA
        repo=new RepoCliente();
        String contbase=cliente.getContraseña();
        if (contbase.equals(hsr.getParameter("txtContraseña"))){
            //MODIFICAR DATOS
            int afectados=repo.modifCliente(nuevo);
            
            if (afectados>0){
                mv.addObject("modif", "exito");
            }else{
                mv.addObject("modif", "error");
            }
                
            Cliente cliente2=repo.getCliente(codigo);
            sesion.setAttribute("cliente", cliente2);
        }else{
            mv.addObject("modif", "equivocado");
        }
        return mv;
    }
    
    public ModelAndView contModificar(HttpServletRequest hsr, HttpServletResponse hsr1){
        //seccion separada para modificar contraseña
        
        //RECOGER DATOS RECIBIDOS
        sesion=hsr.getSession();
        Cliente cliente=(Cliente) sesion.getAttribute("cliente");
        codigo=cliente.getCodigo();
        String contraseñav=hsr.getParameter("txtContraseña");
        String contraseña1=hsr.getParameter("txtCont1");
        String contraseña2=hsr.getParameter("txtCont2");
        
        repo=new RepoCliente();
        //COMPARAR CONTRASEÑA
        if (cliente.getContraseña().equals(contraseñav)){
            if (contraseña1.equals(contraseña2)){
                //MODIFICAR DATOS
                repo.modifContraseña(contraseña1, codigo);
                mv.addObject("contmodif","ok");
                cliente=repo.getCliente(codigo);
                sesion.setAttribute("cliente", cliente);
            }else{
                mv.addObject("contmodif","desigual");
            }
        }else{
            mv.addObject("contmodif","equivocado");
        }
        return mv;
    }
    
    public ModelAndView abono(HttpServletRequest hsr, HttpServletResponse hsr1){
        //buscamos el abono para pintar sus datos
        mv.clear();
        mv=new ModelAndView("PortCliente");
        sesion=hsr.getSession();
        Cliente cliente=(Cliente) sesion.getAttribute("cliente");
        codigo=cliente.getCodigo();
        repo=new RepoCliente();
        Abono abono=repo.getAbono(codigo);
        
        if (abono.getAbono()==null){
            mv.addObject("abono", "vacio");
        }else{
            sesion.setAttribute("abono", abono);
        }
        mv.addObject("seleccion", "abono");
        
        return mv;
    }
            
    public ModelAndView borrar(HttpServletRequest hsr, HttpServletResponse hsr1){
        //borrar el usuario y la contraseña del cliente en base de datos, y borrar el cliente de la sesion
        mv.clear();
        mv=new ModelAndView("index");
        sesion=hsr.getSession();
        Cliente cliente=(Cliente) sesion.getAttribute("cliente");
        codigo=cliente.getCodigo();
        repo.borraUsuario(codigo);
        
        sesion.setAttribute("cliente", null);
        sesion.setAttribute("abono", null);
        return mv;
    }
    
    public ModelAndView desloguear(HttpServletRequest hsr, HttpServletResponse hsr1){
        //desloguearse sin borrar cuenta
        mv.clear();
        mv=new ModelAndView("index");
        sesion=hsr.getSession();
        sesion.setAttribute("cliente", null);
        sesion.setAttribute("abono", null);
        return mv;
    }
}
