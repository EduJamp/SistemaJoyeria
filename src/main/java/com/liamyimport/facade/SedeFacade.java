package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.ISedeFacade;
import com.liamyimport.mapper.SedeMapper;
import com.liamyimport.model.Sede;
import com.liamyimport.model.dto.SedeDTO;
import com.liamyimport.persistence.dao.SedeDAO;
import com.liamyimport.persistence.dao.interfaces.ISedeDAO;

import java.sql.SQLException;
import java.util.List;

public class SedeFacade implements ISedeFacade {
     private ISedeDAO sedeDAO = new SedeDAO();

    @Override
    public boolean createSede(SedeDTO dto) {
        try {
            sedeDAO.addSede(SedeMapper.toEntity(dto));
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<SedeDTO> getSedes() {
        try {
            List<Sede> sedes = sedeDAO.getAllSedes();

            return sedes.stream()
                    .map(SedeMapper::toDTO)
                    .toList();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<SedeDTO> searchSedes(SedeDTO dto) {
        try {
            String criterio = ( dto != null && dto.getNombre() != null ) ? dto.getNombre() : "";

            List<Sede> sedes = sedeDAO.searchSede( criterio );

            return sedes.stream()
                    .map( SedeMapper::toDTO )
                    .toList();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public SedeDTO getSedeById(int id) {
        try {
            return SedeMapper.toDTO(sedeDAO.getSedeById(id));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean modifySede(SedeDTO dto) {
        try {
            Sede sede = SedeMapper.toEntity(dto);

            return sedeDAO.updateSede(sede);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteSede(int id) {
        try {
            return sedeDAO.deleteSede(id);
        } catch ( SQLException e ) {
            throw new RuntimeException(e);
        }
    }
}
