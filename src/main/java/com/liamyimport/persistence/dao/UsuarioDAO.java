package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.Empleado;
import com.liamyimport.model.Usuario;
import com.liamyimport.persistence.dao.interfaces.IUsuarioDAO;
import com.liamyimport.util.enums.Rol;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO implements IUsuarioDAO {

    public UsuarioDAO() {
    }

    @Override
    public boolean addUser(Usuario usuario) throws SQLException {
        String sql = "INSERT INTO Usuario (nombre_usuario, password, rol, id_empleado) VALUES (?, ?, ?, ?)";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, usuario.getNombreUsuario());
            ps.setString(2, usuario.getPassword());
            ps.setString(3, usuario.getRol() != null ? usuario.getRol().name() : null);

            if (usuario.getEmpleado() != null && usuario.getEmpleado().getIdEmpleado() > 0) {
                ps.setInt(4, usuario.getEmpleado().getIdEmpleado());
            } else {
                ps.setNull(4, Types.INTEGER);
            }

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        usuario.setIdUsuario(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public List<Usuario> getAllUsers() throws SQLException {
        String sql = "SELECT u.*, e.nombre AS emp_nombre, e.apellido AS emp_apellido, e.numero_documento AS emp_doc " +
                "FROM Usuario u " +
                "LEFT JOIN Empleado e ON u.id_empleado = e.id_empleado " +
                "ORDER BY u.id_usuario DESC";

        List<Usuario> usuarios = new ArrayList<>();

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }
        }
        return usuarios;
    }

    @Override
    public List<Usuario> searchUsers(String criterio) throws SQLException {
        String sql = "SELECT u.*, e.nombre AS emp_nombre, e.apellido AS emp_apellido, e.numero_documento AS emp_doc " +
                "FROM Usuario u " +
                "LEFT JOIN Empleado e ON u.id_empleado = e.id_empleado " +
                "WHERE u.nombre_usuario ILIKE ? OR e.nombre ILIKE ? OR e.apellido ILIKE ? " +
                "ORDER BY u.id_usuario DESC";

        List<Usuario> usuarios = new ArrayList<>();

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            String patron = "%" + criterio + "%";
            ps.setString(1, patron);
            ps.setString(2, patron);
            ps.setString(3, patron);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    usuarios.add(mapearUsuario(rs));
                }
            }
        }
        return usuarios;
    }

    @Override
    public boolean updateUser(Usuario usuario) throws SQLException {
        String sql = "UPDATE Usuario SET nombre_usuario = ?, password = ?, rol = ?, id_empleado = ? WHERE id_usuario = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombreUsuario());
            ps.setString(2, usuario.getPassword());
            ps.setString(3, usuario.getRol() != null ? usuario.getRol().name() : null);

            if (usuario.getEmpleado() != null && usuario.getEmpleado().getIdEmpleado() > 0) {
                ps.setInt(4, usuario.getEmpleado().getIdEmpleado());
            } else {
                ps.setNull(4, Types.INTEGER);
            }

            ps.setInt(5, usuario.getIdUsuario());

            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM Usuario WHERE id_usuario = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public Usuario getUserById(int id) throws SQLException {
        String sql = "SELECT u.*, e.nombre AS emp_nombre, e.apellido AS emp_apellido, e.numero_documento AS emp_doc " +
                "FROM Usuario u " +
                "LEFT JOIN Empleado e ON u.id_empleado = e.id_empleado " +
                "WHERE u.id_usuario = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearUsuario(rs);
                }
            }
        }
        return null;
    }

    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();

        u.setIdUsuario(rs.getInt("id_usuario"));
        u.setNombreUsuario(rs.getString("nombre_usuario"));
        u.setPassword(rs.getString("password"));

        String rolStr = rs.getString("rol");
        if (rolStr != null && !rolStr.isEmpty()) {
            try {
                u.setRol(Rol.valueOf(rolStr));
            } catch (IllegalArgumentException ex) {
                u.setRol(null);
            }
        }

        int idEmpleado = rs.getInt("id_empleado");
        if (!rs.wasNull() && idEmpleado > 0) {
            Empleado empleado = new Empleado();
            empleado.setIdEmpleado(idEmpleado);
            empleado.setNombre(rs.getString("emp_nombre"));
            empleado.setApellido(rs.getString("emp_apellido"));

            String numDoc = rs.getString("emp_doc");
            try {
                empleado.setNumeroDocumento(numDoc != null && !numDoc.isEmpty() ? Integer.parseInt(numDoc.trim()) : 0);
            } catch (NumberFormatException e) {
                empleado.setNumeroDocumento(0);
            }

            u.setEmpleado(empleado);
        }

        return u;
    }
}
