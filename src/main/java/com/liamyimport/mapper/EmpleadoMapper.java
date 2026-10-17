package com.liamyimport.mapper;

import com.liamyimport.model.Empleado;
import com.liamyimport.model.Sede;
import com.liamyimport.model.dto.EmpleadoDTO;

public class EmpleadoMapper {
    public static EmpleadoDTO toDTO(Empleado entidad) {
        if (entidad == null) {
            return null;
        }

        EmpleadoDTO dto = new EmpleadoDTO();

        dto.setNombre(entidad.getNombre());
        dto.setApellido(entidad.getApellido());
        dto.setTipoDocumento(entidad.getTipoDocumento());
        dto.setNumeroDocumento(entidad.getNumeroDocumento());
        dto.setTelefono(entidad.getTelefono());
        dto.setDireccion(entidad.getDireccion());
        dto.setFechaNacimiento(entidad.getFechaNacimiento());

        dto.setIdEmpleado(entidad.getIdEmpleado());
        dto.setSalario(entidad.getSalario());
        dto.setFechaInicio(entidad.getFechaInicio());
        dto.setFechaFin(entidad.getFechaFin());

        if (entidad.getSede() != null) {
            dto.setIdSede(entidad.getSede().getId());
        }

        return dto;
    }

    public static Empleado toEntity(EmpleadoDTO dto) {
        if (dto == null) {
            return null;
        }

        Empleado entidad = new Empleado();

        entidad.setNombre(dto.getNombre());
        entidad.setApellido(dto.getApellido());
        entidad.setTipoDocumento(dto.getTipoDocumento());
        entidad.setNumeroDocumento(dto.getNumeroDocumento());
        entidad.setTelefono(dto.getTelefono());
        entidad.setDireccion(dto.getDireccion());
        entidad.setFechaNacimiento(dto.getFechaNacimiento());

        entidad.setIdEmpleado(dto.getIdEmpleado());
        entidad.setSalario(dto.getSalario());
        entidad.setFechaInicio(dto.getFechaInicio());
        entidad.setFechaFin(dto.getFechaFin());

        if (dto.getIdSede() > 0) {
            Sede sede = new Sede();
            sede.setId(dto.getIdSede());
            entidad.setSede(sede);
        }

        return entidad;
    }
}
