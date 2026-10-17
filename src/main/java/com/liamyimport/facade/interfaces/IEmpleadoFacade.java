package com.liamyimport.facade.interfaces;

import com.liamyimport.model.dto.EmpleadoDTO;

import java.util.List;

public interface IEmpleadoFacade {
    boolean addEmployee(EmpleadoDTO dto);
    List<EmpleadoDTO> getAllEmployees();
    List<EmpleadoDTO> searchEmployees(EmpleadoDTO dto);
    boolean updateEmployees(EmpleadoDTO dto);
    boolean deleteEmployees(int id);
    EmpleadoDTO getEmployeeById(int id);
}
