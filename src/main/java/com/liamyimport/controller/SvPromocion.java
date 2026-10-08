package com.liamyimport.controller;

import com.liamyimport.model.Promocion;
import com.liamyimport.model.Usuario; // Importación necesaria para leer el rol

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Importación necesaria para la sesión
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/svpromocion")
public class SvPromocion extends HttpServlet {

    private static List<Promocion> listaPromociones = new ArrayList<>();

    static {
        listaPromociones.add(new Promocion(1, "20% de descuento", "Descuento", "Activa", "Obtén un 20% de descuento en productos seleccionados durante el periodo promocional.", "01/09/2026", "30/09/2026", "Todas las sedes", "var(--gradient-primary)"));
        listaPromociones.add(new Promocion(2, "2 + 1 Gratis", "Promoción", "Activa", "Compra dos unidades y recibe una tercera unidad completamente gratis.", "05/09/2026", "20/09/2026", "Sede Principal", "linear-gradient(135deg,#6366f1,#8b5cf6)"));
        listaPromociones.add(new Promocion(3, "Hasta 30% OFF", "Descuento", "Por vencer", "Descuentos de hasta 30% en productos seleccionados de la tienda.", "10/09/2026", "15/09/2026", "Todas las sedes", "linear-gradient(135deg,#f59e0b,#f97316)"));
        listaPromociones.add(new Promocion(4, "15% Cliente frecuente", "Cliente frecuente", "Activa", "Beneficio exclusivo para clientes que cumplan las condiciones establecidas.", "01/09/2026", "30/09/2026", "Todas las sedes", "linear-gradient(135deg,#10b981,#059669)"));
        listaPromociones.add(new Promocion(5, "Combo especial", "Combo", "Inactiva", "Conjunto de productos seleccionados disponibles a un precio promocional.", "08/09/2026", "28/09/2026", "Sede Principal", "linear-gradient(135deg,#ec4899,#db2777)"));
        listaPromociones.add(new Promocion(6, "Oferta especial", "Oferta relámpago", "Programada", "Promoción especial programada para incentivar las ventas durante una fecha determinada.", "15/09/2026", "25/09/2026", "Todas las sedes", "linear-gradient(135deg,#0ea5e9,#2563eb)"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("vistaActiva", "promociones");
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

        if ("crear".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String tipo = request.getParameter("tipo");
            String sede = request.getParameter("sede");
            String fechaInicio = request.getParameter("fechaInicio");
            String fechaFin = request.getParameter("fechaFin");
            String descripcion = request.getParameter("descripcion");

            String estadoSwitch = request.getParameter("promocionActiva");
            String estado = (estadoSwitch != null && estadoSwitch.equals("on")) ? "Activa" : "Inactiva";

            String colorDefecto = "linear-gradient(135deg, #475569, #1e293b)";

            int nuevoId = listaPromociones.size() + 1;
            Promocion p = new Promocion(nuevoId, nombre, tipo, estado, descripcion, fechaInicio, fechaFin, sede, colorDefecto);

            listaPromociones.add(p);
        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            listaPromociones.removeIf(p -> p.getId() == id);
        }

        response.sendRedirect("svpromocion");
    }
}