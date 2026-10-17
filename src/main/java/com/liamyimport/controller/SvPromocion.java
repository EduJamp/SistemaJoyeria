package com.liamyimport.controller;

import com.liamyimport.facade.PromocionFacade;
import com.liamyimport.facade.interfaces.IPromocionFacade;
import com.liamyimport.facade.SedeFacade;
import com.liamyimport.facade.interfaces.ISedeFacade;
import com.liamyimport.model.dto.SedeDTO;

import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.PromocionDTO;
import com.liamyimport.util.enums.StatePromotion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/svpromocion")
public class SvPromocion extends HttpServlet {

    private IPromocionFacade promocionFacade;
    private ISedeFacade sedeFacade;

    @Override
    public void init() throws ServletException {
        super.init();
        promocionFacade = new PromocionFacade();
        sedeFacade = new SedeFacade();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("vistaActiva", "promociones");

        String criterio = request.getParameter("criterio");
        List<PromocionDTO> listaPromociones;

        if (criterio != null && !criterio.trim().isEmpty()) {
            PromocionDTO dtoBusqueda = new PromocionDTO(0, criterio, null, null, null, null, 0.0, null, 0);
            listaPromociones = promocionFacade.searchPromocion(dtoBusqueda);
        } else {
            listaPromociones = promocionFacade.getAllPromociones();
        }

        List<SedeDTO> listaSedes = sedeFacade.getSedes();
        request.setAttribute("sedes", listaSedes);
        request.setAttribute("promociones", listaPromociones);

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
                    crearPromocion(request);
                    break;
                case "actualizar":
                    actualizarPromocion(request);
                    break;
                case "eliminar":
                    eliminarPromocion(request);
                    break;
            }
        }
        response.sendRedirect("svpromocion");
    }

    private void crearPromocion(HttpServletRequest request) {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String fechaInicioStr = request.getParameter("fechaInicio");
        String fechaFinStr = request.getParameter("fechaFin");

        String porcentajeStr = request.getParameter("porcentajeDescuento");
        String colorFondo = request.getParameter("colorFondo");
        String sedeStr = request.getParameter("sede");
        String estadoSwitch = request.getParameter("promocionActiva");

        StatePromotion estado = (estadoSwitch != null && estadoSwitch.equals("on")) ? StatePromotion.activo : StatePromotion.inactivo;

        LocalDate fechaInicio = (fechaInicioStr != null && !fechaInicioStr.isEmpty()) ? LocalDate.parse(fechaInicioStr) : null;
        LocalDate fechaFin = (fechaFinStr != null && !fechaFinStr.isEmpty()) ? LocalDate.parse(fechaFinStr) : null;

        double porcentaje = (porcentajeStr != null && !porcentajeStr.isEmpty()) ? Double.parseDouble(porcentajeStr) : 0.0;
        int sede = (sedeStr != null && !sedeStr.isEmpty()) ? Integer.parseInt(sedeStr) : 0;

        if (colorFondo == null || colorFondo.trim().isEmpty()) {
            colorFondo = "linear-gradient(135deg, #475569, #1e293b)";
        }

        PromocionDTO dto = new PromocionDTO(0, nombre, estado, descripcion, fechaInicio, fechaFin, porcentaje, colorFondo, sede);

        promocionFacade.addPromocion(dto);
    }

    private void actualizarPromocion(HttpServletRequest request) {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);

            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String fechaInicioStr = request.getParameter("fechaInicio");
            String fechaFinStr = request.getParameter("fechaFin");

            String porcentajeStr = request.getParameter("porcentajeDescuento");
            String colorFondo = request.getParameter("colorFondo");
            String sedeStr = request.getParameter("sede");
            String estadoSwitch = request.getParameter("promocionActiva");

            StatePromotion estado = (estadoSwitch != null && estadoSwitch.equals("on")) ? StatePromotion.activo : StatePromotion.inactivo;

            LocalDate fechaInicio = (fechaInicioStr != null && !fechaInicioStr.isEmpty()) ? LocalDate.parse(fechaInicioStr) : null;
            LocalDate fechaFin = (fechaFinStr != null && !fechaFinStr.isEmpty()) ? LocalDate.parse(fechaFinStr) : null;

            double porcentaje = (porcentajeStr != null && !porcentajeStr.isEmpty()) ? Double.parseDouble(porcentajeStr) : 0.0;
            int sede = (sedeStr != null && !sedeStr.isEmpty()) ? Integer.parseInt(sedeStr) : 0;

            if (colorFondo == null || colorFondo.trim().isEmpty()) {
                colorFondo = "linear-gradient(135deg, #475569, #1e293b)";
            }

            PromocionDTO dto = new PromocionDTO(id, nombre, estado, descripcion, fechaInicio, fechaFin, porcentaje, colorFondo, sede);

            promocionFacade.updatePromocion(dto);
        }
    }

    private void eliminarPromocion(HttpServletRequest request) {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            promocionFacade.deletePromocion(id);
        }
    }
}