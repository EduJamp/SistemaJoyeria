package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.Inventario;
import com.liamyimport.persistence.dao.interfaces.IInventarioDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventarioDAO implements IInventarioDAO {

    public InventarioDAO() {
    }

    @Override
    public boolean addInventario(Inventario inventario) throws SQLException {
        String sql = "INSERT INTO Inventario (stock_sistema, stock_fisico, faltantes, sobrantes, impacto, estado, id_sede, id_empleado, id_producto) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, inventario.getStockSistema());
            ps.setInt(2, inventario.getStockFisico());
            ps.setInt(3, inventario.getFaltantes());
            ps.setInt(4, inventario.getSobrantes());
            ps.setDouble(5, inventario.getImpacto());
            ps.setString(6, inventario.getEstado());

            if (inventario.getIdSede() > 0) {
                ps.setInt(7, inventario.getIdSede());
            } else {
                ps.setNull(7, Types.INTEGER);
            }

            if (inventario.getIdEmpleado() > 0) {
                ps.setInt(8, inventario.getIdEmpleado());
            } else {
                ps.setNull(8, Types.INTEGER);
            }

            if (inventario.getIdProducto() > 0) {
                ps.setInt(9, inventario.getIdProducto());
            } else {
                ps.setNull(9, Types.INTEGER);
            }

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        inventario.setIdInventario(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public List<Inventario> getAllInventarios() throws SQLException {
        String sql = "SELECT i.*, p.nombre AS prod_nombre, p.codigo_barras AS prod_codigo, s.nombre AS sede_nombre, e.nombre || ' ' || e.apellido AS emp_nombre " +
                "FROM Inventario i " +
                "LEFT JOIN Producto p ON i.id_producto = p.id_producto " +
                "LEFT JOIN Sede s ON i.id_sede = s.id_sede " +
                "LEFT JOIN Empleado e ON i.id_empleado = e.id_empleado " +
                "ORDER BY i.id_inventario DESC";

        List<Inventario> lista = new ArrayList<>();
        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Inventario inv = mapearInventario(rs);
                lista.add(inv);
            }
        }
        return lista;
    }

    @Override
    public List<Inventario> searchInventarios(String criterio) throws SQLException {
        String sql = "SELECT i.*, p.nombre AS prod_nombre, s.nombre AS sede_nombre, e.nombre AS emp_nombre " +
                "FROM Inventario i " +
                "LEFT JOIN Producto p ON i.id_producto = p.id_producto " +
                "LEFT JOIN Sede s ON i.id_sede = s.id_sede " +
                "LEFT JOIN Empleado e ON i.id_empleado = e.id_empleado " +
                "WHERE p.nombre ILIKE ? OR i.estado ILIKE ? " +
                "ORDER BY i.id_inventario DESC";

        List<Inventario> lista = new ArrayList<>();

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String patron = "%" + criterio + "%";
            ps.setString(1, patron);
            ps.setString(2, patron);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearInventario(rs));
                }
            }
        }
        return lista;
    }

    @Override
    public boolean updateInventario(Inventario inventario) throws SQLException {
        String sql = "UPDATE Inventario SET stock_sistema = ?, stock_fisico = ?, faltantes = ?, sobrantes = ?, impacto = ?, estado = ?, id_sede = ?, id_empleado = ?, id_producto = ? " +
                "WHERE id_inventario = ?";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, inventario.getStockSistema());
            ps.setInt(2, inventario.getStockFisico());
            ps.setInt(3, inventario.getFaltantes());
            ps.setInt(4, inventario.getSobrantes());
            ps.setDouble(5, inventario.getImpacto());
            ps.setString(6, inventario.getEstado());

            if (inventario.getIdSede() > 0) {
                ps.setInt(7, inventario.getIdSede());
            } else {
                ps.setNull(7, Types.INTEGER);
            }

            if (inventario.getIdEmpleado() > 0) {
                ps.setInt(8, inventario.getIdEmpleado());
            } else {
                ps.setNull(8, Types.INTEGER);
            }

            if (inventario.getIdProducto() > 0) {
                ps.setInt(9, inventario.getIdProducto());
            } else {
                ps.setNull(9, Types.INTEGER);
            }

            ps.setInt(10, inventario.getIdInventario());

            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteInventario(int id) throws SQLException {
        String sql = "DELETE FROM Inventario WHERE id_inventario = ?";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public Inventario getInventarioById(int id) throws SQLException {
        String sql = "SELECT i.*, p.nombre AS prod_nombre, s.nombre AS sede_nombre, e.nombre AS emp_nombre " +
                "FROM Inventario i " +
                "LEFT JOIN Producto p ON i.id_producto = p.id_producto " +
                "LEFT JOIN Sede s ON i.id_sede = s.id_sede " +
                "LEFT JOIN Empleado e ON i.id_empleado = e.id_empleado " +
                "WHERE i.id_inventario = ?";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearInventario(rs);
                }
            }
        }
        return null;
    }

    private Inventario mapearInventario(ResultSet rs) throws SQLException {
        Inventario inv = new Inventario();

        inv.setIdInventario(rs.getInt("id_inventario"));
        inv.setStockSistema(rs.getInt("stock_sistema"));
        inv.setStockFisico(rs.getInt("stock_fisico"));
        inv.setFaltantes(rs.getInt("faltantes"));
        inv.setSobrantes(rs.getInt("sobrantes"));
        inv.setImpacto(rs.getDouble("impacto"));
        inv.setEstado(rs.getString("estado"));

        Timestamp fecha = rs.getTimestamp("fecha_conteo");
        if (fecha != null) {
            inv.setFechaConteo(fecha.toString());
        }

        inv.setIdSede(rs.getInt("id_sede"));
        inv.setIdEmpleado(rs.getInt("id_empleado"));
        inv.setIdProducto(rs.getInt("id_producto"));

        return inv;
    }
}
