package com.liamyimport.mapper;

import com.liamyimport.model.Promocion;
import com.liamyimport.model.dto.PromocionDTO;

public class PromocionMapper {
    public static PromocionDTO toDTO(Promocion entidad) {
        PromocionDTO dto = new PromocionDTO(
                entidad.getIdPromocion(),
                entidad.getNombre(),
                entidad.getEstado(),
                entidad.getDescripcion(),
                entidad.getFechaInicio(),
                entidad.getFechaFin(),
                entidad.getPorcentajeDescuento(),
                entidad.getColorFondo(),
                entidad.getSede()
        );

        return dto;
    }

    public static Promocion toEntity(PromocionDTO dto) {
        Promocion entidad = new Promocion();
        entidad.setIdPromocion( dto.idPromocion() );
        entidad.setNombre( dto.nombre() );
        entidad.setEstado( dto.estado() );
        entidad.setDescripcion( dto.descripcion() );
        entidad.setFechaInicio( dto.fechaInicio() );
        entidad.setFechaFin( dto.fechaFin() );
        entidad.setPorcentajeDescuento( dto.porcentajeDescuento() );
        entidad.setColorFondo( dto.colorFondo() );
        entidad.setSede( dto.sede() );

        return entidad;
    }
}
