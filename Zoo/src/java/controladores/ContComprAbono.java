package controladores;

import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Abono;
import modelos.Cliente;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import repositorios.RepoAbono;

public class ContComprAbono extends MultiActionController{
    RepoAbono repo;
    HttpSession sesion;
    
    private ContComprAbono(){
        this.repo=new RepoAbono();
    }
    
    public ModelAndView inicio(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("ComprAbono");
        sesion=hsr.getSession();
        ArrayList<Abono> abonos=repo.getAbonos();
        sesion.setAttribute("abonos", abonos);
        
        return mv;
    }
        
    public ModelAndView comprar(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv=new ModelAndView("ComprAbono");
        sesion=hsr.getSession();
        
        int[] entradas=new int[6];
        
        if (hsr.getParameter("cantidad_1")!=""){
            entradas[0]=Integer.parseInt(hsr.getParameter("cantidad_1"));
        }else{
            entradas[0]=0;
        }
        
        if (hsr.getParameter("cantidad_2")!=""){
            entradas[1]=Integer.parseInt(hsr.getParameter("cantidad_2"));
        }else{
            entradas[1]=0;
        }
        
        if (hsr.getParameter("cantidad_3")!=""){
            entradas[2]=Integer.parseInt(hsr.getParameter("cantidad_3"));
        }else{
            entradas[2]=0;
        }
        
        if (hsr.getParameter("cantidad_4")!=""){
            entradas[3]=Integer.parseInt(hsr.getParameter("cantidad_4"));
        }else{
            entradas[3]=0;
        }
        
        if (hsr.getParameter("cantidad_5")!=""){
            entradas[4]=Integer.parseInt(hsr.getParameter("cantidad_5"));
        }else{
            entradas[4]=0;
        }
        
        if (hsr.getParameter("cantidad_6")!=""){
            entradas[5]=Integer.parseInt(hsr.getParameter("cantidad_6"));
        }else{
            entradas[5]=0;
        }
        
        int control=0;
        for (int ent:entradas){
            if (ent>0){
                control+=1;
            }
        }
        
        int codigo=0;
        if (sesion.getAttribute("cliente")!=null){
            Cliente cliente=(Cliente) sesion.getAttribute("cliente");
            codigo=cliente.getCodigo();
        }
        
        int resultado=0;
        if (control>0){
            resultado=repo.comprar(entradas, codigo);
        }
        
        mv.addObject("resultado", resultado);
        
        return mv;
    }
    
}
