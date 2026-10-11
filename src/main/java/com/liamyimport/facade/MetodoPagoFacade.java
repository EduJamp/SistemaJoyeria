package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.IMetodoPagoFacade;
import com.liamyimport.mapper.MetodoPagoMapper;
import com.liamyimport.model.MetodoPago;
import com.liamyimport.model.dto.MetodoPagoDTO;
import com.liamyimport.persistence.dao.MetodoPagoDAO;
import com.liamyimport.persistence.dao.interfaces.IMetodoPagoDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MetodoPagoFacade implements IMetodoPagoFacade {
    private IMetodoPagoDAO metodoPagoDAO = new MetodoPagoDAO();

    @Override
    public boolean addMetodoPago(MetodoPagoDTO metodoPago) {
        try {
            if ( metodoPago != null && metodoPago.nombre() != null && !metodoPago.nombre().trim().isEmpty() ) {
                return metodoPagoDAO.addMetodoPago( MetodoPagoMapper.toEntidad( metodoPago ) );
            }
            return false;
        }catch (SQLException e){
            throw new RuntimeException( e );
        }
    }

    @Override
    public List<MetodoPagoDTO> getAllMetodoPago() {
        try {
            List<MetodoPago> mp = metodoPagoDAO.getMetodoPagos();

            if ( mp.isEmpty() ) {
                return new ArrayList<>();
            }

            return mp.stream()
                    .map( MetodoPagoMapper :: toDTO )
                    .toList();

        }catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public List<MetodoPagoDTO> searchMetodoPago(MetodoPagoDTO metodoPago) {
        try {
            String criterio = ( metodoPago != null && metodoPago.nombre() != null ) ? metodoPago.nombre() : "";
            List<MetodoPago> mp = metodoPagoDAO.searchMetodoPago(criterio);

            if ( mp.isEmpty() ) {
                return new ArrayList<>();
            }

            return mp.stream()
                    .map( MetodoPagoMapper :: toDTO )
                    .toList();
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean updateMetodoPago(MetodoPagoDTO metodoPago) {
        try {
            if ( metodoPago != null && metodoPago.nombre() != null && !metodoPago.nombre().trim().isEmpty() ) {
                MetodoPago mt = MetodoPagoMapper.toEntidad( metodoPago );
                return metodoPagoDAO.updateMetodoPago( mt );
            }

            return false;

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean deleteMetodoPago(int id) {
        try {
            if ( id > 0 ) {
                return metodoPagoDAO.deleteMetodoPago( id );
            }
            return false;

        } catch ( SQLException e )  {
            throw new RuntimeException( e );
        }
    }
}
