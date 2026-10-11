package com.liamyimport.controller;

import com.liamyimport.facade.MetodoPagoFacade;
import com.liamyimport.facade.interfaces.IMetodoPagoFacade;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.MetodoPagoDTO;
import com.liamyimport.util.enums.State;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/svmetodopago")
public class SvMetodoPago extends HttpServlet {

    private IMetodoPagoFacade metodoPagoFacade;

    @Override
    public void init() throws ServletException {
        super.init();
        metodoPagoFacade = new MetodoPagoFacade();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("vistaActiva", "metodospago");

        String criterio = request.getParameter("criterio");
        List<MetodoPagoDTO> listaMetodos;

        if (criterio != null && !criterio.trim().isEmpty()) {
            MetodoPagoDTO dtoBusqueda = new MetodoPagoDTO(0, criterio, null);
            listaMetodos = metodoPagoFacade.searchMetodoPago(dtoBusqueda);
        } else {
            listaMetodos = metodoPagoFacade.getAllMetodoPago();
        }

        request.setAttribute("metodos", listaMetodos);

        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            switch (userLogueado.getRol()) {
                case ADMINISTRADOR:
                    vistaDestino = "view/admin_vista.jsp";
                    break;
                case VENDEDOR:
                    vistaDestino = "view/vendedor_vista.jsp";
                    break;
                case CAJERO:
                    vistaDestino = "view/cajero_vista.jsp";
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
                    crearMetodo(request);
                    break;
                case "actualizar":
                    actualizarMetodo(request);
                    break;
                case "eliminar":
                    eliminarMetodo(request);
                    break;
            }
        }

        response.sendRedirect("svmetodopago");
    }

    private void crearMetodo(HttpServletRequest request) {
        String nombre = request.getParameter("nombre");
        String estadoStr = request.getParameter("estado");

        State estado = State.activo;
        if (estadoStr != null && estadoStr.equalsIgnoreCase("INACTIVO")) {
            estado = State.inactivo;
        }

        MetodoPagoDTO dto = new MetodoPagoDTO(0, nombre, estado);
        metodoPagoFacade.addMetodoPago(dto);
    }

    private void actualizarMetodo(HttpServletRequest request) {
        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String estadoStr = request.getParameter("estado");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);

            State estado = State.activo;
            if (estadoStr != null && estadoStr.equalsIgnoreCase("INACTIVO")) {
                estado = State.inactivo;
            }

            MetodoPagoDTO dto = new MetodoPagoDTO(id, nombre, estado);
            metodoPagoFacade.updateMetodoPago(dto);
        }
    }

    private void eliminarMetodo(HttpServletRequest request) {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            metodoPagoFacade.deleteMetodoPago(id);
        }
    }
}