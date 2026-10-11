package com.liamyimport.mapper;

import com.liamyimport.model.MetodoPago;
import com.liamyimport.model.dto.MetodoPagoDTO;

public class MetodoPagoMapper {
    public static MetodoPago toEntidad(MetodoPagoDTO dto) {
        MetodoPago metodoPago = new MetodoPago(
                dto.id_metodo_pago(),
                dto.nombre(),
                dto.estado()
        );

        return metodoPago;
    }

    public static MetodoPagoDTO toDTO(MetodoPago entidad) {
        MetodoPagoDTO metodoPagoDTO = new MetodoPagoDTO(
                entidad.getId_metodo_pago(),
                entidad.getNombre(),
                entidad.getEstado()
        );

        return metodoPagoDTO;
    }
}
