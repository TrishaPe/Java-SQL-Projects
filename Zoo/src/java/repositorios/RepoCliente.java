package repositorios;

import controladores.ContIndex;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelos.Abono;
import modelos.Cliente;

public class RepoCliente {
    
    Connection cn;
    Cliente cliente;
    
    public RepoCliente(){
        cliente=new Cliente();
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
    
    
    public Cliente getCliente(String usuario, String contraseña){
        cn=conectar();
            
        try {
            Connection cnx = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
            Statement sentenciax=cnx.createStatement();
            String sql="select usuario from clientes where usuario='"+usuario+"'";
            ResultSet resx=sentenciax.executeQuery(sql);
            
            if (resx.next()){
                cnx.close();
                PreparedStatement sentencia=cn.prepareStatement("select * from clientes where usuario=? and contraseña=?");
                sentencia.setString(1, usuario);
                sentencia.setString(2, contraseña);
                ResultSet res=sentencia.executeQuery();
                if (res.next()){
                    cliente.setCodigo(res.getInt("cliente_cod"));
                    cliente.setApellidos(res.getString("apellidos"));
                    cliente.setNombre(res.getString("cnombre"));
                    cliente.setCorreo(res.getString("correo"));
                    cliente.setUsuario(res.getString("usuario"));
                    cliente.setContraseña(res.getString("contraseña"));
                    if (res.getString("entrada_cod")!=null){
                        cliente.setAbono_cod(res.getInt("entrada_cod"));
                    }else{
                        cliente.setAbono_cod(0);
                    }
                    return cliente;
                }else{
                    cnx.close();
                    cliente.setNombre("error");
                }
            }else{
                cnx.close();
                cliente.setNombre("nada");
            }
            return cliente;
            
        } catch (SQLException ex) {
            Logger.getLogger(ContIndex.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }
    
    
    public Cliente getCliente(int codigo){
        cn=conectar();
            
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select apellidos, cnombre, correo, usuario, contraseña, entrada_cod,"
                    + "fecha_in, fecha_cad from clientes where cliente_cod="+codigo);
            
            if (res.next()){
                cliente.setCodigo(codigo);
                cliente.setApellidos(res.getString(1));
                cliente.setNombre(res.getString(2));
                cliente.setCorreo(res.getString(3));
                cliente.setUsuario(res.getString(4));
                cliente.setContraseña(res.getString(5));
                if (res.getString(6)!=null){
                    cliente.setAbono_cod(res.getInt(6));
                }else{
                    cliente.setAbono_cod(0);
                }
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ContIndex.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return cliente;
    }
    
    public int getClienteCod(String correo){
        cn=conectar();
        int codigo=0;
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select cliente_cod from clientes where correo='"+correo+"'");
            if (res.next()){
                codigo=res.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RepoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return codigo;
    }
    
    public int modifCliente(Cliente nuevo){
        cn=conectar();
        int afectados=0;
        try {
            PreparedStatement sentencia=cn.prepareStatement("update clientes set apellidos=?, cnombre=?, correo=?,"
                    + "usuario=? where cliente_cod=?");
            sentencia.setString(1, nuevo.getApellidos());
            sentencia.setString(2, nuevo.getNombre());
            sentencia.setString(3, nuevo.getCorreo());
            sentencia.setString(4, nuevo.getUsuario());
            sentencia.setInt(5, nuevo.getCodigo());
            afectados=sentencia.executeUpdate();
            cn.commit();
        } catch (SQLException ex) {
            Logger.getLogger(RepoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return afectados;
    }
    
    public void modifContraseña(String contraseña, int codigo){
        cn=conectar();
        try {
            PreparedStatement sentencia=cn.prepareStatement("update clientes set contraseña=? where cliente_cod=?");
            sentencia.setString(1, contraseña);
            sentencia.setInt(2, codigo);
            sentencia.executeUpdate();
            cn.commit();
        } catch (SQLException ex) {
            Logger.getLogger(RepoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public Abono getAbono(int codigo){
        Abono abono=new Abono();
        cn=conectar();
        
        try {
            Statement sentencia=cn.createStatement();
            String sql = "select entradas.enombre, clientes.fecha_in, clientes.fecha_cad from clientes natural join entradas where cliente_cod="+codigo;
            ResultSet res=sentencia.executeQuery(sql);
            
            if (res.next()){
                if (res.getString(1)==null){
                    abono.setAbono("nada");
                    abono.setFechain("nada");
                    abono.setFechafin("nada");
                }else{
                    abono.setAbono(res.getString(1));
                    abono.setFechain(res.getString(2));
                    abono.setFechafin(res.getString(3));
                }
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return abono;
    }
    
    public void borraUsuario(int codigo){
        cn=conectar();
        try {
            String sql="update clientes set usuario=null, contraseña=null where cliente_cod="+codigo;
            Statement sentencia=cn.createStatement();
            sentencia.executeUpdate(sql);
            cn.commit();
            
        }catch(SQLException ex) {
            Logger.getLogger(RepoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String registrarUsuario(Cliente nuevo){
        //isNews & setNews para news(boolean)
        cn=conectar();
            
        try {
            //ver si ya existe esta persona en la base de datos
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select usuario, apellidos, cnombre, correo from clientes");
            String resultado="";
            while (res.next()){
                if (res.getString("apellidos").equals(nuevo.getApellidos())){//apellidos ya existe
                    if (res.getString("cnombre").equals(nuevo.getNombre())){//nombre igual
                        if (res.getString("correo").equals(nuevo.getCorreo())){//correo es igual
                            if (res.getString("usuario")!=null){//tiene usuario
                                //ya existe un perfil con estos datos. Has olvidado tu usuario y contraseña?
                                resultado="existe";
                            }else{
                                //crear usuario y contraseña en perfil existente
                                resultado="insertar";
                            }//si no se cumple ninguno de estos casos, creamos un perfil nuevo.
                        }
                    }
                }
            }
            

            if (resultado.equals("insertar")){//existe un perfil correspondiente sin usuario. crear usuario y contraseña en perfil existente
                Connection cnx = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
                //determinamos dónde añadir usuario y contraseña buscando el correo, porque este tiene que ser único.
                PreparedStatement sentenciax=cnx.prepareStatement("update clientes set usuario=?, contraseña=? where correo=?");
                sentenciax.setString(1, nuevo.getUsuario());
                sentenciax.setString(2, nuevo.getContraseña());
                sentenciax.setString(3, nuevo.getCorreo());
                int afectados=sentenciax.executeUpdate();
                if (afectados>0){
                    cnx.close();
                    resultado="hecho";
                    int codigo=getClienteCod(nuevo.getCorreo());
                    nuevo.setCodigo(codigo);
                }else{
                    cnx.close();
                    resultado="error";
                }
            }else if (resultado.equals("")){//resultado tambien puede ser "existe"; este mensaje lo devolvemos integral.
                //Crear perfil nuevo
                Connection cnx = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
                //determinamos dónde añadir usuario y contraseña buscando el correo, porque este tiene que ser único.
                PreparedStatement sentenciax=cnx.prepareStatement("insert into clientes values(sq_cliente.nextval, ?, ?, ?, ?, ?, null, null, null, ?)");
                sentenciax.setString(1, nuevo.getApellidos());
                sentenciax.setString(2, nuevo.getNombre());
                sentenciax.setString(3, nuevo.getCorreo());
                sentenciax.setString(4, nuevo.getUsuario());
                sentenciax.setString(5, nuevo.getContraseña());
                if (nuevo.isNews()==true){
                    sentenciax.setString(6, "T");
                }else{
                    sentenciax.setString(6, "F");
                }
                int afectados=sentenciax.executeUpdate();
                
                if (afectados>0){
                    cnx.close();
                    resultado="hecho";
                    int codigo=getClienteCod(nuevo.getCorreo());
                    nuevo.setCodigo(codigo);
                }else{
                    cnx.close();
                    resultado="error";
                }
            }
            
            //en este punto, resultado tiene que ser a)hecho, b)error o c)existe. Las opciones 'insertar' y 'null' fueron
            //convertidos en 'hecho' o 'error'.
            return resultado;
            
        }catch(SQLException ex) {
            Logger.getLogger(RepoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
