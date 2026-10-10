package com.liamyimport.mapper;

import com.liamyimport.model.Categoria;
import com.liamyimport.model.dto.CategoriaDTO;

public class CategoriaMapper {
    public static CategoriaDTO toDTO(Categoria categoria) {
        if (categoria == null) {
            return null;
        }

        CategoriaDTO dto = new CategoriaDTO(
                categoria.getId(),
                categoria.getNombre(),
                categoria.getDescripcion()
        );

        return dto;
    }

    public static Categoria toEntity(CategoriaDTO dto) {
        if (dto == null) {
            return null;
        }
        Categoria entidad = new Categoria();

        entidad.setId( dto.id() );
        entidad.setNombre( dto.nombre() );
        entidad.setDescripcion( dto.descripcion() );

        return entidad;
    }
}
