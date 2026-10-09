package com.liamyimport.persistence.dao.interfaces;

import com.liamyimport.model.Sede;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface ISedeDAO {
    boolean addSede(Sede sede) throws SQLException;
    Sede getSedeById(int id) throws SQLException;
    List<Sede> getAllSedes() throws SQLException;
    boolean updateSede(Sede sede) throws SQLException;
    boolean deleteSede(int id) throws SQLException;
    List<Sede> searchSede(String criterio) throws SQLException;
}
