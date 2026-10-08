package com.liamyimport.controller;

import com.liamyimport.model.Cliente;
import com.liamyimport.model.Usuario; // IMPORTANTE: Agregado para leer el rol
import com.liamyimport.util.enums.TypeIdentityDocument;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // IMPORTANTE: Agregado para leer la sesión

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/svcliente")
public class SvCliente extends HttpServlet {

    private static List<Cliente> listaClientes = new ArrayList<>();

    // Cargamos un cliente de prueba
    static {
        listaClientes.add(new Cliente(
                "Rosa", "Fernández",
                TypeIdentityDocument.DNI,
                45782301,
                987654321,
                "Jr. Las Flores 245, Lima",
                LocalDate.of(1990, 5, 15),
                "rosa.fernandez@mail.com",
                "natural"
        ));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("vistaActiva", "clientes");
        request.setAttribute("clientes", listaClientes);

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
            String tipoCliente = request.getParameter("tipoCliente");
            String tipoDocStr = request.getParameter("tipoDocumento");
            int numeroDocumento = Integer.parseInt(request.getParameter("numeroDocumento"));
            String nombreCompleto = request.getParameter("nombre");
            int telefono = Integer.parseInt(request.getParameter("telefono"));
            String correo = request.getParameter("correo");
            String direccion = request.getParameter("direccion");

            String nombre = nombreCompleto;
            String apellido = "";
            if ("natural".equals(tipoCliente) && nombreCompleto.contains(" ")) {
                int primerEspacio = nombreCompleto.indexOf(" ");
                nombre = nombreCompleto.substring(0, primerEspacio);
                apellido = nombreCompleto.substring(primerEspacio + 1);
            }

            TypeIdentityDocument tipoDocumento = TypeIdentityDocument.DNI;
            if (tipoDocStr.equalsIgnoreCase("RUC")) {
                tipoDocumento = TypeIdentityDocument.RUC;
            } else if (tipoDocStr.equalsIgnoreCase("CE") || tipoDocStr.equalsIgnoreCase("Carné de extranjería")) {
                tipoDocumento = TypeIdentityDocument.CE;
            }

            LocalDate fechaNac = LocalDate.now();

            Cliente nuevoCliente = new Cliente(
                    nombre, apellido, tipoDocumento, numeroDocumento, telefono, direccion, fechaNac, correo, tipoCliente
            );

            listaClientes.add(nuevoCliente);
        }

        // Refrescar la vista actual (vuelve a disparar el doGet con el rol correcto)
        response.sendRedirect("svcliente");
    }
}