package repositorios;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelos.Abono;

public class RepoAbono {
    Connection cn;
    
    public Connection conectar(){
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            cn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
        } catch (SQLException ex) {
            Logger.getLogger(RepoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cn;
    }
    
    public ArrayList<Abono> getAbonos(){
        cn=conectar();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select * from entradas");
            ArrayList<Abono> abonos=new ArrayList();
            while (res.next()){
                Abono abono=new Abono();
                abono.setAbono(res.getString("enombre"));
                abono.setCodigo(res.getInt("entrada_cod"));
                abono.setDuracion(res.getInt("duracion"));
                abono.setPrecio(res.getInt("precio"));
                abono.setTipo(res.getString("tipo"));
                abonos.add(abono);
            }
            return abonos;
        } catch (SQLException ex) {
            Logger.getLogger(RepoAbono.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int comprar(int[] codigos, int cliente){
        int resultado=0;
        String control="";
        try {
            int result=0;
            for (int i=0; i<codigos.length; i++){
                cn=conectar();
                PreparedStatement sentencia=cn.prepareStatement("insert into ventas values (?, ?, ?, sysdate)");
                ResultSet res=null;
                int afectados=0;
                if (codigos[i]>0){
                    sentencia.setInt(1, i+1);
                    if (cliente==0){
                        sentencia.setString(2, null);
                    }else{
                        sentencia.setInt(2, cliente);
                    }
                    sentencia.setInt(3, codigos[i]);
                    afectados=sentencia.executeUpdate();
                }
                cn.close();
                if(afectados>0){
                    result+=1;
                }

            }
            
            if (result>0){
                resultado=1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RepoAbono.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultado;
    }
    
}
