package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.Cliente;
import com.liamyimport.persistence.dao.interfaces.IClienteDAO;
import com.liamyimport.util.enums.State;
import com.liamyimport.util.enums.TypeIdentityDocument;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO implements IClienteDAO {

    public ClienteDAO() {
    }

    @Override
    public boolean addCliente(Cliente cliente) throws SQLException {
        String sql = "insert into Cliente( nombre, apellido, tipo_documento, numero_documento, telefono, direccion, fecha_nacimiento, email, tipo_cliente, estado )"
                + " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( Connection connection = ConexionBD.getInstancia().getConexion();
              PreparedStatement ps = connection.prepareStatement( sql, Statement.RETURN_GENERATED_KEYS ) ) {
            ps.setString( 1, cliente.getNombre() );
            ps.setString( 2, cliente.getApellido() );
            ps.setString( 3, cliente.getTipoDocumento().name() );
            ps.setString( 4, String.valueOf( cliente.getNumeroDocumento() ) );
            ps.setString( 5, String.valueOf( cliente.getTelefono() ) );
            ps.setString( 6, cliente.getDireccion() );
            ps.setObject( 7, cliente.getFechaNacimiento() );
            ps.setString( 8, cliente.getEmail() );
            ps.setString( 9, cliente.getTipoCliente() );
            ps.setString(10, cliente.getEstado().name() );

            int rowAffected = ps.executeUpdate();
            if ( rowAffected > 0 ) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        cliente.setId_cliente(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public Cliente getClienteById(int id) throws SQLException {
        String sql = "SELECT c.id_cliente, c.nombre, c.apellido, c.tipo_documento, " +
                "c.numero_documento, c.telefono, c.direccion, c.fecha_nacimiento, c.email, c.tipo_cliente, c.estado, " +
                "COUNT(v.id_venta) AS numero_compras, " +
                "COALESCE(SUM(v.total), 0.00) AS total_comprado, " +
                "MAX(v.fecha_venta) AS ultima_compra " +
                "FROM Cliente c " +
                "LEFT JOIN Venta v ON c.id_cliente = v.id_cliente " +
                "WHERE c.id_cliente = ? " +
                "GROUP BY c.id_cliente";

        try ( Connection connection = ConexionBD.getInstancia().getConexion();
              PreparedStatement ps = connection.prepareStatement( sql ) ) {
            ps.setInt(1,id);
            try ( ResultSet rs = ps.executeQuery() ) {
                if ( rs.next() ) {
                    return mapearCliente(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<Cliente> getAllClientes() throws SQLException {
        List<Cliente> clientes = new ArrayList<>();

        String sql = "SELECT c.id_cliente, c.nombre, c.apellido, c.tipo_documento, " +
                "c.numero_documento, c.telefono, c.direccion, c.fecha_nacimiento, c.email, c.tipo_cliente, c.estado, " +
                "COUNT(v.id_venta) AS numero_compras, " +
                "COALESCE(SUM(v.total), 0.00) AS total_comprado, " +
                "MAX(v.fecha_venta) AS ultima_compra " +
                "FROM Cliente c " +
                "LEFT JOIN Venta v ON c.id_cliente = v.id_cliente " +
                "GROUP BY c.id_cliente " +
                "ORDER BY c.id_cliente DESC";

        try (Connection conn = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cliente cliente = mapearCliente(rs);

                clientes.add(cliente);
            }
        }
        return clientes;
    }

    @Override
    public boolean updateCliente(Cliente cliente) throws SQLException {
        String sql = "update Cliente set " +
                "nombre=?, apellido=?, tipo_documento=?, numero_documento=?, telefono=?, direccion=?, fecha_nacimiento=?, email=?, tipo_cliente=?, estado=? where id_cliente=?";

        try ( Connection connection = ConexionBD.getInstancia().getConexion();
              PreparedStatement ps = connection.prepareStatement( sql ) ) {
            ps.setString( 1, cliente.getNombre() );
            ps.setString( 2, cliente.getApellido() );
            ps.setString( 3, cliente.getTipoDocumento().name() );
            ps.setString( 4, String.valueOf( cliente.getNumeroDocumento() ) );
            ps.setString( 5, String.valueOf( cliente.getTelefono() ) );
            ps.setString( 6, cliente.getDireccion() );
            ps.setObject( 7, cliente.getFechaNacimiento() );
            ps.setString( 8, cliente.getEmail() );
            ps.setString( 9, cliente.getTipoCliente() );
            ps.setString(10, cliente.getEstado().name() );
            ps.setInt( 11, cliente.getId_cliente() );

            int rowAffected = ps.executeUpdate();

            return rowAffected > 0;
        }
    }

    @Override
    public boolean deleteCliente(int id) throws SQLException {
        String  sql = "delete from Cliente where id_cliente = ? ";

        try ( Connection connection = ConexionBD.getInstancia().getConexion();
              PreparedStatement ps = connection.prepareStatement( sql ) ) {
            ps.setInt( 1,id) ;

            int rowAffected = ps.executeUpdate();

            return rowAffected > 0;
        }
    }

    @Override
    public List<Cliente> searchCliente(String criterio) throws SQLException {
        List<Cliente> clientes = new ArrayList<>();
        Cliente cliente = new Cliente();

        String sql = "SELECT c.id_cliente, c.nombre, c.apellido, c.tipo_documento, " +
                "c.numero_documento, c.telefono, c.direccion, c.fecha_nacimiento, c.email, c.tipo_cliente, c.estado, " +
                "COUNT(v.id_venta) AS numero_compras, " +
                "COALESCE(SUM(v.total), 0.00) AS total_comprado, " +
                "MAX(v.fecha_venta) AS ultima_compra " +
                "FROM Cliente c " +
                "LEFT JOIN Venta v ON c.id_cliente = v.id_cliente " +
                "WHERE CAST(c.id_cliente AS text) ILIKE ? OR c.nombre ILIKE ? OR c.apellido ILIKE ? OR c.numero_documento ILIKE ? " +
                "GROUP BY c.id_cliente " +
                "ORDER BY c.id_cliente DESC";

        try ( Connection connection = ConexionBD.getInstancia().getConexion();
              PreparedStatement ps = connection.prepareStatement( sql ) ) {
            String patron = "%" + criterio + "%";
            ps.setString( 1, patron );
            ps.setString( 2, patron );
            ps.setString( 3, patron );
            ps.setString( 4, patron );

            try ( ResultSet rs = ps.executeQuery() ) {
                while ( rs.next() ) {
                    clientes.add(mapearCliente( rs ));
                }
            }
        }
        return clientes;
    }

    public Cliente mapearCliente(ResultSet rs) throws SQLException {
        Cliente cliente = new Cliente();

        cliente.setId_cliente( rs.getInt( "id_cliente" ) );
        cliente.setNombre( rs.getString( "nombre" ) );
        cliente.setApellido( rs.getString( "apellido" ) );
        String tipoDocumento = rs.getString( "tipo_documento" );
        cliente.setTipoDocumento( TypeIdentityDocument.valueOf( tipoDocumento ) );
        cliente.setNumeroDocumento( Integer.parseInt( rs.getString( "numero_documento" ) ) );
        cliente.setTelefono( Integer.parseInt( rs.getString( "telefono" ) ) );
        cliente.setDireccion( rs.getString( "direccion" ) );
        cliente.setFechaNacimiento( rs.getObject( "fecha_nacimiento", LocalDate.class ) );
        cliente.setEmail( rs.getString( "email" ) );
        cliente.setTipoCliente( rs.getString( "tipo_cliente" ) );
        String tipo_cliente = rs.getString( "estado"  );
        cliente.setEstado( State.valueOf( tipo_cliente ) );
        cliente.setNumeroCompras(rs.getInt("numero_compras"));
        cliente.setTotalComprado(rs.getDouble("total_comprado"));
        LocalDate date = rs.getObject("ultima_compra", LocalDate.class);
        cliente.setUltimaCompra( date );

        return cliente;
    }
}
