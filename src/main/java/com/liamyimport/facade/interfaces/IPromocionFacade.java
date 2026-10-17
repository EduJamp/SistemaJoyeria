package com.liamyimport.facade.interfaces;

import com.liamyimport.model.Promocion;
import com.liamyimport.model.dto.PromocionDTO;

import java.util.List;

public interface IPromocionFacade {
    boolean addPromocion(PromocionDTO dto);
    List<PromocionDTO> getAllPromociones();
    List<PromocionDTO> searchPromocion(PromocionDTO dto);
    boolean updatePromocion(PromocionDTO dto);
    boolean deletePromocion(int id);
}
