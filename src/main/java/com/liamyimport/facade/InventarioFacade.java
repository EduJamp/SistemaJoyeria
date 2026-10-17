package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.IInventarioFacade;
import com.liamyimport.mapper.InventarioMapper;
import com.liamyimport.model.Inventario;
import com.liamyimport.model.dto.InventarioDTO;
import com.liamyimport.persistence.dao.InventarioDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InventarioFacade implements IInventarioFacade {
    private InventarioDAO inventarioDAO = new InventarioDAO();

    @Override
    public boolean addInventario(InventarioDTO dto) {
        try {
            if (dto != null) {
                Inventario entidad = InventarioMapper.toEntity(dto);
                return inventarioDAO.addInventario(entidad);
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<InventarioDTO> getAllInventarios() {
        try {
            List<Inventario> lista = inventarioDAO.getAllInventarios();

            if (lista != null && !lista.isEmpty()) {
                return lista.stream()
                        .map(InventarioMapper::toDTO)
                        .toList();
            }
            return new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<InventarioDTO> searchInventarios(InventarioDTO dto) {
        String criterio = (dto != null && dto.getEstado() != null) ? dto.getEstado() : "";

        try {
            List<Inventario> lista = inventarioDAO.searchInventarios(criterio);

            if (lista != null && !lista.isEmpty()) {
                return lista.stream()
                        .map(InventarioMapper::toDTO)
                        .toList();
            }
            return new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateInventario(InventarioDTO dto) {
        try {
            if (dto != null && dto.getIdInventario() > 0) {
                Inventario entidad = InventarioMapper.toEntity(dto);
                return inventarioDAO.updateInventario(entidad);
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteInventario(int id) {
        try {
            if (id > 0) {
                return inventarioDAO.deleteInventario(id);
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }    }

    @Override
    public InventarioDTO getInventarioById(int id) {
        try {
            if (id > 0) {
                Inventario entidad = inventarioDAO.getInventarioById(id);
                return entidad != null ? InventarioMapper.toDTO(entidad) : new InventarioDTO();
            }
            return new InventarioDTO();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }    }
}
