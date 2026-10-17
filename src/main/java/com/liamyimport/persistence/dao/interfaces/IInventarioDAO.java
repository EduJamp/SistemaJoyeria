package com.liamyimport.persistence.dao.interfaces;

import com.liamyimport.model.Inventario;

import java.sql.SQLException;
import java.util.List;

public interface IInventarioDAO {
    boolean addInventario(Inventario inventario) throws SQLException;
    List<Inventario> getAllInventarios() throws SQLException;
    List<Inventario> searchInventarios(String criterio) throws SQLException;
    boolean updateInventario(Inventario inventario) throws SQLException;
    boolean deleteInventario(int id) throws SQLException;
    Inventario getInventarioById(int id) throws SQLException;
}
