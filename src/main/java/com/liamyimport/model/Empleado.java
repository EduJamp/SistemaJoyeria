package com.liamyimport.model;

import com.liamyimport.util.enums.TypeIdentityDocument;

import java.time.LocalDate;

public class Empleado extends Persona {
    private int salario;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;

    public Empleado() {
    }

    public Empleado(String nombre, String apellido, TypeIdentityDocument tipoDocumento, int numeroDocumento, int telefono,
                    String direccion, LocalDate fechaNacimiento, int salario, LocalDate fechaInicio, LocalDate fechaFin) {
        super(nombre, apellido, tipoDocumento, numeroDocumento, telefono, direccion, fechaNacimiento);
        this.salario = salario;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
    }

    public int getSalario() {
        return salario;
    }

    public void setSalario(int salario) {
        this.salario = salario;
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
}
