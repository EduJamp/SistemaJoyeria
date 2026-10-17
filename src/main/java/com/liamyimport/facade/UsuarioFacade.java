package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.IUsuarioFacade;
import com.liamyimport.mapper.UsuarioMapper;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.UsuarioDTO;
import com.liamyimport.persistence.dao.UsuarioDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioFacade implements IUsuarioFacade {
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    public boolean addUser(UsuarioDTO dto) {
        try {
            if (dto != null && dto.getNombreUsuario() != null && !dto.getNombreUsuario().trim().isEmpty()) {
                Usuario usuario = UsuarioMapper.toEntity(dto);
                return usuarioDAO.addUser(usuario);
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<UsuarioDTO> getAllUsers() {
        try {
            List<Usuario> usuarios = usuarioDAO.getAllUsers();

            if (usuarios != null && !usuarios.isEmpty()) {
                return usuarios.stream()
                        .map(UsuarioMapper::toDTO)
                        .toList();
            }
            return new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<UsuarioDTO> searchUsers(UsuarioDTO dto) {
        String criterio = (dto != null && dto.getNombreUsuario() != null) ? dto.getNombreUsuario() : "";

        try {
            List<Usuario> usuarios = usuarioDAO.searchUsers(criterio);

            if (usuarios != null && !usuarios.isEmpty()) {
                return usuarios.stream()
                        .map(UsuarioMapper::toDTO)
                        .toList();
            }
            return new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateUser(UsuarioDTO dto) {
        try {
            if (dto != null && dto.getIdUsuario() > 0 && dto.getNombreUsuario() != null && !dto.getNombreUsuario().trim().isEmpty()) {
                Usuario usuario = UsuarioMapper.toEntity(dto);
                return usuarioDAO.updateUser(usuario);
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteUser(int id) {
        try {
            if (id > 0) {
                return usuarioDAO.deleteUser(id);
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public UsuarioDTO getUserById(int id) {
        try {
            if (id > 0) {
                Usuario usuario = usuarioDAO.getUserById(id);
                return usuario != null ? UsuarioMapper.toDTO(usuario) : new UsuarioDTO();
            }
            return new UsuarioDTO();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
