package com.liamyimport.controller;

import com.liamyimport.facade.interfaces.ISedeFacade;
import com.liamyimport.facade.SedeFacade;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.SedeDTO;
import com.liamyimport.util.enums.State;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/svsede")
public class SvSede extends HttpServlet {

    private ISedeFacade sedeFacade = new SedeFacade();

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String criterio = request.getParameter("criterio");
        List<SedeDTO> listaSedes;

        if (criterio != null && !criterio.trim().isEmpty()) {
            SedeDTO dto = new SedeDTO();
            dto.setNombre(criterio); //facade extrae el criterio desde el atributo 'nombre'
            listaSedes = sedeFacade.searchSedes(dto);
        } else {
            listaSedes = sedeFacade.getSedes();
        }

        request.setAttribute("sedesList", listaSedes);
        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            switch (userLogueado.getRol()) {
                case ADMINISTRADOR:
                    vistaDestino = "view/admin_vista.jsp";
                    request.setAttribute("vistaActiva", "sedes");
                    break;
                case VENDEDOR:
                    vistaDestino = "view/vendedor_sedes.jsp";
                    break;
                case CAJERO:
                    vistaDestino = "view/cajero_sedes.jsp";
                    break;
            }

            request.getRequestDispatcher(vistaDestino).forward(request, response);
        } else {
            response.sendRedirect(vistaDestino);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "crear":
                    crearSede(request);
                    break;
                case "actualizar":
                    actualizarSede(request);
                    break;
                case "eliminar":
                    eliminarSede(request);
                    break;
            }
        }

        response.sendRedirect("svsede");
    }

    private void crearSede(HttpServletRequest request) {
        SedeDTO dto = new SedeDTO();
        dto.setNombre(request.getParameter("nombre"));
        dto.setDireccion(request.getParameter("direccion"));
        dto.setCiudad(request.getParameter("ciudad"));
        dto.setTelefono(request.getParameter("telefono"));
        dto.setEsPrincipal(request.getParameter("esPrincipal") != null);
        dto.setEstado(parsearEstado(request.getParameter("estado")));

        // Delegamos la creación al Facade
        sedeFacade.createSede(dto);
    }

    private void actualizarSede(HttpServletRequest request) {
        SedeDTO dto = new SedeDTO();
        dto.setId(Integer.parseInt(request.getParameter("id")));
        dto.setNombre(request.getParameter("nombre"));
        dto.setDireccion(request.getParameter("direccion"));
        dto.setCiudad(request.getParameter("ciudad"));
        dto.setTelefono(request.getParameter("telefono"));
        dto.setEsPrincipal(request.getParameter("esPrincipal") != null);
        dto.setEstado(parsearEstado(request.getParameter("estado")));

        sedeFacade.modifySede(dto);
    }

    private void eliminarSede(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));

        sedeFacade.deleteSede(id);
    }

    private State parsearEstado(String valor) {
        if (valor == null) return State.activo;
        try {
            return State.valueOf(valor.toUpperCase());
        } catch (IllegalArgumentException e) {
            return State.activo;
        }
    }
}