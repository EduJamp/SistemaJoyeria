package com.liamyimport.model;

import com.liamyimport.util.enums.TypeIdentityDocument;

import java.time.LocalDate;

public abstract class Persona {
    private String nombre;
    private String apellido;
    private TypeIdentityDocument tipoDocumento;
    private int numeroDocumento;
    private int telefono;
    private String direccion;
    private LocalDate fechaNacimiento;

    public Persona(String nombre, String apellido, TypeIdentityDocument tipoDocumento, int numeroDocumento, int telefono,
                   String direccion, LocalDate fechaNacimiento) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.tipoDocumento = tipoDocumento;
        this.numeroDocumento = numeroDocumento;
        this.telefono = telefono;
        this.direccion = direccion;
        this.fechaNacimiento = fechaNacimiento;
    }

    public Persona() {
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public TypeIdentityDocument getTipoDocumento() {
        return tipoDocumento;
    }

    public void setTipoDocumento(TypeIdentityDocument tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public int getNumeroDocumento() {
        return numeroDocumento;
    }

    public void setNumeroDocumento(int numeroDocumento) {
        this.numeroDocumento = numeroDocumento;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
}
