package com.liamyimport.model;

import com.liamyimport.util.enums.InventoryMovementType;

public class Inventario {
    private String codigoBarras;
    private String producto;
    private String sede;
    private String vendedor;
    private int stockSistema;
    private int contado;
    private int diferencia;
    private double impacto;
    private InventoryMovementType estado;
    private String fechaConteo;

    public Inventario() {
    }

    public Inventario(String codigoBarras, String producto, String sede, String vendedor, int stockSistema, int contado, double impacto, InventoryMovementType estado, String fechaConteo) {
        this.codigoBarras = codigoBarras;
        this.producto = producto;
        this.sede = sede;
        this.vendedor = vendedor;
        this.stockSistema = stockSistema;
        this.contado = contado;
        this.diferencia = contado - stockSistema;
        this.impacto = impacto;
        this.estado = estado;
        this.fechaConteo = fechaConteo;
    }

    public String getCodigoBarras() { return codigoBarras; }
    public void setCodigoBarras(String codigoBarras) { this.codigoBarras = codigoBarras; }

    public String getProducto() { return producto; }
    public void setProducto(String producto) { this.producto = producto; }

    public String getSede() { return sede; }
    public void setSede(String sede) { this.sede = sede; }

    public String getVendedor() { return vendedor; }
    public void setVendedor(String vendedor) { this.vendedor = vendedor; }

    public int getStockSistema() { return stockSistema; }
    public void setStockSistema(int stockSistema) {
        this.stockSistema = stockSistema;
        this.diferencia = this.contado - this.stockSistema;
    }

    public int getContado() { return contado; }
    public void setContado(int contado) {
        this.contado = contado;
        this.diferencia = this.contado - this.stockSistema;
    }

    public int getDiferencia() { return diferencia; }
    public void setDiferencia(int diferencia) { this.diferencia = diferencia; }

    public double getImpacto() { return impacto; }
    public void setImpacto(double impacto) { this.impacto = impacto; }

    public InventoryMovementType getEstado() { return estado; }
    public void setEstado(InventoryMovementType estado) { this.estado = estado; }

    public String getFechaConteo() { return fechaConteo; }
    public void setFechaConteo(String fechaConteo) { this.fechaConteo = fechaConteo; }
}