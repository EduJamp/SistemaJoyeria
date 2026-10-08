package com.liamyimport.model;

import com.liamyimport.util.enums.State;


public class Sede {
    private int id;
    private String nombre;
    private String direccion;
    private String ciudad;
    private String telefono;
    private boolean esPrincipal;
    private State estado;

    public Sede() {}

    public Sede(int id, String nombre, String direccion, String ciudad, String telefono, boolean esPrincipal,
                State estado) {
        this.id = id;
        this.nombre = nombre;
        this.direccion = direccion;
        this.ciudad = ciudad;
        this.telefono = telefono;
        this.esPrincipal = esPrincipal;
        this.estado = estado;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getCiudad() { return ciudad; }
    public void setCiudad(String ciudad) { this.ciudad = ciudad; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public boolean isEsPrincipal() { return esPrincipal; }
    public void setEsPrincipal(boolean esPrincipal) { this.esPrincipal = esPrincipal; }

    public State getEstado() { return estado; }
    public void setEstado(State estado) { this.estado = estado; }
}
