package com.liamyimport.controller;

import com.liamyimport.model.Caja;
import com.liamyimport.model.Usuario;

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

@WebServlet("/svcaja")
public class SvCaja extends HttpServlet {

    private static List<Caja> listaCajas = new ArrayList<>();
    private static Caja cajaActual = null; // Simula la sesión activa de caja

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) {
            view = "apertura-caja"; // Vista por defecto
        }

        request.setAttribute("vistaActiva", view);
        request.setAttribute("cajaActual", cajaActual);

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
        String fechaActual = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date());

        if ("aperturar".equals(accion)) {
            String sede = request.getParameter("sede");
            String responsable = request.getParameter("responsable");
            double montoInicial = Double.parseDouble(request.getParameter("montoInicial"));
            String observaciones = request.getParameter("observaciones");

            int nuevoId = listaCajas.size() + 1;
            cajaActual = new Caja(nuevoId, sede, responsable, montoInicial, fechaActual, observaciones, "ABIERTA");
            listaCajas.add(cajaActual);

            response.sendRedirect("svcaja?view=punto-venta");
            return;

        } else if ("cerrar".equals(accion) && cajaActual != null) {
            double montoFisico = Double.parseDouble(request.getParameter("montoFisico"));
            String observacionesCierre = request.getParameter("observacionesCierre");

            // Simulación de ventas en el sistema
            double ventasSistema = 1500.50;
            double totalEsperado = cajaActual.getMontoInicial() + ventasSistema;
            double diferencia = montoFisico - totalEsperado;

            cajaActual.setMontoFinalSistema(totalEsperado);
            cajaActual.setMontoFinalFisico(montoFisico);
            cajaActual.setDiferencia(diferencia);
            cajaActual.setFechaCierre(fechaActual);
            cajaActual.setObservacionesCierre(observacionesCierre);
            cajaActual.setEstado("CERRADA");

            cajaActual = null; // Libera la caja actual para el próximo turno

            response.sendRedirect("svcaja?view=apertura-caja");
            return;
        }

        response.sendRedirect("svcaja");
    }
}