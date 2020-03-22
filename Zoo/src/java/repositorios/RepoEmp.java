package repositorios;

import controladores.ContIndex;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelos.Cita;
import modelos.Empleado;
import modelos.Proveedor;
import modelos.Vacaciones;

public class RepoEmp {
    Connection cn;
    String sqlemp;
    String sqlvac;
    
    public RepoEmp(){
        sqlemp="select empleados.emp_cod, empleados.apellidos, empleados.enombre, empleados.direccion, empleados.telefono, empleados.funcion, empleados.dept_cod, empleados.usuario, empleados.contraseña, empleados.salario, departamentos.dnombre from empleados "
            +"inner join departamentos on departamentos.dept_cod=empleados.dept_cod";
        sqlvac="select vacaciones.fecha_in, vacaciones.fecha_fin, vacaciones.emp_cod, vacaciones.aprobado, vacaciones.tipo, "
            +"empleados.enombre, empleados.apellidos, departamentos.dnombre from vacaciones inner join empleados "
            +"on empleados.emp_cod=vacaciones.emp_cod inner join departamentos on empleados.dept_cod=departamentos.dept_cod where aprobado='?'";
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
    
    public Empleado crearEmp(ResultSet res, Empleado emp){
        try {
            int codigo=res.getInt(1);
            emp.setCodigo(res.getInt(1));
            emp.setApellidos(res.getString(2));
            emp.setNombre(res.getString(3));
            emp.setDireccion(res.getString(4));
            emp.setTelefono(res.getString(5));
            emp.setFuncion(res.getString(6));
            emp.setDept_cod(res.getInt(7));
            emp.setUsuario(res.getString(8));
            emp.setContraseña(res.getString(9));
            emp.setSalario(res.getInt(10));
            emp.setDepartamento(res.getString(11));
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return emp;
    }
    
    public Empleado getEmp(String usuario, String contraseña){
        cn=conectar();
        Empleado emp=new Empleado();
            
        try {
            Connection cnx = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","oracle");
            Statement sentenciax=cnx.createStatement();
            String sql1="select usuario from empleados where usuario='"+usuario+"'";
            ResultSet resx=sentenciax.executeQuery(sql1);
            
            if (resx.next()){//si el usuario existe en base de datos
                cnx.close();
                String sql2=sqlemp+" where usuario=? and contraseña=?";
                PreparedStatement sentencia=cn.prepareStatement(sql2);
                sentencia.setString(1, usuario);
                sentencia.setString(2, contraseña);
                ResultSet res=sentencia.executeQuery();
                
                if (res.next()){//si la contraseña es igual tambien
                    emp=new Empleado();
                    crearEmp(res, emp);
                    cn.close();
                }else{//contraseña mal
                    emp=new Empleado();
                    cn.close();
                    emp.setNombre("error");
                }
            }else{//usuario no existe
                emp=new Empleado();
                cnx.close();
                emp.setNombre("nada");
            }
            return emp;
            
        } catch (SQLException ex) {
            Logger.getLogger(ContIndex.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }
    
    public Empleado getEmp(int codigo){
        cn=conectar();
        Empleado emp=new Empleado();
            
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery(sqlemp+" where emp_cod="+codigo);
            
            if (res.next()){
                crearEmp(res, emp);
            }
            cn.close();
            return emp;
            
        } catch (SQLException ex) {
            Logger.getLogger(ContIndex.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Vacaciones> getPetVac(){
        cn=conectar();
        ArrayList<Vacaciones> vacaciones=new ArrayList();
        try {
            Statement sentencia = cn.createStatement();
            ResultSet res=sentencia.executeQuery(sqlvac);
            while (res.next()){
                Vacaciones vac=new Vacaciones();
                vac.setFecha_in(res.getDate(1));
                vac.setFecha_fin(res.getDate(2));
                vac.setEmp_cod(res.getInt(3));
                vac.setDept_cod();
                vac.setAprobado(res.getString(4));
                vac.setTipo(res.getString(5));
                vac.setEmpleado(res.getString(6)+" "+res.getString(7));
                vac.setDepartamento(res.getString(8));
                vacaciones.add(vac);
            }
            cn.close();
            return vacaciones;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Vacaciones> getPetVac(int codigo){
        cn=conectar();
        ArrayList<Vacaciones> vacaciones=new ArrayList();
        try {
            Statement sentencia = cn.createStatement();
            ResultSet res=sentencia.executeQuery(sqlvac);
            while (res.next()){
                Vacaciones vac=new Vacaciones();
                vac.setEmp_cod(res.getInt("emp_cod"));
                vac.setDept_cod();
                if (vac.getDept_cod()==codigo){
                    vac.setFecha_in(res.getDate("fecha_in"));
                    vac.setFecha_fin(res.getDate("fecha_fin"));
                    vac.setAprobado(res.getString("aprobado"));
                    vacaciones.add(vac);
                }
            }
            cn.close();
            return vacaciones;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Cita> getPetVet(){
        cn=conectar();
        ArrayList<Cita> citas=new ArrayList();
        try {
            Statement sentencia = cn.createStatement();
            ResultSet res=sentencia.executeQuery("select citaveterinario.animal_cod, citaveterinario.fecha, citaveterinario.notas, animales.especie "
+"from citaveterinario inner join animales on citaveterinario.animal_cod=animales.animal_cod where citaveterinario.fecha is null");
            while (res.next()){
                Cita cita=new Cita();
                cita.setAnimal_cod(res.getInt(1));
                cita.setFecha(res.getString(2));
                cita.setNotas(res.getString(3));
                cita.setEspecie(res.getString(4));
                citas.add(cita);
            }
            cn.close();
            return citas;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int confirmCita(Date fecha, String[] animales){
        cn=conectar();
        try {
            PreparedStatement sentencia=cn.prepareStatement("update citaveterinario set fecha=? where animal_cod in(?)");
            String codigos="";
            for (String animal:animales){
                if (codigos.equals("")){
                    codigos=animal;
                }else{
                    codigos+=", "+animal;
                }
            }
            sentencia.setDate(1, fecha);
            sentencia.setString(2, codigos);
            int resultado=sentencia.executeUpdate();
            cn.commit();
            cn.close();
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int confirmVac(Date fecha_in, Date fecha_fin, int emp_cod, int aprobado){
        cn=conectar();
        int resultado=0;
        if(aprobado==1){
            try {
                PreparedStatement sentencia = cn.prepareStatement("update vacaciones set fecha_in=?, fecha_fin=?, aprobado='si' where emp_cod=?");
                sentencia.setDate(1, fecha_in);
                sentencia.setDate(2, fecha_fin);
                sentencia.setInt(3, emp_cod);
                resultado=sentencia.executeUpdate();
                cn.commit();
                cn.close();
            } catch (SQLException ex) {
                Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return resultado;
    }
    
    public int petVacaciones(int codigo, Date inicio, Date fin, String tipo){
        cn=conectar();
        try {
            PreparedStatement sentencia = cn.prepareStatement("insert into vacaciones values (?, ?, ?, ?, ?)");
            sentencia.setDate(1, inicio);
            sentencia.setDate(2, fin);
            sentencia.setInt(3, codigo);
            sentencia.setString(4, "?");
            sentencia.setString(5, tipo);
            int afectados=sentencia.executeUpdate();
            cn.commit();
            cn.close();
            return afectados;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public ArrayList<Empleado> getSubordinados(int dept){
        cn=conectar();
        ArrayList<Empleado> empleados = new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery(sqlemp+" where dept_cod="+dept+"order by funcion");
            while (res.next()){
                Empleado emp = new Empleado();
                crearEmp(res, emp);
                empleados.add(emp);
            }
            cn.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return empleados;
    }
    
    public ArrayList<Empleado> getSubordinados1(){
        cn=conectar();
        ArrayList<Empleado> empleados = new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery(sqlemp+" order by dept_cod");
            while (res.next()){
                Empleado emp = new Empleado();
                crearEmp(res, emp);
                empleados.add(emp);
            }
            cn.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return empleados;
    }
    
    public int modifEmp(int cod, String dir, String tel, String fun, String dept, String sal){
        cn=conectar();
        PreparedStatement sentencia;
        try {
            sentencia = cn.prepareStatement("update empleados set direccion=?, telefono=?, funcion=?, dept_cod=?, salario=? where emp_cod=?");
            sentencia.setString(1, dir);
            sentencia.setString(2, tel);
            sentencia.setString(3, fun);
            sentencia.setString(4, dept);
            sentencia.setString(5, sal);
            sentencia.setInt(6, cod);
            int afectados=sentencia.executeUpdate();
            cn.commit();
            cn.close();
            return afectados;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public ArrayList<String> getfunciones(){
        cn=conectar();
        ArrayList<String> funciones=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select distinct funcion from empleados");
            while (res.next()){
                funciones.add(res.getString(1));
            }
            return funciones;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Proveedor> getDepartamentos(){
        cn=conectar();
        ArrayList<Proveedor> dept=new ArrayList();
        try {
            Statement sentencia=cn.createStatement();
            ResultSet res=sentencia.executeQuery("select dnombre, dept_cod from departamentos");
            while (res.next()){
                Proveedor dep=new Proveedor();
                dep.setNombre(res.getString(1));
                dep.setCodigo(res.getInt(2));
                dept.add(dep);
            }
            return dept;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int addEmp(int cod, String nom, String ape, String dir, int tel, String fun, int dept, int sal){
        cn=conectar();
        PreparedStatement sentencia;
        try {
            String sqlinsemp="insert into empleados values (?, ?, ?, ?, ?, ?, ?, ('USZY'||SEQ_EMP_US.nextval), ('CEZG'||SEQ_EMP_CONT.nextval), ?)";
            sentencia = cn.prepareStatement(sqlinsemp);
            sentencia.setInt(1, cod);
            sentencia.setString(2, nom);
            sentencia.setString(3, ape);
            sentencia.setString(4, dir);
            sentencia.setInt(5, tel);
            sentencia.setString(6, fun);
            sentencia.setInt(7, dept);
            sentencia.setInt(8, sal);
            int afectados=sentencia.executeUpdate();
            cn.commit();
            cn.close();
            return afectados;
        } catch (SQLException ex) {
            Logger.getLogger(RepoEmp.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
}
