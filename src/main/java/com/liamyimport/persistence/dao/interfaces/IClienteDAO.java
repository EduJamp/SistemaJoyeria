package com.liamyimport.persistence.dao.interfaces;

import com.liamyimport.model.Cliente;

import java.sql.SQLException;
import java.util.List;

public interface IClienteDAO {
    boolean addCliente(Cliente cliente) throws SQLException;
    Cliente getClienteById( int id ) throws SQLException;
    List<Cliente> getAllClientes() throws SQLException;
    boolean updateCliente( Cliente cliente ) throws SQLException;
    boolean deleteCliente( int id ) throws SQLException;
    List<Cliente> searchCliente( String criterio ) throws SQLException;
}
