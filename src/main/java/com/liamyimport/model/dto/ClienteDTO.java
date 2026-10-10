package com.liamyimport.model.dto;

import com.liamyimport.model.Persona;
import com.liamyimport.util.enums.State;
import com.liamyimport.util.enums.TypeIdentityDocument;

import java.time.LocalDate;
import java.util.Date;

public class ClienteDTO extends Persona {
    private int id_cliente;
    private String email;
    private String tipoCliente;
    private State estado;
    private int numeroCompras;
    private double totalComprado;
    private LocalDate ultimaCompra;

    public ClienteDTO() {
    }

    public ClienteDTO(String nombre, String apellido, TypeIdentityDocument tipoDocumento, int numeroDocumento,
                      int telefono, String direccion, LocalDate fechaNacimiento, int id_cliente, String email, String tipoCliente,
                      State estado, int numeroCompras, double totalComprado, LocalDate ultimaCompra) {
        super(nombre, apellido, tipoDocumento, numeroDocumento, telefono, direccion, fechaNacimiento);
        this.id_cliente = id_cliente;
        this.email = email;
        this.tipoCliente = tipoCliente;
        this.estado = estado;
        this.numeroCompras = numeroCompras;
        this.totalComprado = totalComprado;
        this.ultimaCompra = ultimaCompra;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
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

    public State getEstado() {
        return estado;
    }

    public void setEstado(State estado) {
        this.estado = estado;
    }

    public int getNumeroCompras() {
        return numeroCompras;
    }

    public void setNumeroCompras(int numeroCompras) {
        this.numeroCompras = numeroCompras;
    }

    public double getTotalComprado() {
        return totalComprado;
    }

    public void setTotalComprado(double totalComprado) {
        this.totalComprado = totalComprado;
    }

    public LocalDate getUltimaCompra() {
        return ultimaCompra;
    }

    public void setUltimaCompra(LocalDate ultimaCompra) {
        this.ultimaCompra = ultimaCompra;
    }
}
