package modelos;

import java.sql.Date;

public class Peticion {
    
    int peticion_cod;
    String especie;
    int dept_cod;
    String departamento;
    String contenido;
    Date fecha;
    String listo;

    public int getPeticion_cod() {
        return peticion_cod;
    }

    public void setPeticion_cod(int peticion_cod) {
        this.peticion_cod = peticion_cod;
    }

    public String getEspecie() {
        return especie;
    }

    public void setEspecie(String especie) {
        this.especie = especie;
    }

    public int getDept_cod() {
        return dept_cod;
    }

    public void setDept_cod(int dept_cod) {
        this.dept_cod = dept_cod;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getListo() {
        return listo;
    }

    public void setListo(String listo) {
        this.listo = listo;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }
    
    
}
