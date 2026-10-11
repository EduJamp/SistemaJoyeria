package com.liamyimport.model.dto;

import com.liamyimport.util.enums.State;

public record MetodoPagoDTO(
        int id_metodo_pago,
        String nombre,
        State estado
) {
}
