package com.liamyimport.mapper;

import com.liamyimport.model.Empleado;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.UsuarioDTO;

public class UsuarioMapper {
    public static UsuarioDTO toDTO(Usuario entidad) {
        if (entidad == null) {
            return null;
        }

        UsuarioDTO dto = new UsuarioDTO();

        dto.setIdUsuario(entidad.getIdUsuario());
        dto.setNombreUsuario(entidad.getNombreUsuario());
        dto.setPassword(entidad.getPassword());
        dto.setRol(entidad.getRol());
        dto.setEmpleado(entidad.getEmpleado());

        if (entidad.getEmpleado() != null) {
            dto.setIdEmpleado(entidad.getEmpleado().getIdEmpleado());
        }

        return dto;
    }

    public static Usuario toEntity(UsuarioDTO dto) {
        if (dto == null) {
            return null;
        }

        Usuario entidad = new Usuario();

        entidad.setIdUsuario(dto.getIdUsuario());
        entidad.setNombreUsuario(dto.getNombreUsuario());
        entidad.setPassword(dto.getPassword());
        entidad.setRol(dto.getRol());
        entidad.setEmpleado(dto.getEmpleado());

        if (dto.getIdEmpleado() > 0 && entidad.getEmpleado() == null) {
            Empleado empleado = new Empleado();
            empleado.setIdEmpleado(dto.getIdEmpleado());
            entidad.setEmpleado(empleado);
        }

        return entidad;
    }
}
