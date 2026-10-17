package com.liamyimport.model.dto;

import com.liamyimport.util.enums.StatePromotion;

import java.time.LocalDate;

public record PromocionDTO(
        int idPromocion,
        String nombre,
        StatePromotion estado,
        String descripcion,
        LocalDate fechaInicio,
        LocalDate fechaFin,
        double porcentajeDescuento,
        String colorFondo,
        int sede
) {}
