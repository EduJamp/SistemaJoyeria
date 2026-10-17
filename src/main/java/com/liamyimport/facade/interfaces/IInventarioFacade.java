package com.liamyimport.facade.interfaces;

import com.liamyimport.model.dto.InventarioDTO;

import java.util.List;

public interface IInventarioFacade {
    boolean addInventario(InventarioDTO dto);
    List<InventarioDTO> getAllInventarios();
    List<InventarioDTO> searchInventarios(InventarioDTO dto);
    boolean updateInventario(InventarioDTO dto);
    boolean deleteInventario(int id);
    InventarioDTO getInventarioById(int id);
}
