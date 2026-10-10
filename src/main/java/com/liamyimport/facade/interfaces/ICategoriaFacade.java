package com.liamyimport.facade.interfaces;

import com.liamyimport.model.dto.CategoriaDTO;

import java.util.List;

public interface ICategoriaFacade {
    boolean createCategoria( CategoriaDTO categoria );
    List<CategoriaDTO> getCategorias();
    List<CategoriaDTO> searchCategorias( CategoriaDTO dto );
    CategoriaDTO getCategoriaById( int id );
    boolean modifyCategoria( CategoriaDTO categoria );
    boolean deleteCategoria( int id );
}
