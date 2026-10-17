package com.liamyimport.model;

import com.liamyimport.util.enums.StatePromotion;

import java.time.LocalDate;

public class Promocion {
    private int idPromocion;
    private String nombre;
    private StatePromotion estado;
    private String descripcion;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private double porcentajeDescuento;
    private String colorFondo;
    private int sede;
    private String nombre_sede;

    public Promocion() {}

    public Promocion(int idPromocion, String nombre, StatePromotion estado, String descripcion,
                     LocalDate fechaInicio, LocalDate fechaFin, double porcentajeDescuento, String colorFondo, int sede,
                     String nombre_sede) {
        this.idPromocion = idPromocion;
        this.nombre = nombre;
        this.estado = estado;
        this.descripcion = descripcion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.porcentajeDescuento = porcentajeDescuento;
        this.colorFondo = colorFondo;
        this.sede = sede;
        this.nombre_sede = nombre_sede;
    }

    public int getIdPromocion() {
        return idPromocion;
    }

    public void setIdPromocion(int idPromocion) {
        this.idPromocion = idPromocion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public StatePromotion getEstado() {
        return estado;
    }

    public void setEstado(StatePromotion estado) {
        this.estado = estado;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public LocalDate getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDate fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public LocalDate getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }

    public double getPorcentajeDescuento() {
        return porcentajeDescuento;
    }

    public void setPorcentajeDescuento(double porcentajeDescuento) {
        this.porcentajeDescuento = porcentajeDescuento;
    }

    public String getColorFondo() {
        return colorFondo;
    }

    public void setColorFondo(String colorFondo) {
        this.colorFondo = colorFondo;
    }

    public int getSede() {
        return sede;
    }

    public void setSede(int sede) {
        this.sede = sede;
    }

    public String getNombre_sede() {
        return nombre_sede;
    }

    public void setNombre_sede(String nombre_sede) {
        this.nombre_sede = nombre_sede;
    }
}