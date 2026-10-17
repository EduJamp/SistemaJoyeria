package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.Categoria;
import com.liamyimport.model.Producto;
import com.liamyimport.persistence.dao.interfaces.IProductoDAO;
import com.liamyimport.util.enums.State;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO implements IProductoDAO {

    public ProductoDAO() {
    }


    @Override
    public boolean addProducto(Producto producto) throws SQLException {
        String sql = "INSERT INTO Producto (codigo_barras, imagen, nombre, descripcion, precio_unidad, " +
                "precio_3, precio_6, precio_12, precio_paquete, estado, id_categoria) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, producto.getCodigoBarras());
            ps.setString(2, producto.getImagen());
            ps.setString(3, producto.getNombre());
            ps.setString(4, producto.getDescripcion());
            ps.setDouble(5, producto.getPrecioUnidad());
            ps.setDouble(6, producto.getPrecioX3());
            ps.setDouble(7, producto.getPrecioX6());
            ps.setDouble(8, producto.getPrecioX12());
            ps.setDouble(9, producto.getPrecioPaquete());
            ps.setString(10, producto.getEstado() != null ? producto.getEstado().toString() : "activo");

            if (producto.getCategoria() != null && producto.getCategoria().getId() > 0) {
                ps.setInt(11, producto.getCategoria().getId());
            } else {
                ps.setNull(11, Types.INTEGER);
            }

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        producto.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public List<Producto> getAllProductos() throws SQLException {
        String sql = "SELECT p.*, c.nombre AS nombre_categoria, COALESCE(s.total_stock, 0) AS total_stock " +
                "FROM Producto p " +
                "LEFT JOIN Categoria c ON p.id_categoria = c.id_categoria " +
                "LEFT JOIN (SELECT id_producto, SUM(cantidad_actual) AS total_stock FROM StockSede GROUP BY id_producto) s " +
                "ON p.id_producto = s.id_producto " +
                "ORDER BY p.id_producto DESC";

        List<Producto> productos = new ArrayList<>();

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                productos.add(mapearProducto(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return productos;
    }

    @Override
    public Producto getProductById(int id) throws SQLException {
        String sql = "SELECT p.*, c.nombre AS nombre_categoria, COALESCE(s.total_stock, 0) AS total_stock " +
                "FROM Producto p " +
                "LEFT JOIN Categoria c ON p.id_categoria = c.id_categoria " +
                "LEFT JOIN (SELECT id_producto, SUM(cantidad_actual) AS total_stock FROM StockSede GROUP BY id_producto) s " +
                "ON p.id_producto = s.id_producto " +
                "WHERE p.id_producto = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearProducto(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Producto> searchProduct(String criterio) throws SQLException {
        List<Producto> productos = new ArrayList<>();

        String sql = "SELECT p.*, c.nombre AS nombre_categoria, COALESCE(s.total_stock, 0) AS total_stock " +
                "FROM Producto p " +
                "LEFT JOIN Categoria c ON p.id_categoria = c.id_categoria " +
                "LEFT JOIN (SELECT id_producto, SUM(cantidad_actual) AS total_stock FROM StockSede GROUP BY id_producto) s " +
                "ON p.id_producto = s.id_producto " +
                "WHERE p.codigo_barras ILIKE ? OR p.nombre ILIKE ? " +
                "ORDER BY p.id_producto DESC";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            String patron = "%" + criterio + "%";
            ps.setString(1, patron);
            ps.setString(2, patron);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    productos.add(mapearProducto(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return productos;
    }

    @Override
    public boolean updateProducto(Producto producto) throws SQLException {
        String sql = "UPDATE Producto SET codigo_barras = ?, imagen = ?, nombre = ?, descripcion = ?, " +
                "precio_unidad = ?, precio_3 = ?, precio_6 = ?, precio_12 = ?, precio_paquete = ?, " +
                "estado = ?, id_categoria = ? WHERE id_producto = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, producto.getCodigoBarras());
            ps.setString(2, producto.getImagen());
            ps.setString(3, producto.getNombre());
            ps.setString(4, producto.getDescripcion());
            ps.setDouble(5, producto.getPrecioUnidad());
            ps.setDouble(6, producto.getPrecioX3());
            ps.setDouble(7, producto.getPrecioX6());
            ps.setDouble(8, producto.getPrecioX12());
            ps.setDouble(9, producto.getPrecioPaquete());
            ps.setString(10, producto.getEstado() != null ? producto.getEstado().toString() : "activo");

            if (producto.getCategoria() != null && producto.getCategoria().getId() > 0) {
                ps.setInt(11, producto.getCategoria().getId());
            } else {
                ps.setNull(11, Types.INTEGER);
            }

            ps.setInt(12, producto.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteProducto(int id) throws SQLException {
        String sql = "DELETE FROM Producto WHERE id_producto = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void registerStockInitial(int idProducto, int idSede, int cantidad) throws SQLException {
        String sql = "INSERT INTO StockSede (id_producto, id_sede, cantidad_actual) VALUES (?, ?, ?)";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            ps.setInt(2, idSede);
            ps.setInt(3, cantidad);
            ps.executeUpdate();
        }
    }

    @Override
    public boolean updateStock(int idProducto, int idSede, int nuevaCantidad) throws SQLException {
        String sql = "UPDATE StockSede SET cantidad_actual = ? WHERE id_producto = ? AND id_sede = ?";
        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, nuevaCantidad);
            ps.setInt(2, idProducto);
            ps.setInt(3, idSede);
            return ps.executeUpdate() > 0;
        }
    }



    private Producto mapearProducto(ResultSet rs) throws SQLException {
        Producto p = new Producto();

        p.setId(rs.getInt("id_producto"));
        p.setCodigoBarras(rs.getString("codigo_barras"));
        p.setImagen(rs.getString("imagen"));
        p.setNombre(rs.getString("nombre"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setPrecioUnidad(rs.getDouble("precio_unidad"));
        p.setPrecioX3(rs.getDouble("precio_3"));
        p.setPrecioX6(rs.getDouble("precio_6"));
        p.setPrecioX12(rs.getDouble("precio_12"));
        p.setPrecioPaquete(rs.getDouble("precio_paquete"));

        p.setEstado(State.valueOf( rs.getString("estado") ));

        p.setCantidad(rs.getInt("total_stock"));

        int idCategoria = rs.getInt("id_categoria");
        Categoria cat = new Categoria();

        if (!rs.wasNull()) {
            cat.setId(idCategoria);
            try {
                String nombreCategoria = rs.getString("nombre_categoria");
                cat.setNombre(nombreCategoria != null ? nombreCategoria : "Sin categoría");
            } catch (SQLException e) {
                cat.setNombre("Sin categoría");
            }
        } else {
            cat.setId(0);
            cat.setNombre("General");
        }
        p.setCategoria(cat);

        return p;
    }
}
