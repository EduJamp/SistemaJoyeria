package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.IClienteFacade;
import com.liamyimport.mapper.ClienteMapper;
import com.liamyimport.model.Cliente;
import com.liamyimport.model.dto.ClienteDTO;
import com.liamyimport.persistence.dao.ClienteDAO;
import com.liamyimport.persistence.dao.interfaces.IClienteDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClienteFacade implements IClienteFacade {
    private IClienteDAO clienteDAO = new ClienteDAO();


    @Override
    public boolean createCliente(ClienteDTO cliente) {
        try {
            if (cliente.getNombre() != null && !cliente.getNombre().trim().isEmpty()) {
                return clienteDAO.addCliente( ClienteMapper.toEntity( cliente ) );
            }
            return false;
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public List<ClienteDTO> getClientes() {
        try {
            List<Cliente> clientes = clienteDAO.getAllClientes();

            if (clientes != null && !clientes.isEmpty()) {
                return clientes.stream()
                        .map(ClienteMapper::toDTO)
                        .toList();
            }
            return new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ClienteDTO> searchCliente(ClienteDTO dto) {
        String criterio = ( dto != null && dto.getNombre() != null ) ? dto.getNombre() : "";

        try {
            List<Cliente> clientes = clienteDAO.searchCliente( criterio  );

            if (clientes != null && !clientes.isEmpty()) {
                return clientes.stream()
                        .map( ClienteMapper::toDTO )
                        .toList();
            }
            return new ArrayList<>();
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public ClienteDTO getClienteById(int id) {
        try {
            if ( id > 0 ) {
                Cliente cliente = clienteDAO.getClienteById(id);
                return cliente != null ? ClienteMapper.toDTO(cliente) : new ClienteDTO();
            }
            return new ClienteDTO();
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean modifyCliente(ClienteDTO dto) {
        try {
            if ( dto.getNombre() != null && !dto.getNombre().trim().isEmpty() ) {
                Cliente cliente = ClienteMapper.toEntity(dto);
                return clienteDAO.updateCliente(cliente);
            }
            return false;
        } catch ( Exception e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean deleteCliente(int id) {
        try {
            if ( id > 0 ) {
                return clienteDAO.deleteCliente( id );
            }
            return false;
        } catch ( Exception e ) {
            throw new RuntimeException( e );
        }
    }
}
