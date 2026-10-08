package com.liamyimport.model;

public class Promocion {
    private int id;
    private String nombre;
    private String tipo; // Descuento, Combo, 2 + 1, etc.
    private String estado; // Activa, Inactiva, Por vencer, Programada
    private String descripcion;
    private String fechaInicio;
    private String fechaFin;
    private String sede;
    private String colorFondo;

    public Promocion() {}

    public Promocion(int id, String nombre, String tipo, String estado, String descripcion, String fechaInicio,
                     String fechaFin, String sede, String colorFondo) {
        this.id = id;
        this.nombre = nombre;
        this.tipo = tipo;
        this.estado = estado;
        this.descripcion = descripcion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.sede = sede;
        this.colorFondo = colorFondo;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(String fechaInicio) { this.fechaInicio = fechaInicio; }

    public String getFechaFin() { return fechaFin; }
    public void setFechaFin(String fechaFin) { this.fechaFin = fechaFin; }

    public String getSede() { return sede; }
    public void setSede(String sede) { this.sede = sede; }

    public String getColorFondo() { return colorFondo; }
    public void setColorFondo(String colorFondo) { this.colorFondo = colorFondo; }
}