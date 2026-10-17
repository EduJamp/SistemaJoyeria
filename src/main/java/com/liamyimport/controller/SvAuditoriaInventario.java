package com.liamyimport.controller;

import com.liamyimport.facade.InventarioFacade;
import com.liamyimport.facade.interfaces.IInventarioFacade;
import com.liamyimport.model.Inventario;
import com.liamyimport.model.Usuario;

import com.liamyimport.model.dto.InventarioDTO;
import com.liamyimport.util.enums.InventoryMovementType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/svauditoriainventario")
public class SvAuditoriaInventario extends HttpServlet {

    private IInventarioFacade inventarioFacade;

    @Override
    public void init() throws ServletException {
        super.init();
        inventarioFacade = new InventarioFacade();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String criterio = request.getParameter("criterio");
        List<InventarioDTO> listaAuditoria;

        if (criterio != null && !criterio.trim().isEmpty()) {
            InventarioDTO searchDto = new InventarioDTO();
            searchDto.setEstado(criterio);
            listaAuditoria = inventarioFacade.searchInventarios(searchDto);
        } else {
            listaAuditoria = inventarioFacade.getAllInventarios();
        }

        request.setAttribute("auditoriaList", listaAuditoria);
        request.setAttribute("vistaActiva", "auditoria-inventario");

        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            if (userLogueado.getRol() != null) {
                switch (userLogueado.getRol()) {
                    case ADMINISTRADOR:
                        vistaDestino = "view/admin_vista.jsp";
                        break;
                    case VENDEDOR:
                        vistaDestino = "view/vendedor_auditoria.jsp";
                        break;
                    case CAJERO:
                        vistaDestino = "view/cajero_auditoria.jsp";
                        break;
                    default:
                        vistaDestino = "index.jsp";
                        break;
                }
            }

            request.getRequestDispatcher(vistaDestino).forward(request, response);
        } else {
            response.sendRedirect(vistaDestino);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "crear":
                    crearAuditoria(request);
                    break;
                case "actualizar":
                    actualizarAuditoria(request);
                    break;
                case "eliminar":
                    eliminarAuditoria(request);
                    break;
            }
        }

        response.sendRedirect(request.getContextPath() + "/svauditoriainventario");
    }

    private void crearAuditoria(HttpServletRequest request) {
        InventarioDTO dto = extraerAuditoriaDelFormulario(request);
        if (dto != null) {
            inventarioFacade.addInventario(dto);
        }
    }

    private void actualizarAuditoria(HttpServletRequest request) {
        InventarioDTO dto = extraerAuditoriaDelFormulario(request);
        String idParam = request.getParameter("idInventario");

        if (idParam != null && !idParam.isEmpty() && dto != null) {
            dto.setIdInventario(Integer.parseInt(idParam));
            inventarioFacade.updateInventario(dto);
        }
    }

    private void eliminarAuditoria(HttpServletRequest request) {
        String idParam = request.getParameter("idInventario");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            inventarioFacade.deleteInventario(id);
        }
    }

    private InventarioDTO extraerAuditoriaDelFormulario(HttpServletRequest request) {
        try {
            InventarioDTO dto = new InventarioDTO();

            String stockSistemaStr = request.getParameter("stockSistema");
            String stockFisicoStr = request.getParameter("stockFisico");
            String idProductoStr = request.getParameter("idProducto");
            String idSedeStr = request.getParameter("idSede");
            String idEmpleadoStr = request.getParameter("idEmpleado");
            String estado = request.getParameter("estado");

            if (stockSistemaStr != null && !stockSistemaStr.isEmpty()) {
                dto.setStockSistema(Integer.parseInt(stockSistemaStr));
            }

            if (stockFisicoStr != null && !stockFisicoStr.isEmpty()) {
                int fisico = Integer.parseInt(stockFisicoStr);
                dto.setStockFisico(fisico);

                int diferencia = fisico - dto.getStockSistema();
                if (diferencia < 0) {
                    dto.setFaltantes(Math.abs(diferencia));
                    dto.setSobrantes(0);
                } else {
                    dto.setSobrantes(diferencia);
                    dto.setFaltantes(0);
                }
            }

            if (idProductoStr != null && !idProductoStr.isEmpty()) {
                dto.setIdProducto(Integer.parseInt(idProductoStr));
            }

            if (idSedeStr != null && !idSedeStr.isEmpty()) {
                dto.setIdSede(Integer.parseInt(idSedeStr));
            }

            if (idEmpleadoStr != null && !idEmpleadoStr.isEmpty()) {
                dto.setIdEmpleado(Integer.parseInt(idEmpleadoStr));
            }

            dto.setEstado(estado != null ? estado : "REGISTRADO");
            dto.setFechaConteo(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

            return dto;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}