package com.liamyimport.mapper;

import com.liamyimport.model.Sede;
import com.liamyimport.model.dto.SedeDTO;

public class SedeMapper {

//    Metodo para transformar de Entidad a DTO
    public static SedeDTO toDTO(Sede sede) {
        if (sede == null) { // preguntamos si el objeto es null para no devolver nada
            return null;
        }

        // creamos un objeto de tipo SedeDTO para empezar con el mapeo
        SedeDTO dto = new SedeDTO();

//        pasamos los datos de cada atributo de la entidad al DTO
        dto.setId(sede.getId());
        dto.setNombre(sede.getNombre());
        dto.setDireccion(sede.getDireccion());
        dto.setCiudad(sede.getCiudad());
        dto.setTelefono(sede.getTelefono());
        dto.setEsPrincipal(sede.getEsPrincipal());
        dto.setEstado(sede.getEstado());

//        Retornamos el dto
        return dto;
    }

//    Metodo para transformar de DTO a Entidad
    public static Sede toEntity(SedeDTO dto) {
        if (dto == null) {
            return null;
        }

        Sede sede = new Sede();

        sede.setId(dto.getId());
        sede.setNombre(dto.getNombre());
        sede.setDireccion(dto.getDireccion());
        sede.setCiudad(dto.getCiudad());
        sede.setTelefono(dto.getTelefono());
        sede.setEsPrincipal(dto.getEsPrincipal());
        sede.setEstado(dto.getEstado());

        return sede;
    }
}
