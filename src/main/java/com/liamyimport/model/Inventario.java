package com.liamyimport.model;


public class Inventario {
    private int idInventario;
    private int stockSistema;
    private int stockFisico;
    private int faltantes;
    private int sobrantes;
    private double impacto;
    private String estado;
    private String fechaConteo;
    private int idSede;
    private int idEmpleado;
    private int idProducto;

    public Inventario() {
    }

    public Inventario(int idInventario, int stockSistema, int stockFisico, int faltantes, int sobrantes,
                      double impacto, String estado, String fechaConteo, int idSede, int idEmpleado, int idProducto) {
        this.idInventario = idInventario;
        this.stockSistema = stockSistema;
        this.stockFisico = stockFisico;
        this.faltantes = faltantes;
        this.sobrantes = sobrantes;
        this.impacto = impacto;
        this.estado = estado;
        this.fechaConteo = fechaConteo;
        this.idSede = idSede;
        this.idEmpleado = idEmpleado;
        this.idProducto = idProducto;
    }

    public int getIdInventario() {
        return idInventario;
    }

    public void setIdInventario(int idInventario) {
        this.idInventario = idInventario;
    }

    public int getStockSistema() {
        return stockSistema;
    }

    public void setStockSistema(int stockSistema) {
        this.stockSistema = stockSistema;
    }

    public int getStockFisico() {
        return stockFisico;
    }

    public void setStockFisico(int stockFisico) {
        this.stockFisico = stockFisico;
    }

    public int getFaltantes() {
        return faltantes;
    }

    public void setFaltantes(int faltantes) {
        this.faltantes = faltantes;
    }

    public int getSobrantes() {
        return sobrantes;
    }

    public void setSobrantes(int sobrantes) {
        this.sobrantes = sobrantes;
    }

    public double getImpacto() {
        return impacto;
    }

    public void setImpacto(double impacto) {
        this.impacto = impacto;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFechaConteo() {
        return fechaConteo;
    }

    public void setFechaConteo(String fechaConteo) {
        this.fechaConteo = fechaConteo;
    }

    public int getIdSede() {
        return idSede;
    }

    public void setIdSede(int idSede) {
        this.idSede = idSede;
    }

    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }
}