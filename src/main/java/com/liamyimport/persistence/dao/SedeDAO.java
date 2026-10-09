package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.Sede;
import com.liamyimport.persistence.dao.interfaces.ISedeDAO;
import com.liamyimport.util.enums.State;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


public class SedeDAO implements ISedeDAO {

    private final Connection connection = ConexionBD.getInstancia().getConexion();

    public SedeDAO() {
    }

    @Override
    public boolean addSede(Sede sede) throws SQLException {
        String sql = "insert into Sede( nombre, direccion, ciudad, telefono, es_principal, estado )" +
                "values( ?, ? ,? ,? ,? ,? )";

        try(PreparedStatement ps = connection.prepareStatement(sql,  Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, sede.getNombre());
            ps.setString(2, sede.getDireccion());
            ps.setString(3, sede.getCiudad());
            ps.setString(4, sede.getTelefono());
            ps.setBoolean(5, sede.getEsPrincipal());
            ps.setString(6, sede.getEstado().name());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        sede.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public Sede getSedeById(int id) throws SQLException {
        String sql = "select * from Sede where id_sede = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql) ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearSede(rs);
                }
            }
        }
        return null;
    }

    @Override
    public List<Sede> getAllSedes() throws SQLException {
        List<Sede> sedes = new ArrayList<>();
        Sede sede = new Sede();
        String sql = "select * from Sede";

        try( PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery() ) {
            while ( rs.next() ) {
                sedes.add(mapearSede(rs));
            }
            return sedes; // retornamos la lista
        }
    }

    @Override
    public boolean updateSede(Sede sede) throws SQLException {
        String sql = "update Sede set nombre=?, direccion=?, ciudad=?, telefono=?, es_principal=?, estado=? where id_sede=?";

        try( PreparedStatement ps = connection.prepareStatement(sql) ) {
            ps.setString(1, sede.getNombre());
            ps.setString(2, sede.getDireccion());
            ps.setString(3, sede.getCiudad());
            ps.setString(4, sede.getTelefono());
            ps.setBoolean(5, sede.getEsPrincipal());
            ps.setString(6, sede.getEstado().name());
            ps.setInt(7, sede.getId());

            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0; // devuelve true si es > 0 y devuelve false si es < 0
        }
    }

    @Override
    public boolean deleteSede(int id) throws SQLException {
        String sql = "delete from Sede where id_sede = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    @Override
    public List<Sede> searchSede(String criterio) throws SQLException {
        List<Sede> sedes = new ArrayList<>();
        Sede sede = new Sede();
        String sql = "select * from Sede where CAST(id_sede as text) ilike ? or nombre ilike ? or direccion ilike ? or ciudad ilike ? order by id_sede desc";
        try( PreparedStatement ps = connection.prepareStatement(sql) ) {
            String patron = "%" + criterio + "%";
            ps.setString(1, patron);
            ps.setString(2, patron);
            ps.setString(3, patron);
            ps.setString(4, patron);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sedes.add(mapearSede(rs));
                }
            }
        }
        return sedes;
    }

    private Sede mapearSede(ResultSet rs) throws SQLException {
        Sede sede = new Sede();
        sede.setId(rs.getInt("id_sede"));
        sede.setNombre(rs.getString("nombre"));
        sede.setDireccion(rs.getString("direccion"));
        sede.setCiudad(rs.getString("ciudad"));
        sede.setTelefono(rs.getString("telefono"));
        sede.setEsPrincipal(rs.getBoolean("es_principal"));

        String estadoStr = rs.getString("estado");
        if (estadoStr != null) {
            sede.setEstado(State.valueOf(estadoStr));
        }
        return sede;
    }
}
