package com.liamyimport.controller;

import com.liamyimport.model.Sede;
import com.liamyimport.model.Usuario;
import com.liamyimport.util.enums.State;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/svsede")
public class SvSede extends HttpServlet {

    private static List<Sede> listaSedes = new ArrayList<>();

    @Override
    public void init() throws ServletException {
        super.init();
        if (listaSedes.isEmpty()) {
            listaSedes.add(new Sede(1, "Sede Central", "Av. Javier Prado 123", "Lima", "987654321", true, State.activo));
            listaSedes.add(new Sede(2, "Miraflores", "Av. Larco 456", "Lima", "912345678", false, State.activo));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        int nuevoId = listaSedes.size() + 1;
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String ciudad = request.getParameter("ciudad");
        String telefono = request.getParameter("telefono");
        boolean esPrincipal = request.getParameter("esPrincipal") != null;

        State estado = parsearEstado(request.getParameter("estado"));

        listaSedes.add(new Sede(nuevoId, nombre, direccion, ciudad, telefono, esPrincipal, estado));
    }

    private void actualizarSede(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        for (Sede s : listaSedes) {
            if (s.getId() == id) {
                s.setNombre(request.getParameter("nombre"));
                s.setDireccion(request.getParameter("direccion"));
                s.setCiudad(request.getParameter("ciudad"));
                s.setTelefono(request.getParameter("telefono"));
                s.setEsPrincipal(request.getParameter("esPrincipal") != null);
                s.setEstado(parsearEstado(request.getParameter("estado")));
                break;
            }
        }
    }

    private void eliminarSede(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        listaSedes.removeIf(s -> s.getId() == id);
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