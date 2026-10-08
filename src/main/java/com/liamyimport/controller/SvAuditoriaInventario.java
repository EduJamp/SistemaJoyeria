package com.liamyimport.controller;

import com.liamyimport.model.Inventario;
import com.liamyimport.model.Usuario;

import com.liamyimport.util.enums.InventoryMovementType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/svauditoriainventario")
public class SvAuditoriaInventario extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Inventario> listaAuditoria = new ArrayList<>();
        listaAuditoria.add(new Inventario("7751234560012", "Aretes de Plata 950 Gota", "Sede Central", "Luciana R.", 50, 48, 90.00, InventoryMovementType.valueOf("faltante"), "26/09/2026"));
        listaAuditoria.add(new Inventario("7751234560036", "Cadena de Acero Cubana", "Miraflores", "Diego M.", 30, 30, 0.00, InventoryMovementType.valueOf("correcto"), "26/09/2026"));

        request.setAttribute("auditoriaList", listaAuditoria);

        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            switch (userLogueado.getRol()) {
                case ADMINISTRADOR:
                    vistaDestino = "view/admin_vista.jsp";
                    request.setAttribute("vistaActiva", "auditoria-inventario");
                    break;
                case VENDEDOR:
                    vistaDestino = "view/vendedor_auditoria.jsp";
                    break;
                case CAJERO:
                    vistaDestino = "view/cajero_auditoria.jsp";
                    break;
            }

            request.getRequestDispatcher(vistaDestino).forward(request, response);
        } else {
            response.sendRedirect(vistaDestino);
        }
    }
}