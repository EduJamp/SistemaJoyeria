package com.liamyimport.facade.interfaces;

import com.liamyimport.model.dto.UsuarioDTO;

import java.util.List;

public interface IUsuarioFacade {
    boolean addUser(UsuarioDTO dto);
    List<UsuarioDTO> getAllUsers();
    List<UsuarioDTO> searchUsers(UsuarioDTO dto);
    boolean updateUser(UsuarioDTO dto);
    boolean deleteUser(int id);
    UsuarioDTO getUserById(int id);
}
