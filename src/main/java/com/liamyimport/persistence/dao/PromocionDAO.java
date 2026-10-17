package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.Promocion;
import com.liamyimport.persistence.dao.interfaces.IPromocionDAO;
import com.liamyimport.util.enums.StatePromotion;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PromocionDAO implements IPromocionDAO {

    public PromocionDAO() {
    }

    @Override
    public boolean addPromotion(Promocion promocion) throws SQLException {
        String sql = "insert into Promocion (nombre, estado, descripcion, fecha_inicio, fecha_fin, porcentaje_descuento, color_fondo, id_sede) " +
                "values (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement( sql,  Statement.RETURN_GENERATED_KEYS ) ) {
            ps.setString( 1, promocion.getNombre() );
            ps.setString( 2, promocion.getEstado().name() );
            ps.setString( 3, promocion.getDescripcion() );
            ps.setObject( 4, promocion.getFechaInicio() );
            ps.setObject( 5, promocion.getFechaFin() );
            ps.setDouble( 6, promocion.getPorcentajeDescuento() );
            ps.setString( 7, promocion.getColorFondo() );
            ps.setInt( 8, promocion.getSede() );

            int rowsAffected = ps.executeUpdate();

            if ( rowsAffected > 0 ) {
                try ( ResultSet generatedKeys = ps.getGeneratedKeys() ) {
                    if ( generatedKeys.next() ) {
                        ps.setInt( 1, generatedKeys.getInt( 1 ) );
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public List<Promocion> getAllPromotions() throws SQLException {
        String sql = "SELECT p.*, s.nombre AS nombre_sede " +
                "FROM Promocion p " +
                "LEFT JOIN Sede s ON p.id_sede = s.id_sede " +
                "ORDER BY p.id_promocion DESC";

        List<Promocion> promotions = new ArrayList<>();

        try ( Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery() ) {

            while ( rs.next() ) {
                promotions.add( mapearPromocion( rs ) );
            }
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
        return promotions;
    }

    @Override
    public List<Promocion> searchPromotion(String criterio) throws SQLException {
        List<Promocion> promotions = new ArrayList<>();

        String sql = "SELECT p.*, s.nombre AS nombre_sede " +
                "FROM Promocion p " +
                "LEFT JOIN Sede s ON p.id_sede = s.id_sede " +
                "WHERE CAST(p.id_promocion AS text) ILIKE ? OR p.nombre ILIKE ? " +
                "ORDER BY p.id_promocion DESC";

        try ( Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement( sql ) ) {

            String patron = "%" + criterio + "%";
            ps.setString( 1, patron );
            ps.setString( 2, patron );

            try (ResultSet rs = ps.executeQuery()) {
                while ( rs.next() ) {
                    promotions.add( mapearPromocion( rs ) );
                }
            }
        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
        return promotions;
    }

    @Override
    public boolean updatePromotion(Promocion promocion) throws SQLException {
        String sql = "UPDATE Promocion SET nombre = ?, estado = ?, descripcion = ?, fecha_inicio = ?, fecha_fin = ?, " +
                "porcentaje_descuento = ?, color_fondo = ?, id_sede = ? WHERE id_promocion = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString( 1, promocion.getNombre() );
            ps.setString( 2, promocion.getEstado() != null ? promocion.getEstado().toString() : "activo" );
            ps.setString( 3, promocion.getDescripcion() );
            ps.setObject( 4, promocion.getFechaInicio() );
            ps.setObject( 5, promocion.getFechaFin() );
            ps.setDouble( 6, promocion.getPorcentajeDescuento() );
            ps.setString( 7, promocion.getColorFondo() );
            ps.setInt( 8, promocion.getSede() );
            ps.setInt( 9, promocion.getIdPromocion() );

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch ( SQLException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    public boolean deletePromotion(int id) throws SQLException {
        String sql = "DELETE FROM Promocion WHERE id_promocion = ?";

        try ( Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement( sql ) ) {

            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            throw new RuntimeException( e );
        }
    }

    private Promocion mapearPromocion(ResultSet rs) throws SQLException {
        Promocion p = new Promocion();

        p.setIdPromocion( rs.getInt( "id_promocion" ) );
        p.setNombre( rs.getString( "nombre" )  );
        String estado = rs.getString( "estado" ).toLowerCase();
        p.setEstado( StatePromotion.valueOf( estado ) );
        p.setDescripcion( rs.getString("descripcion" ) );
        p.setFechaInicio( rs.getObject( "fecha_inicio", LocalDate.class) );
        p.setFechaFin( rs.getObject( "fecha_fin", LocalDate.class ) );
        p.setPorcentajeDescuento( rs.getDouble( "porcentaje_descuento" ) );
        p.setColorFondo(rs.getString( "color_fondo" ) );

        int idSede = rs.getInt( "id_sede" );
        if ( !rs.wasNull() ) {
            p.setSede( idSede );
        } else {
            p.setSede( 0 );
        }

        try {
            String nombreSede = rs.getString( "nombre_sede" );
            if ( nombreSede != null ) {
                p.setNombre_sede( nombreSede );
            } else {
                p.setNombre_sede( "Sin sede asignada" ); // Texto por defecto si id_sede era null
            }
        } catch ( SQLException e ) {
            throw  new RuntimeException( e );
        }

        return p;
    }
}
