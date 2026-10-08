package com.liamyimport.model;

public class Caja {
    private int id;
    private String sede;
    private String responsable;
    private double montoInicial;
    private String fechaApertura;
    private String observacionesApertura;
    private double montoFinalSistema;
    private double montoFinalFisico;
    private double diferencia;
    private String fechaCierre;
    private String observacionesCierre;
    private String estado; // "ABIERTA" o "CERRADA"

    public Caja() {}

    public Caja(int id, String sede, String responsable, double montoInicial, String fechaApertura, String observacionesApertura, String estado) {
        this.id = id;
        this.sede = sede;
        this.responsable = responsable;
        this.montoInicial = montoInicial;
        this.fechaApertura = fechaApertura;
        this.observacionesApertura = observacionesApertura;
        this.estado = estado;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSede() { return sede; }
    public void setSede(String sede) { this.sede = sede; }

    public String getResponsable() { return responsable; }
    public void setResponsable(String responsable) { this.responsable = responsable; }

    public double getMontoInicial() { return montoInicial; }
    public void setMontoInicial(double montoInicial) { this.montoInicial = montoInicial; }

    public String getFechaApertura() { return fechaApertura; }
    public void setFechaApertura(String fechaApertura) { this.fechaApertura = fechaApertura; }

    public String getObservacionesApertura() { return observacionesApertura; }
    public void setObservacionesApertura(String observacionesApertura) { this.observacionesApertura = observacionesApertura; }

    public double getMontoFinalSistema() { return montoFinalSistema; }
    public void setMontoFinalSistema(double montoFinalSistema) { this.montoFinalSistema = montoFinalSistema; }

    public double getMontoFinalFisico() { return montoFinalFisico; }
    public void setMontoFinalFisico(double montoFinalFisico) { this.montoFinalFisico = montoFinalFisico; }

    public double getDiferencia() { return diferencia; }
    public void setDiferencia(double diferencia) { this.diferencia = diferencia; }

    public String getFechaCierre() { return fechaCierre; }
    public void setFechaCierre(String fechaCierre) { this.fechaCierre = fechaCierre; }

    public String getObservacionesCierre() { return observacionesCierre; }
    public void setObservacionesCierre(String observacionesCierre) { this.observacionesCierre = observacionesCierre; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}