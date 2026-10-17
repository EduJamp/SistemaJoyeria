package com.liamyimport.persistence.dao.interfaces;

import com.liamyimport.model.Usuario;

import java.sql.SQLException;
import java.util.List;

public interface IUsuarioDAO {
    boolean addUser(Usuario usuario) throws SQLException;
    List<Usuario> getAllUsers() throws SQLException;
    List<Usuario> searchUsers(String criterio) throws SQLException;
    boolean updateUser(Usuario usuario) throws SQLException;
    boolean deleteUser(int id) throws SQLException;
    Usuario getUserById(int id) throws SQLException;
}
