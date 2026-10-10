package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.ICategoriaFacade;
import com.liamyimport.mapper.CategoriaMapper;
import com.liamyimport.model.Categoria;
import com.liamyimport.model.dto.CategoriaDTO;
import com.liamyimport.persistence.dao.CategoriaDAO;
import com.liamyimport.persistence.dao.interfaces.ICategoriaDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoriaFacade implements ICategoriaFacade {
    private ICategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    public boolean createCategoria(CategoriaDTO categoria) {
        try {
            if (categoria != null && categoria.nombre() != null && !categoria.nombre().trim().isEmpty()) {
                return categoriaDAO.addCategoria(CategoriaMapper.toEntity(categoria));
            }
            return false;
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public List<CategoriaDTO> getCategorias() {
        try {
            List<Categoria> categorias = categoriaDAO.getCategorias();

            if (categorias != null && !categorias.isEmpty()) {
                return categorias.stream()
                        .map( CategoriaMapper::toDTO )
                        .toList();
            }
            return new ArrayList<>();

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public List<CategoriaDTO> searchCategorias(CategoriaDTO dto) {
        try {
            String criterio = ( dto != null && dto.nombre() != null ) ? dto.nombre() : "";

            List<Categoria> categorias = categoriaDAO.searchCategorias( criterio );

            if (categorias != null && !categorias.isEmpty()) {
                return categorias.stream()
                        .map( CategoriaMapper::toDTO )
                        .toList();
            }
            return new ArrayList<>();

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public CategoriaDTO getCategoriaById(int id) {
        try {
            return CategoriaMapper.toDTO( categoriaDAO.getCategoriaById( id ) );
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean modifyCategoria(CategoriaDTO categoria) {
        try {
            if( categoria != null && categoria.nombre() != null && !categoria.nombre().trim().isEmpty() ) {
                Categoria c = CategoriaMapper.toEntity( categoria );
                return categoriaDAO.updateCategoria( c );
            }
            return false;

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean deleteCategoria(int id) {
        try {
            if( id > 0 ) {
                return categoriaDAO.deleteCategoria( id );
            }
            return false;
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }
}
