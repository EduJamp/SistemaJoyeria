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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/svinventario")
public class SvInventario extends HttpServlet {

    private static List<Inventario> listaInventario = new ArrayList<>();

    static {
        if (listaInventario.isEmpty()) {
            listaInventario.add(new Inventario("7751234560012", "Aretes de Plata 950 Gota", "Sede Central", "Sistema", 25, 0, 0.0, InventoryMovementType.pendiente, "-"));
            listaInventario.add(new Inventario("7751234560029", "Cadena de Acero Cubana", "Sede Central", "Sistema", 15, 0, 0.0, InventoryMovementType.pendiente, "-"));
            listaInventario.add(new Inventario("7751234560036", "Anillo con Circonia Solitario", "Sede Central", "Sistema", 30, 0, 0.0, InventoryMovementType.pendiente, "-"));
            listaInventario.add(new Inventario("7751234560043", "Pulsera de Cuero Trenzado", "Sede Central", "Sistema", 10, 0, 0.0, InventoryMovementType.pendiente, "-"));
            listaInventario.add(new Inventario("7751234560050", "Collar de Perlas Cultivadas", "Sede Central", "Sistema", 12, 0, 0.0, InventoryMovementType.pendiente, "-"));
            listaInventario.add(new Inventario("7751234560067", "Gemelos de Acero Grabados", "Sede Central", "Sistema", 18, 0, 0.0, InventoryMovementType.pendiente, "-"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("vistaActiva", "conteo-productos");
        request.setAttribute("listaInventario", listaInventario);

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

        if ("guardar".equals(accion)) {
            String fechaActual = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date());

            for (Inventario inv : listaInventario) {
                String cantidadStr = request.getParameter("contado_" + inv.getCodigoBarras());
                if (cantidadStr != null && !cantidadStr.trim().isEmpty()) {
                    try {
                        int cantidadContada = Integer.parseInt(cantidadStr);
                        inv.setContado(cantidadContada);
                        inv.setFechaConteo(fechaActual);
                    } catch (NumberFormatException e) {

                    }
                }
            }
        }

        response.sendRedirect("svinventario");
    }
}