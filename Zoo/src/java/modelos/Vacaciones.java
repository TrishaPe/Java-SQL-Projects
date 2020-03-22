package modelos;

import java.io.Serializable;
import java.sql.Date;

public class Vacaciones implements Serializable{
    
    Date fecha_in;
    Date fecha_fin;
    int emp_cod;
    String empleado;
    int dept_cod;
    String departamento;
    String tipo;
    String aprobado;

    public Date getFecha_in() {
        return fecha_in;
    }

    public void setFecha_in(Date fecha_in) {
        this.fecha_in = fecha_in;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public int getEmp_cod() {
        return emp_cod;
    }

    public void setEmp_cod(int emp_cod) {
        this.emp_cod = emp_cod;
    }
    
    public int getDept_cod() {
        return dept_cod;
    }

    public void setDept_cod() {
        String emp=String.valueOf(this.emp_cod);
        char dept=emp.charAt(0);
        this.dept_cod=Integer.parseInt(String.valueOf(dept));
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public String getAprobado() {
        return aprobado;
    }

    public void setAprobado(String aprobado) {
        this.aprobado = aprobado;
    }

    public String getEmpleado() {
        return empleado;
    }

    public void setEmpleado(String empleado) {
        this.empleado = empleado;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }
    
}
