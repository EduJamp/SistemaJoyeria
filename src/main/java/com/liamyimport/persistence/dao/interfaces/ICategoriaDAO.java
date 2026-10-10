package com.liamyimport.persistence.dao.interfaces;

import com.liamyimport.model.Categoria;

import java.sql.SQLException;
import java.util.List;

public interface ICategoriaDAO {
    boolean addCategoria( Categoria categoria )  throws SQLException;
    Categoria getCategoriaById( int id ) throws SQLException;
    List<Categoria> getCategorias() throws SQLException;
    boolean updateCategoria( Categoria categoria ) throws SQLException;
    boolean deleteCategoria( int id ) throws SQLException;
    List<Categoria> searchCategorias( String criterio ) throws SQLException;
}
