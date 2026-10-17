package com.liamyimport.persistence.dao.interfaces;

import com.liamyimport.model.Promocion;

import java.sql.SQLException;
import java.util.List;

public interface IPromocionDAO {
    boolean addPromotion(Promocion promocion) throws SQLException;
    List<Promocion> getAllPromotions()  throws SQLException;
    List<Promocion> searchPromotion(String criterio) throws SQLException;
    boolean updatePromotion(Promocion promocion) throws SQLException;
    boolean deletePromotion(int id) throws SQLException;
}
