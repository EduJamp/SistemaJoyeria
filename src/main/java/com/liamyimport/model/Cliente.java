package com.liamyimport.model;

import com.liamyimport.util.enums.TypeIdentityDocument;

import java.time.LocalDate;

public class Cliente extends Persona {
    private String email;
    private String tipoCliente;

    public Cliente() {
    }

    public Cliente(String nombre, String apellido, TypeIdentityDocument tipoDocumento, int numeroDocumento, int telefono,
                   String direccion, LocalDate fechaNacimiento, String email, String tipoCliente) {
        super(nombre, apellido, tipoDocumento, numeroDocumento, telefono, direccion, fechaNacimiento);
        this.email = email;
        this.tipoCliente = tipoCliente;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTipoCliente() {
        return tipoCliente;
    }

    public void setTipoCliente(String tipoCliente) {
        this.tipoCliente = tipoCliente;
    }
}