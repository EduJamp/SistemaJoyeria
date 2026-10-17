package com.liamyimport.persistence.dao;

import com.liamyimport.config.ConexionBD;
import com.liamyimport.model.Empleado;
import com.liamyimport.model.Sede;
import com.liamyimport.persistence.dao.interfaces.IEmpleadoDAO;
import com.liamyimport.util.enums.TypeIdentityDocument;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO implements IEmpleadoDAO {

    public EmpleadoDAO() {
    }

    @Override
    public boolean addEmployee(Empleado empleado) throws SQLException {
        String sql = "INSERT INTO Empleado (nombre, apellido, tipo_documento, numero_documento, telefono, " +
                "direccion, fecha_nacimiento, salario, fecha_inicio, fecha_fin, id_sede) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            completarPreparedStatement(ps, empleado);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        empleado.setIdEmpleado(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    @Override
    public List<Empleado> getAllEmployees() throws SQLException {
        String sql = "SELECT e.*, s.nombre AS nombre_sede FROM Empleado e " +
                "LEFT JOIN Sede s ON e.id_sede = s.id_sede " +
                "ORDER BY e.id_empleado DESC";

        List<Empleado> empleados = new ArrayList<>();

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                empleados.add(mapearEmpleado(rs));
            }
        }
        return empleados;
    }

    @Override
    public List<Empleado> searchEmployees(String criterio) throws SQLException {
        String sql = "SELECT e.*, s.nombre AS nombre_sede FROM Empleado e " +
                "LEFT JOIN Sede s ON e.id_sede = s.id_sede " +
                "WHERE e.nombre ILIKE ? OR e.apellido ILIKE ? OR e.numero_documento ILIKE ? " +
                "ORDER BY e.id_empleado DESC";

        List<Empleado> empleados = new ArrayList<>();

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            String patron = "%" + criterio + "%";
            ps.setString(1, patron);
            ps.setString(2, patron);
            ps.setString(3, patron);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    empleados.add(mapearEmpleado(rs));
                }
            }
        }
        return empleados;
    }

    @Override
    public boolean updateEmployee(Empleado empleado) throws SQLException {
        String sql = "UPDATE Empleado SET nombre = ?, apellido = ?, tipo_documento = ?, numero_documento = ?, " +
                "telefono = ?, direccion = ?, fecha_nacimiento = ?, salario = ?, fecha_inicio = ?, " +
                "fecha_fin = ?, id_sede = ? WHERE id_empleado = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            completarPreparedStatement(ps, empleado);
            ps.setInt(12, empleado.getIdEmpleado());

            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteEmployee(int id) throws SQLException {
        String sql = "DELETE FROM Empleado WHERE id_empleado = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public Empleado getEmployeeById(int id) throws SQLException {
        String sql = "SELECT e.*, s.nombre AS nombre_sede FROM Empleado e " +
                "LEFT JOIN Sede s ON e.id_sede = s.id_sede " +
                "WHERE e.id_empleado = ?";

        try (Connection connection = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearEmpleado(rs);
                }
            }
        }
        return null;
    }


    private void completarPreparedStatement(PreparedStatement ps, Empleado empleado) throws SQLException {
        ps.setString(1, empleado.getNombre());
        ps.setString(2, empleado.getApellido());

        ps.setString(3, empleado.getTipoDocumento() != null ? empleado.getTipoDocumento().name() : null);

        ps.setString(4, empleado.getNumeroDocumento() > 0 ? String.valueOf(empleado.getNumeroDocumento()) : null);
        ps.setString(5, empleado.getTelefono() > 0 ? String.valueOf(empleado.getTelefono()) : null);

        ps.setString(6, empleado.getDireccion());

        if (empleado.getFechaNacimiento() != null) {
            ps.setDate(7, Date.valueOf(empleado.getFechaNacimiento()));
        } else {
            ps.setNull(7, Types.DATE);
        }

        ps.setDouble(8, empleado.getSalario());

        if (empleado.getFechaInicio() != null) {
            ps.setDate(9, Date.valueOf(empleado.getFechaInicio()));
        } else {
            ps.setNull(9, Types.DATE);
        }

        if (empleado.getFechaFin() != null) {
            ps.setDate(10, Date.valueOf(empleado.getFechaFin()));
        } else {
            ps.setNull(10, Types.DATE);
        }

        if (empleado.getSede() != null && empleado.getSede().getId() > 0) {
            ps.setInt(11, empleado.getSede().getId());
        } else {
            ps.setNull(11, Types.INTEGER);
        }
    }

    private Empleado mapearEmpleado(ResultSet rs) throws SQLException {
        Empleado e = new Empleado();

        e.setIdEmpleado(rs.getInt("id_empleado"));
        e.setNombre(rs.getString("nombre"));
        e.setApellido(rs.getString("apellido"));

        String tipoDoc = rs.getString("tipo_documento");
        if (tipoDoc != null && !tipoDoc.isEmpty()) {
            try {
                e.setTipoDocumento(TypeIdentityDocument.valueOf(tipoDoc));
            } catch (IllegalArgumentException ex) {
                e.setTipoDocumento(null);
            }
        }

        String numDocStr = rs.getString("numero_documento");
        try {
            e.setNumeroDocumento(numDocStr != null && !numDocStr.isEmpty() ? Integer.parseInt(numDocStr.trim()) : 0);
        } catch (NumberFormatException ex) {
            e.setNumeroDocumento(0);
        }

        String telStr = rs.getString("telefono");
        try {
            e.setTelefono(telStr != null && !telStr.isEmpty() ? Integer.parseInt(telStr.trim()) : 0);
        } catch (NumberFormatException ex) {
            e.setTelefono(0);
        }

        e.setDireccion(rs.getString("direccion"));

        Date fechaNac = rs.getDate("fecha_nacimiento");
        if (fechaNac != null) e.setFechaNacimiento(fechaNac.toLocalDate());

        e.setSalario(rs.getInt("salario"));

        Date fechaIni = rs.getDate("fecha_inicio");
        if (fechaIni != null) e.setFechaInicio(fechaIni.toLocalDate());

        Date fechaFin = rs.getDate("fecha_fin");
        if (fechaFin != null) e.setFechaFin(fechaFin.toLocalDate());

        int idSede = rs.getInt("id_sede");
        if (!rs.wasNull()) {
            Sede sede = new Sede();
            sede.setId(idSede); // Usa el método setId de tu clase Sede
            try {
                String nombreSede = rs.getString("nombre_sede");
                sede.setNombre(nombreSede != null ? nombreSede : "Sin asignar");
            } catch (SQLException ex) {
                sede.setNombre("Sin asignar");
            }
            e.setSede(sede);
        }

        return e;
    }
}
