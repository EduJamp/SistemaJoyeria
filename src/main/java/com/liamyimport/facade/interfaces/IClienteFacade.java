package com.liamyimport.facade.interfaces;

import com.liamyimport.model.dto.ClienteDTO;

import java.util.List;

public interface IClienteFacade {
    boolean createCliente( ClienteDTO cliente );
    List<ClienteDTO> getClientes();
    List<ClienteDTO> searchCliente( ClienteDTO dto );
    ClienteDTO getClienteById( int id );
    boolean modifyCliente( ClienteDTO dto );
    boolean deleteCliente( int id );
}
