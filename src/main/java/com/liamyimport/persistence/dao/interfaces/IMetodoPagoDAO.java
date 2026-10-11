package com.liamyimport.persistence.dao.interfaces;

import com.liamyimport.model.MetodoPago;

import java.sql.SQLException;
import java.util.List;

public interface IMetodoPagoDAO {
    boolean addMetodoPago(MetodoPago metodo_pago) throws SQLException;
    List<MetodoPago> getMetodoPagos() throws SQLException;
    List<MetodoPago> searchMetodoPago(String criterio) throws SQLException;
    boolean updateMetodoPago(MetodoPago metodo_pago) throws SQLException;
    boolean deleteMetodoPago(int id) throws SQLException;
}
