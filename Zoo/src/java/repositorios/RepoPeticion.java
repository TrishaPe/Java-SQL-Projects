package repositorios;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelos.Pedido;
import modelos.Peticion;
import modelos.Proveedor;

public class RepoPeticion {
    
    Connection cn;
    String sqlpet;
    String sqlped;
    
    public RepoPeticion(){
        sqlpet="select peticiones.peticion_cod, peticiones.especie, peticiones.dept_cod, peticiones.contenido, peticiones.fecha_meta, peticiones.listo, departamentos.dnombre from peticiones inner join departamentos on peticiones.dept_cod=departamentos.dept_cod";
        sqlped="select pedidos.pedido_cod, pedidos.contenido, pedidos.precio, pedidos.proveedor_cod, pedidos.fecha, pedidos.llegado, proveedores.pnombre from pedidos inner join proveedores on pedidos.proveedor_cod=proveedores.proveedor_cod";
    }
    
    public Connection conectar(){
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            cn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
        } catch (SQLException ex) {
            Logger.getLogger(RepoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cn;
    }
    
    public Peticion crearPet(ResultSet res, Peticion pet){
        try {
            pet.setPeticion_cod(res.getInt(1));
            pet.setEspecie(res.getString(2));
            pet.setDept_cod(res.getInt(3));
            pet.setContenido(res.getString(4));
            pet.setFecha(res.getDate(5));
            pet.setListo(res.getString(6));
            pet.setDepartamento(res.getString(7));
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pet;
    }
    
    public Pedido crearPed(ResultSet res, Pedido ped){
        try {
            ped.setPedido_cod(res.getInt(1));
            ped.setContenido(res.getString(2));
            ped.setPrecio(res.getInt(3));
            ped.setProveedor_cod(res.getInt(4));
            ped.setFecha(res.getDate(5));
            ped.setLlegado(res.getString(6));
            ped.setProveedor(res.getString(7));
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ped;
    }
    
    public ArrayList<Peticion> getPetOrdenes(){
        cn=conectar();
        ArrayList<Peticion> peti=new ArrayList();
        try {
            Statement sentencia = cn.createStatement();
            ResultSet res=sentencia.executeQuery(sqlpet+" where listo='no'");
            while (res.next()){
                Peticion pet=new Peticion();
                crearPet(res, pet);
                peti.add(pet);
            }
            cn.close();
            return peti;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Peticion> getPetOrdenes(int codigo){
        cn=conectar();
        ArrayList<Peticion> peti=new ArrayList();
        try {
            Statement sentencia = cn.createStatement();
            ResultSet res=sentencia.executeQuery(sqlpet+" where listo='no' and dept_cod="+codigo);
            while (res.next()){
                Peticion pet=new Peticion();
                crearPet(res, pet);
                peti.add(pet);
            }
            cn.close();
            return peti;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Proveedor> getProveedores(){
        ArrayList<Proveedor> proveedores=new ArrayList();
        cn=conectar();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select * from proveedores");
            while (res.next()){
                Proveedor prov=new Proveedor();
                prov.setCodigo(res.getInt("proveedor_cod"));
                prov.setNombre(res.getString("pnombre"));
                proveedores.add(prov);
            }
            cn.close();
            return proveedores;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int confirmPet(String[] peticiones, String[] listo, String contenido, int codigo, int precio, Date fecha){
        cn=conectar();
        
        String list="";
        for (String li:listo){
            if (list.equals("")){
                list=li;
            }else{
                list+=", "+li;
            }
        }
        
        try {
            //pedidos
            PreparedStatement sentencia1=cn.prepareStatement("insert into pedidos values (SQ_pedido.nextval, ?, ?, ?, ?, 'no')");
            sentencia1.setString(1, contenido);
            sentencia1.setInt(2, precio);
            sentencia1.setInt(3, codigo);
            sentencia1.setDate(4, fecha);
            int resultado1=sentencia1.executeUpdate();
            
            //pet_ped
            PreparedStatement sentencia2=cn.prepareStatement("insert into pet_ped values (?, sq_pedido.currval)");
            int resultado2=0;
            String control="";
            for (String petic:peticiones){
                sentencia2.setInt(1, Integer.parseInt(petic));
                int afectados=sentencia2.executeUpdate();
                if (afectados>0){
                    resultado2++;
                }else{
                    control="mal";
                }
            }
            cn.close();
            
            //peticiones
            Connection cn3 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
            Statement sentencia3=cn3.createStatement();
            int resultado3=sentencia3.executeUpdate("update peticiones set listo='si' where peticion_cod in ("+list+")");
            
            int resultado=0;
            if(resultado1>0 && resultado2>0 && resultado3>0 && control!="mal"){
                resultado=1;
            }
            return resultado;
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public ArrayList<Pedido> getPedidos(){
        cn=conectar();
        ArrayList<Pedido> pedidos=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery(sqlped);
            while (res.next()){
                Pedido ped=new Pedido();
                crearPed(res, ped);
                pedidos.add(ped);
            }
            cn.close();
            return pedidos;
        } catch (SQLException ex) {
            Logger.getLogger(RepoPeticion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int llegado(String[] llegado){
        cn=conectar();
        String control="";
        try {
            PreparedStatement sentencia=cn.prepareStatement("delete from pedidos where pedido_cod=?");
            for (String a:llegado){
                int b=Integer.parseInt(a);
                sentencia.setInt(1, b);
                int afectados=sentencia.executeUpdate();
                if (afectados<1){
                    control="mal";
                }
            }
        if (control.equals("mal")){
            return 0;
        }else{
            return 1;
        }
        } catch (SQLException ex) {
            Logger.getLogger(RepoPeticion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public ArrayList<Pedido> getHistPed(){
        cn=conectar();
        ArrayList<Pedido> historial=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            String sqlhist="select histpedidos.pedido_cod, histpedidos.contenido, histpedidos.precio, histpedidos.fecha, proveedores.pnombre "
                +"from histpedidos inner join proveedores on histpedidos.proveedor_cod=proveedores.proveedor_cod";
            ResultSet res=sentencia.executeQuery(sqlhist);
            while (res.next()){
                Pedido ped=new Pedido();
                ped.setPedido_cod(res.getInt(1));
                ped.setContenido(res.getString(2));
                ped.setPrecio(res.getInt(3));
                ped.setFecha(res.getDate(4));
                ped.setProveedor(res.getString(5));
                historial.add(ped);
            }
            return historial;
        } catch (SQLException ex) {
            Logger.getLogger(RepoPeticion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int pedir(String contenido, String especie, int dept, Date fecha){
        cn=conectar();
        try {
            PreparedStatement sentencia=cn.prepareStatement("insert into peticiones values (sq_peticion.nextval, ?, ?, ?, ?, 'no')");
            sentencia.setString(1, especie);
            sentencia.setInt(2, dept);
            sentencia.setString(3, contenido);
            sentencia.setDate(4, fecha);
            int afectados=sentencia.executeUpdate();
            return afectados;
        } catch (SQLException ex) {
            Logger.getLogger(RepoPeticion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
}
