package com.liamyimport.mapper;

import com.liamyimport.model.Producto;
import com.liamyimport.model.dto.ProductoDTO;

public class ProductoMapper {

    // Convierte de Entidad a DTO
    public static ProductoDTO toDTO(Producto entidad) {
        ProductoDTO dto = new ProductoDTO();

        dto.setId(entidad.getId());
        dto.setCodigoBarras(entidad.getCodigoBarras());
        dto.setImagen(entidad.getImagen());
        dto.setNombre(entidad.getNombre());
        dto.setDescripcion(entidad.getDescripcion());
        dto.setPrecioUnidad(entidad.getPrecioUnidad());
        dto.setPrecioX3(entidad.getPrecioX3());
        dto.setPrecioX6(entidad.getPrecioX6());
        dto.setPrecioX12(entidad.getPrecioX12());
        dto.setPrecioPaquete(entidad.getPrecioPaquete());
        dto.setCantidad(entidad.getCantidad());
        dto.setEstado(entidad.getEstado());
        dto.setCategoria(entidad.getCategoria());

        return dto;
    }

    public static Producto toEntity(ProductoDTO dto) {
        Producto entidad = new Producto();

        entidad.setId(dto.getId());
        entidad.setCodigoBarras(dto.getCodigoBarras());
        entidad.setImagen(dto.getImagen());
        entidad.setNombre(dto.getNombre());
        entidad.setDescripcion(dto.getDescripcion());
        entidad.setPrecioUnidad(dto.getPrecioUnidad());
        entidad.setPrecioX3(dto.getPrecioX3());
        entidad.setPrecioX6(dto.getPrecioX6());
        entidad.setPrecioX12(dto.getPrecioX12());
        entidad.setPrecioPaquete(dto.getPrecioPaquete());
        entidad.setCantidad(dto.getCantidad());
        entidad.setEstado(dto.getEstado());
        entidad.setCategoria(dto.getCategoria());

        return entidad;
    }
}