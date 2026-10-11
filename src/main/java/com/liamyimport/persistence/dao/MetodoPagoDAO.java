package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.MetodoPago;
import com.liamyimport.persistence.dao.interfaces.IMetodoPagoDAO;
import com.liamyimport.util.enums.State;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MetodoPagoDAO implements IMetodoPagoDAO {

    public MetodoPagoDAO() {
    }

    @Override
    public boolean addMetodoPago(MetodoPago metodo_pago) throws SQLException {
        String sql = "insert into MetodoPago( nombre, estado ) values( ?, ? )";

        try (Connection conexion = ConexionBD.getInstancia().getConexion();
             PreparedStatement  ps =  conexion.prepareStatement( sql, Statement.RETURN_GENERATED_KEYS ) ) {
            ps.setString( 1, metodo_pago.getNombre() );
            ps.setString( 2, metodo_pago.getEstado().name() );

            int rowAffected = ps.executeUpdate();
            if ( rowAffected > 0 ) {
                try ( ResultSet generatedKeys = ps.getGeneratedKeys() ) {
                    if ( generatedKeys.next() ) {
                        metodo_pago.setId_metodo_pago( generatedKeys.getInt( 1 ) );
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public List<MetodoPago> getMetodoPagos() throws SQLException {
        List<MetodoPago> metodoPagos = new ArrayList<>();

        String sql = "select * from MetodoPago";

        try (Connection conexion = ConexionBD.getInstancia().getConexion();
            PreparedStatement ps  = conexion.prepareStatement( sql )) {
            ResultSet rs = ps.executeQuery();
            while ( rs.next() ) {
                metodoPagos.add( mapearMetodoPago(rs) );
            }
        }
        return metodoPagos;
    }

    @Override
    public List<MetodoPago> searchMetodoPago(String criterio) throws SQLException {
        List<MetodoPago> metodoPagos = new ArrayList<>();

        String sql = "select * from MetodoPago where CAST( id_metodo_pago as text ) ilike ? or nombre ilike ? order by id_metodo_pago";

        try (Connection conexion = ConexionBD.getInstancia().getConexion();
        PreparedStatement ps  = conexion.prepareStatement( sql )) {
            String patron = "%" + criterio + "%";
            ps.setString( 1, patron );
            ps.setString( 2, patron );

            try (ResultSet rs = ps.executeQuery() ) {
                while ( rs.next() ) {
                    metodoPagos.add( mapearMetodoPago(rs) );
                }
            }
        }
        return metodoPagos;
    }

    @Override
    public boolean updateMetodoPago(MetodoPago metodo_pago) throws SQLException {
        String sql = "update MetodoPago set nombre = ?, estado = ? where id_metodo_pago = ?";

        try ( Connection conexion = ConexionBD.getInstancia().getConexion();
        PreparedStatement ps = conexion.prepareStatement( sql ) ) {
            ps.setString( 1, metodo_pago.getNombre() );
            ps.setString( 2, metodo_pago.getEstado().name() );
            ps.setInt( 3, metodo_pago.getId_metodo_pago() );

            int rowAffected = ps.executeUpdate();

            return rowAffected > 0;
        }
    }

    @Override
    public boolean deleteMetodoPago(int id) throws SQLException {
        String sql = "delete from MetodoPago where id_metodo_pago = ?";

        try ( Connection conexion = ConexionBD.getInstancia().getConexion();
            PreparedStatement ps = conexion.prepareStatement( sql ) ) {
            ps.setInt( 1, id );

            int rowAffected = ps.executeUpdate();

            return rowAffected > 0;
        }
    }

    private MetodoPago mapearMetodoPago(ResultSet rs) throws SQLException {
        MetodoPago metodo_pago = new MetodoPago();
        metodo_pago.setId_metodo_pago( rs.getInt( "id_metodo_pago" ) );
        metodo_pago.setNombre( rs.getString( "nombre" ) );
        String estado = rs.getString( "estado" );
        metodo_pago.setEstado(State.valueOf( estado ) );

        return metodo_pago;
    }
}
