package com.liamyimport.model;

import com.liamyimport.util.enums.State;

public class MetodoPago {
    private int id_metodo_pago;
    private String nombre;
    private State estado;

    public MetodoPago() {
    }

    public MetodoPago(int id_metodo_pago, String nombre, State estado) {
        this.id_metodo_pago = id_metodo_pago;
        this.nombre = nombre;
        this.estado = estado;
    }

    public int getId_metodo_pago() {
        return id_metodo_pago;
    }

    public void setId_metodo_pago(int id_metodo_pago) {
        this.id_metodo_pago = id_metodo_pago;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public State getEstado() {
        return estado;
    }

    public void setEstado(State estado) {
        this.estado = estado;
    }
}
