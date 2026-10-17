package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.IPromocionFacade;
import com.liamyimport.mapper.PromocionMapper;
import com.liamyimport.model.Promocion;
import com.liamyimport.model.dto.PromocionDTO;
import com.liamyimport.persistence.dao.PromocionDAO;
import com.liamyimport.persistence.dao.interfaces.IPromocionDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PromocionFacade implements IPromocionFacade {
    private IPromocionDAO promocionDAO = new PromocionDAO();

    @Override
    public boolean addPromocion(PromocionDTO dto) {
        try {
            if ( dto != null && dto.nombre() != null && !dto.nombre().trim().isEmpty() ) {
                return promocionDAO.addPromotion( PromocionMapper.toEntity( dto ) );
            }
            return false;
        } catch ( SQLException e) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public List<PromocionDTO> getAllPromociones() {
        try {
            List<Promocion> promociones = promocionDAO.getAllPromotions();

            if( promociones.isEmpty() && promociones == null ) {
                return new ArrayList<>();
            }

            return promociones.stream()
                    .map( PromocionMapper :: toDTO )
                    .toList();

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public List<PromocionDTO> searchPromocion(PromocionDTO dto) {
        try {
            String criterio = ( dto != null && dto.nombre() != null ) ? dto.nombre() : "";

            List<Promocion> promociones = promocionDAO.searchPromotion( criterio );

            if( promociones.isEmpty() && promociones == null ) {
                return new ArrayList<>();
            }

            return promociones.stream()
                    .map( PromocionMapper ::toDTO )
                    .toList();

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean updatePromocion(PromocionDTO dto) {
        try {
            if ( dto != null && dto.nombre() != null && !dto.nombre().trim().isEmpty() ) {
                return promocionDAO.updatePromotion( PromocionMapper.toEntity( dto ) );
            }

            return false;

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean deletePromocion(int id) {
        try {
            if ( id > 0 ) {
                return promocionDAO.deletePromotion( id );
            }

            return false;

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }
}
