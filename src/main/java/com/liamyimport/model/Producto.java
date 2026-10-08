package com.liamyimport.model;

import com.liamyimport.util.enums.State;

public class Producto {
    private String codigoBarras;
    private String imagen;
    private String nombre;
    private String descripcion;
    private double precioUnidad;
    private double precioX3;
    private double precioX6;
    private double precioX12;
    private double precioPaquete;
    private int cantidad;
    private State estado;
    private Categoria categoria;

    public Producto() {
    }

    public Producto(String codigoBarras, String imagen, String nombre, String descripcion, double precioUnidad,
                    double precioX3, double precioX6, double precioX12, double precioPaquete, int cantidad, State estado,
                    Categoria categoria) {
        this.codigoBarras = codigoBarras;
        this.imagen = imagen;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precioUnidad = precioUnidad;
        this.precioX3 = precioX3;
        this.precioX6 = precioX6;
        this.precioX12 = precioX12;
        this.precioPaquete = precioPaquete;
        this.cantidad = cantidad;
        this.estado = estado;
        this.categoria = categoria;
    }

    public String getCodigoBarras() {
        return codigoBarras;
    }

    public void setCodigoBarras(String codigoBarras) {
        this.codigoBarras = codigoBarras;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecioUnidad() {
        return precioUnidad;
    }

    public void setPrecioUnidad(double precioUnidad) {
        this.precioUnidad = precioUnidad;
    }

    public double getPrecioX3() {
        return precioX3;
    }

    public void setPrecioX3(double precioX3) {
        this.precioX3 = precioX3;
    }

    public double getPrecioX6() {
        return precioX6;
    }

    public void setPrecioX6(double precioX6) {
        this.precioX6 = precioX6;
    }

    public double getPrecioX12() {
        return precioX12;
    }

    public void setPrecioX12(double precioX12) {
        this.precioX12 = precioX12;
    }

    public double getPrecioPaquete() {
        return precioPaquete;
    }

    public void setPrecioPaquete(double precioPaquete) {
        this.precioPaquete = precioPaquete;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public State getEstado() {
        return estado;
    }

    public void setEstado(State estado) {
        this.estado = estado;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }
}
