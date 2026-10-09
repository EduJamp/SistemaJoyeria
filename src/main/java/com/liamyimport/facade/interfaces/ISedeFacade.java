package com.liamyimport.facade.interfaces;

import com.liamyimport.model.dto.SedeDTO;

import java.util.List;

public interface ISedeFacade {
    boolean createSede(SedeDTO dto);
    List<SedeDTO> getSedes();
    List<SedeDTO> searchSedes(SedeDTO dto);
    SedeDTO getSedeById(int id);
    boolean modifySede(SedeDTO dto);
    boolean deleteSede(int id);

}
