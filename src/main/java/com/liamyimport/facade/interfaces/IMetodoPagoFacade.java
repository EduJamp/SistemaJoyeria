package com.liamyimport.facade.interfaces;

import com.liamyimport.model.dto.MetodoPagoDTO;

import java.util.List;

public interface IMetodoPagoFacade {
    boolean addMetodoPago( MetodoPagoDTO metodoPago );
    List<MetodoPagoDTO> getAllMetodoPago();
    List<MetodoPagoDTO> searchMetodoPago( MetodoPagoDTO metodoPago );
    boolean updateMetodoPago( MetodoPagoDTO metodoPago );
    boolean deleteMetodoPago( int id );
}
