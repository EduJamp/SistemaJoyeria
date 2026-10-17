package com.liamyimport.mapper;

import com.liamyimport.model.Inventario;
import com.liamyimport.model.dto.InventarioDTO;

public class InventarioMapper {
    public static InventarioDTO toDTO(Inventario entidad) {
        if (entidad == null) {
            return null;
        }

        InventarioDTO dto = new InventarioDTO();
        dto.setIdInventario(entidad.getIdInventario());
        dto.setStockSistema(entidad.getStockSistema());
        dto.setStockFisico(entidad.getStockFisico());
        dto.setFaltantes(entidad.getFaltantes());
        dto.setSobrantes(entidad.getSobrantes());
        dto.setImpacto(entidad.getImpacto());
        dto.setEstado(entidad.getEstado());
        dto.setFechaConteo(entidad.getFechaConteo());

        dto.setIdSede(entidad.getIdSede());
        dto.setIdEmpleado(entidad.getIdEmpleado());
        dto.setIdProducto(entidad.getIdProducto());

        return dto;
    }

    public static Inventario toEntity(InventarioDTO dto) {
        if (dto == null) {
            return null;
        }

        Inventario entidad = new Inventario();
        entidad.setIdInventario(dto.getIdInventario());
        entidad.setStockSistema(dto.getStockSistema());
        entidad.setStockFisico(dto.getStockFisico());
        entidad.setFaltantes(dto.getFaltantes());
        entidad.setSobrantes(dto.getSobrantes());
        entidad.setImpacto(dto.getImpacto());
        entidad.setEstado(dto.getEstado());
        entidad.setFechaConteo(dto.getFechaConteo());

        entidad.setIdSede(dto.getIdSede());
        entidad.setIdEmpleado(dto.getIdEmpleado());
        entidad.setIdProducto(dto.getIdProducto());

        return entidad;
    }
}
