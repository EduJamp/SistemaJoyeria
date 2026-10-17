package com.liamyimport.model.dto;

import com.liamyimport.util.enums.TypeIdentityDocument;

import java.time.LocalDate;

public class EmpleadoDTO {
    private String nombre;
    private String apellido;
    private TypeIdentityDocument tipoDocumento;
    private int numeroDocumento;
    private int telefono;
    private String direccion;
    private LocalDate fechaNacimiento;

    private int idEmpleado;
    private double salario;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;

    private int idSede;

    public EmpleadoDTO() {
    }

    public EmpleadoDTO(String nombre, String apellido, TypeIdentityDocument tipoDocumento, int numeroDocumento,
                       int telefono, String direccion, LocalDate fechaNacimiento, int idEmpleado, double salario, LocalDate fechaInicio,
                       LocalDate fechaFin, int idSede) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.tipoDocumento = tipoDocumento;
        this.numeroDocumento = numeroDocumento;
        this.telefono = telefono;
        this.direccion = direccion;
        this.fechaNacimiento = fechaNacimiento;
        this.idEmpleado = idEmpleado;
        this.salario = salario;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.idSede = idSede;
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

    public int getIdSede() {
        return idSede;
    }

    public void setIdSede(int idSede) {
        this.idSede = idSede;
    }
}
