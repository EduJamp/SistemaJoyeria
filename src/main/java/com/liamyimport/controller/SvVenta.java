package com.liamyimport.controller;

import com.liamyimport.model.Usuario;
import com.liamyimport.model.Venta;

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

@WebServlet("/svventa")
public class SvVenta extends HttpServlet {

    private static List<Venta> listaVentas = new ArrayList<>();

    @Override
    public void init() throws ServletException {
        super.init();
        if (listaVentas.isEmpty()) {
            listaVentas.add(new Venta(1, "B001-000512", "Rosa Fernández", "Sede Central", 350.00, 30.00, 320.00, "Pagado", "08/09/2026 09:12", "Edu Caceres", "Efectivo"));
            listaVentas.add(new Venta(2, "B001-000498", "Carlos Injante", "Sede Central", 160.00, 14.50, 145.50, "Pagado", "07/09/2026 16:48", "Edu Caceres", "Yape"));
            listaVentas.add(new Venta(3, "F002-000089", "Importadora Vega SAC", "Sede Central", 2300.00, 120.00, 2180.00, "Pendiente", "07/09/2026 11:05", "Maria Lopez", "Transferencia"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) {
            view = "nueva-venta";
        }

        request.setAttribute("vistaActiva", view);
        request.setAttribute("ventasList", listaVentas);

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

        if ("registrar".equals(accion)) {
            String comprobante = request.getParameter("comprobante");
            String cliente = request.getParameter("cliente");
            if (cliente == null || cliente.trim().isEmpty()) {
                cliente = "Cliente General";
            }

            double total = 150.00;
            double subtotal = 165.00;
            double ahorro = 15.00;

            String fechaActual = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date());
            int nuevoId = listaVentas.size() + 1;
            String nroComprobante = (comprobante != null && comprobante.equalsIgnoreCase("Factura")) ? "F002-0000" + (89 + nuevoId) : "B001-000" + (512 + nuevoId);

            listaVentas.add(new Venta(nuevoId, nroComprobante, cliente, "Sede Central", subtotal, ahorro, total, "Pagado", fechaActual, "Usuario Actual", "Efectivo"));

            response.sendRedirect("svventa?view=mis-ventas");
            return;
        }

        response.sendRedirect("svventa?view=nueva-venta");
    }
}