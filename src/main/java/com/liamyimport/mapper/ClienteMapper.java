package com.liamyimport.mapper;

import com.liamyimport.model.Cliente;
import com.liamyimport.model.dto.ClienteDTO;

public class ClienteMapper {
    public static Cliente toEntity(ClienteDTO dto) {
        if ( dto == null ) {
            return null;
        }

        Cliente cliente = new Cliente();
        cliente.setId_cliente( dto.getId_cliente() );
        cliente.setNombre( dto.getNombre() );
        cliente.setApellido( dto.getApellido() );
        cliente.setTipoDocumento( dto.getTipoDocumento() );
        cliente.setNumeroDocumento( dto.getNumeroDocumento() );
        cliente.setTelefono( dto.getTelefono() );
        cliente.setDireccion( dto.getDireccion() );
        cliente.setFechaNacimiento( dto.getFechaNacimiento() );
        cliente.setEmail( dto.getEmail() );
        cliente.setFechaNacimiento( dto.getFechaNacimiento() );
        cliente.setEstado( dto.getEstado() );
        cliente.setNumeroCompras( dto.getNumeroCompras() );
        cliente.setTotalComprado( dto.getTotalComprado() );
        cliente.setUltimaCompra( dto.getUltimaCompra() );

        return cliente;
    }

    public static ClienteDTO toDTO(Cliente cliente) {
        if ( cliente == null ) {
            return null;
        }

        ClienteDTO dto = new ClienteDTO();
        dto.setId_cliente( cliente.getId_cliente() );
        dto.setNombre( cliente.getNombre() );
        dto.setApellido( cliente.getApellido() );
        dto.setTipoDocumento( cliente.getTipoDocumento() );
        dto.setNumeroDocumento( cliente.getNumeroDocumento() );
        dto.setTelefono( cliente.getTelefono() );
        dto.setDireccion( cliente.getDireccion() );
        dto.setFechaNacimiento( cliente.getFechaNacimiento() );
        dto.setEmail( cliente.getEmail() );
        dto.setFechaNacimiento( cliente.getFechaNacimiento() );
        dto.setEstado( cliente.getEstado() );
        dto.setNumeroCompras( cliente.getNumeroCompras() );
        dto.setTotalComprado( cliente.getTotalComprado() );
        dto.setUltimaCompra( cliente.getUltimaCompra() );

        return dto;
    }
}
