package com.liamyimport.persistence.dao.interfaces;


import com.liamyimport.model.Empleado;

import java.sql.SQLException;
import java.util.List;

public interface IEmpleadoDAO {
    boolean addEmployee(Empleado empleado) throws SQLException;
    List<Empleado> getAllEmployees() throws SQLException;
    List<Empleado> searchEmployees(String criterio) throws SQLException;
    boolean updateEmployee(Empleado empleado) throws SQLException;
    boolean deleteEmployee(int id) throws SQLException;
    Empleado getEmployeeById(int id) throws SQLException;
}
