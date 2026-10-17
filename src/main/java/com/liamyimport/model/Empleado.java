package com.liamyimport.model;

import com.liamyimport.util.enums.TypeIdentityDocument;

import java.time.LocalDate;

public class Empleado extends Persona {
    private int idEmpleado;
    private double salario;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private Sede sede;

    public Empleado() {
    }

    public Empleado(String nombre, String apellido, TypeIdentityDocument tipoDocumento, int numeroDocumento,
                    int telefono, String direccion, LocalDate fechaNacimiento, int idEmpleado, double salario, LocalDate fechaInicio,
                    LocalDate fechaFin, Sede sede) {
        super(nombre, apellido, tipoDocumento, numeroDocumento, telefono, direccion, fechaNacimiento);
        this.idEmpleado = idEmpleado;
        this.salario = salario;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.sede = sede;
    }

    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public double getSalario() {
        return salario;
    }

    public void setSalario(double salario) {
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

    public Sede getSede() {
        return sede;
    }

    public void setSede(Sede sede) {
        this.sede = sede;
    }
}
