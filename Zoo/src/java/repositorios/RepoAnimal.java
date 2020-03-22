package repositorios;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelos.Animal;
import modelos.Cita;
import modelos.Proveedor;

public class RepoAnimal {
    
    Connection cn;
    String sql;
    
    public RepoAnimal(){
        sql="select animales.animal_cod, animales.dept_cod, animales.anombre, animales.sexo, animales.especie, animales.dieta, " +
"animales.notas, animales.emp_cod, animales.foto, empleados.enombre, empleados.apellidos, departamentos.dnombre from animales " +
"inner join empleados on animales.emp_cod=empleados.emp_cod inner join departamentos on departamentos.dept_cod=animales.dept_cod ";
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
    
    public Animal crearAnimal(ResultSet res, Animal animal){
        try {
            animal.setAnimal_cod(res.getInt(1));
            animal.setDept_cod(res.getInt(2));
            animal.setNombre(res.getString(3));
            animal.setSexo(res.getString(4));
            animal.setEspecie(res.getString(5));
            animal.setDieta(res.getString(6));
            animal.setNotas(res.getString(7));
            animal.setEmp_cod(res.getInt(8));
            animal.setFoto(res.getString(9));
            animal.setEmpleado((res.getString(10))+" "+(res.getString(11)));
            animal.setDepartamento(res.getString(12));
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return animal;
    }
    
    public ArrayList<Proveedor> getDepartamentos(){
        cn=conectar();
        ArrayList<Proveedor> depart=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select dnombre,dept_cod from departamentos");
            while (res.next()){
                if (res.getInt(2)!=1 && res.getInt(2)!=8 && res.getInt(2)!=9){
                    Proveedor dept=new Proveedor();
                    dept.setNombre(res.getString(1));
                    dept.setCodigo(res.getInt(2));
                    depart.add(dept);
                }
            }
            cn.close();
            return depart;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Integer> getEmpleados(){
        cn=conectar();
        ArrayList<Integer> dept=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select emp_cod from empleados");
            while (res.next()){
                dept.add(res.getInt(1));
            }
            cn.close();
            return dept;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int añadir(Animal animal){
        cn=conectar();
        try {
            PreparedStatement sentencia=cn.prepareStatement("insert into animales values (sq_animal.nextval, ?, ?, ?, ?, ?, ?, ?, sysdate, ?)");
            sentencia.setInt(1, animal.getDept_cod());
            sentencia.setString(2, animal.getNombre());
            sentencia.setString(3, animal.getSexo());
            sentencia.setString(4, animal.getEspecie());
            sentencia.setString(5, animal.getDieta());
            sentencia.setString(6, animal.getNotas());
            sentencia.setInt(7, animal.getEmp_cod());
            sentencia.setString(8, animal.getFoto());
            int afectados=sentencia.executeUpdate();
            cn.close();
            return afectados;
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public ArrayList<Animal> getAnimales(){
        cn=conectar();
        ArrayList<Animal> animales=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery(sql+" order by animal_cod");
            while (res.next()){
                Animal animal=new Animal();
                crearAnimal(res, animal);
                animales.add(animal);
            }
            cn.close();
            return animales;
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
    public ArrayList<Animal> getAnimales(int codigo){
        cn=conectar();
        ArrayList<Animal> animales=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery(sql+"where dept_cod="+codigo+" order by animal_cod");
            while (res.next()){
                Animal animal=new Animal();
                crearAnimal(res, animal);
                animales.add(animal);
            }
            cn.close();
            return animales;
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public Animal getAnimal(int codigo){
        cn=conectar();
        Animal animal=new Animal();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery(sql+"where animal_cod="+codigo);
            if (res.next()){
                crearAnimal(res, animal);
            }
            cn.close();
            return animal;
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }
    
    public String getCitaFut(int codigo){
        cn=conectar();
        String fecha="";
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select * from citaveterinario where animal_cod="+codigo);
            if (res.next()){
                if (fecha.equals("")){
                    fecha=res.getString("fecha");
                }else{
                    fecha+=", "+res.getString("fecha");
                }
            }
            cn.close();
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return fecha;
    }
    
    public ArrayList<Cita> getCitaPas(int codigo){
        cn=conectar();
        ArrayList<Cita> citas=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select histveterinario.fecha, histveterinario.notas, animales.especie from histveterinario "
+"inner join animales on histveterinario.animal_cod=animales.animal_cod where animales.animal_cod="+codigo);
            while (res.next()){
                Cita cita=new Cita();
                cita.setFecha(res.getString(1));
                cita.setNotas(res.getString(2));
                cita.setEspecie(res.getString(3));
                cita.setAnimal_cod(codigo);
                citas.add(cita);
            }
            cn.close();
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return citas;
    }
    
    public int cerrarCita(int codigo, String notas){
        cn=conectar();
        
        try {
            PreparedStatement sentencia = cn.prepareStatement("update citaveterinario set notas=? where animal_cod=?");
            sentencia.setString(1, notas);
            sentencia.setInt(2, codigo);
            int afectados=sentencia.executeUpdate();
            cn.close();
            
            Connection cn1=conectar();
            Statement sentencia1=cn1.createStatement();
            int afectados1=sentencia1.executeUpdate("delete from citaveterinario where animal_cod="+codigo);
            cn1.close();
            
            if (afectados>0 && afectados1>0){
                return 1;
            }else{
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int pedirCita(int codigo, String notas){
        cn=conectar();
        
        try {
            PreparedStatement sentencia = cn.prepareStatement("insert into citaveterinario (animal_cod, notas) values (?, ?)");
            sentencia.setInt(1, codigo);
            sentencia.setString(2, notas);
            int afectados=sentencia.executeUpdate();
            return afectados;
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int addNotas(int codigo, String comentario){
        cn=conectar();
        try {
            PreparedStatement sentencia=cn.prepareStatement("update animales set notas=?, fecha=sysdate where animal_cod=?");
            sentencia.setString(1, comentario);
            sentencia.setInt(2, codigo);
            int afectados=sentencia.executeUpdate();
            
            return afectados;
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public ArrayList<Cita> getNotas(int codigo){
        cn=conectar();
        ArrayList<Cita> notas=new ArrayList();
        try {
            Statement sentencia = cn.createStatement();
            ResultSet res=sentencia.executeQuery("select * from histnotas where animal_cod="+codigo);
            while (res.next()){
                Cita nota=new Cita();
                String notasres=res.getString("notas");
                nota.setFecha(res.getString("fecha"));
                nota.setNotas(res.getString("notas"));
                notas.add(nota);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RepoAnimal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return notas;
    }
    
}
