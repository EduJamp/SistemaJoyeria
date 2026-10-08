package com.liamyimport.model;

public class Venta {
    private int id;
    private String comprobante;
    private String cliente;
    private String sede;
    private double subtotal;
    private double ahorro;
    private double total;
    private String estado;
    private String fechaHora;
    private String empleado;
    private String metodoPago;

    public Venta() {}

    public Venta(int id, String comprobante, String cliente, String sede, double subtotal, double ahorro, double total, String estado, String fechaHora, String empleado, String metodoPago) {
        this.id = id;
        this.comprobante = comprobante;
        this.cliente = cliente;
        this.sede = sede;
        this.subtotal = subtotal;
        this.ahorro = ahorro;
        this.total = total;
        this.estado = estado;
        this.fechaHora = fechaHora;
        this.empleado = empleado;
        this.metodoPago = metodoPago;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getComprobante() { return comprobante; }
    public void setComprobante(String comprobante) { this.comprobante = comprobante; }

    public String getCliente() { return cliente; }
    public void setCliente(String cliente) { this.cliente = cliente; }

    public String getSede() { return sede; }
    public void setSede(String sede) { this.sede = sede; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

    public double getAhorro() { return ahorro; }
    public void setAhorro(double ahorro) { this.ahorro = ahorro; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getFechaHora() { return fechaHora; }
    public void setFechaHora(String fechaHora) { this.fechaHora = fechaHora; }

    public String getEmpleado() { return empleado; }
    public void setEmpleado(String empleado) { this.empleado = empleado; }

    public String getMetodoPago() { return metodoPago; }
    public void setMetodoPago(String metodoPago) { this.metodoPago = metodoPago; }
}
