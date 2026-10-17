package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.IEmpleadoFacade;
import com.liamyimport.mapper.EmpleadoMapper;
import com.liamyimport.model.Empleado;
import com.liamyimport.model.dto.EmpleadoDTO;
import com.liamyimport.persistence.dao.EmpleadoDAO;
import com.liamyimport.persistence.dao.interfaces.IEmpleadoDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoFacade implements IEmpleadoFacade {
    private IEmpleadoDAO empleadoDAO = new EmpleadoDAO();

    @Override
    public boolean addEmployee(EmpleadoDTO dto) {
        try {
            if (dto != null && dto.getNombre() != null && !dto.getNombre().trim().isEmpty()) {
                return empleadoDAO.addEmployee(EmpleadoMapper.toEntity(dto));
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<EmpleadoDTO> getAllEmployees() {
        try {
            List<Empleado> empleados = empleadoDAO.getAllEmployees();

            if (empleados != null && !empleados.isEmpty()) {
                return empleados.stream()
                        .map(EmpleadoMapper::toDTO)
                        .toList();
            }
            return new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<EmpleadoDTO> searchEmployees(EmpleadoDTO dto) {
        String criterio = (dto != null && dto.getNombre() != null) ? dto.getNombre() : "";

        try {
            List<Empleado> empleados = empleadoDAO.searchEmployees(criterio);

            if (empleados != null && !empleados.isEmpty()) {
                return empleados.stream()
                        .map(EmpleadoMapper::toDTO)
                        .toList();
            }
            return new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateEmployees(EmpleadoDTO dto) {
        try {
            if (dto != null && dto.getNombre() != null && !dto.getNombre().trim().isEmpty()) {
                Empleado empleado = EmpleadoMapper.toEntity(dto);
                return empleadoDAO.updateEmployee(empleado);
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteEmployees(int id) {
        try {
            if (id > 0) {
                return empleadoDAO.deleteEmployee(id);
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public EmpleadoDTO getEmployeeById(int id) {
        try {
            if (id > 0) {
                Empleado empleado = empleadoDAO.getEmployeeById(id);
                return empleado != null ? EmpleadoMapper.toDTO(empleado) : new EmpleadoDTO();
            }
            return new EmpleadoDTO();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
