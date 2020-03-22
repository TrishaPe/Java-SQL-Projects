package modelos;

import java.io.Serializable;
import java.sql.Date;

public class Pedido implements Serializable{
    
    int pedido_cod;
    String contenido;
    int precio;
    int proveedor_cod;
    String proveedor;
    Date fecha;
    String llegado;

    public int getPedido_cod() {
        return pedido_cod;
    }

    public void setPedido_cod(int pedido_cod) {
        this.pedido_cod = pedido_cod;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public int getProveedor_cod() {
        return proveedor_cod;
    }

    public void setProveedor_cod(int proveedor_cod) {
        this.proveedor_cod = proveedor_cod;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getLlegado() {
        return llegado;
    }

    public void setLlegado(String llegado) {
        this.llegado = llegado;
    }
    
}
