package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.Categoria;
import com.liamyimport.persistence.dao.interfaces.ICategoriaDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO implements ICategoriaDAO {

    public CategoriaDAO() {
    }

    @Override
    public boolean addCategoria(Categoria categoria) throws SQLException {
        String sql = "insert into Categoria( nombre, descripcion ) values( ?, ? )";
        try(Connection connection = ConexionBD.getInstancia().getConexion();
            PreparedStatement ps = connection.prepareStatement( sql, Statement.RETURN_GENERATED_KEYS ) ) {
            ps.setString( 1, categoria.getNombre() );
            ps.setString( 2, categoria.getDescripcion() );

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        categoria.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public Categoria getCategoriaById(int id) throws SQLException {
        String sql = "select * from Categoria where id_categoria = ?";

        try( Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement( sql ) ) {
            ps.setInt( 1, id );
            try (ResultSet rs = ps.executeQuery() ) {
                if ( rs.next() ) {
                    return mapearCategoria( rs );
                }
            }
        }
        return null;
    }

    @Override
    public List<Categoria> getCategorias() throws SQLException {
        List<Categoria> categorias = new ArrayList<>();
        Categoria categoria = new Categoria();

        String sql = "select * from Categoria";

        try( Connection connection = ConexionBD.getInstancia().getConexion();
            PreparedStatement ps = connection.prepareStatement( sql );
            ResultSet rs = ps.executeQuery() ) {
            while ( rs.next() ) {
                categorias.add( mapearCategoria( rs ) );
            }
        }
        return categorias;
    }

    @Override
    public boolean updateCategoria(Categoria categoria) throws SQLException {
        String sql = "update Categoria set nombre = ?, descripcion = ? where id_categoria = ?";

        try( Connection connection = ConexionBD.getInstancia().getConexion();
        PreparedStatement ps = connection.prepareStatement( sql )) {
            ps.setString( 1, categoria.getNombre() );
            ps.setString( 2, categoria.getDescripcion() );
            ps.setInt( 3, categoria.getId() );

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                return true;
            }
            return false;
        }
    }

    @Override
    public boolean deleteCategoria(int id) throws SQLException {
        String sql = "delete from Categoria where id_categoria = ?";

        try ( Connection connection = ConexionBD.getInstancia().getConexion();
        PreparedStatement ps = connection.prepareStatement( sql ) ) {
            ps.setInt( 1, id );
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    @Override
    public List<Categoria> searchCategorias(String criterio) throws SQLException {
        String sql = "select * from Categoria where CAST(id_categoria as text) ilike ? or nombre ilike ? order by id_categoria desc";

        List<Categoria> categorias = new ArrayList<>();

        try( Connection connection = ConexionBD.getInstancia().getConexion();
        PreparedStatement ps = connection.prepareStatement( sql ) ) {
            String patron = "%" + criterio + "%";
            ps.setString(1, patron);
            ps.setString(2, patron);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categorias.add(mapearCategoria(rs));
                }
            }
        }
        return categorias;
    }

    private Categoria mapearCategoria( ResultSet rs ) throws SQLException {
        Categoria categoria = new Categoria();
        categoria.setId( rs.getInt( "id_categoria" ) );
        categoria.setNombre( rs.getString( "nombre" ) );
        categoria.setDescripcion( rs.getString( "descripcion" ) );

        return categoria;
    }
}
