package com.liamyimport.controller;

import com.liamyimport.facade.ClienteFacade;
import com.liamyimport.facade.interfaces.IClienteFacade;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.ClienteDTO;
import com.liamyimport.util.enums.State;
import com.liamyimport.util.enums.TypeIdentityDocument;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/svcliente")
public class SvCliente extends HttpServlet {

    private IClienteFacade clienteFacade = new ClienteFacade();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("vistaActiva", "clientes");

        // LÓGICA DE BÚSQUEDA Y LISTADO
        String criterio = request.getParameter("criterio");
        List<ClienteDTO> listaClientes;

        if (criterio != null && !criterio.trim().isEmpty()) {
            ClienteDTO dtoBusqueda = new ClienteDTO();
            dtoBusqueda.setNombre(criterio); // El facade busca por el nombre en el DTO
            listaClientes = clienteFacade.searchCliente(dtoBusqueda);
        } else {
            listaClientes = clienteFacade.getClientes();
        }

        // Se envía la lista real de la base de datos
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

        if (accion != null) {
            switch (accion) {
                case "crear":
                    crearCliente(request);
                    break;
                case "actualizar":
                    actualizarCliente(request);
                    break;
                case "eliminar":
                    eliminarCliente(request);
                    break;
            }
        }

        response.sendRedirect("svcliente");
    }

    private void crearCliente(HttpServletRequest request) {
        ClienteDTO dto = extraerDatosDelRequest(request);
        clienteFacade.createCliente(dto);
    }

    private void actualizarCliente(HttpServletRequest request) {
        ClienteDTO dto = extraerDatosDelRequest(request);

        if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
            dto.setId_cliente(Integer.parseInt(request.getParameter("id")));
        }

        clienteFacade.modifyCliente(dto);
    }

    private void eliminarCliente(HttpServletRequest request) {
        if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
            int id = Integer.parseInt(request.getParameter("id"));
            clienteFacade.deleteCliente(id);
        }
    }

    private ClienteDTO extraerDatosDelRequest(HttpServletRequest request) {
        String tipoCliente = request.getParameter("tipoCliente");
        String tipoDocStr = request.getParameter("tipoDocumento");

        int numeroDocumento = 0;
        if (request.getParameter("numeroDocumento") != null && !request.getParameter("numeroDocumento").isEmpty()) {
            numeroDocumento = Integer.parseInt(request.getParameter("numeroDocumento"));
        }

        String nombreCompleto = request.getParameter("nombre");

        int telefono = 0;
        if (request.getParameter("telefono") != null && !request.getParameter("telefono").isEmpty()) {
            telefono = Integer.parseInt(request.getParameter("telefono"));
        }

        String correo = request.getParameter("correo");
        String direccion = request.getParameter("direccion");

        // Tu lógica de separación de nombres intacta
        String nombre = nombreCompleto;
        String apellido = "";
        if ("natural".equals(tipoCliente) && nombreCompleto != null && nombreCompleto.contains(" ")) {
            int primerEspacio = nombreCompleto.indexOf(" ");
            nombre = nombreCompleto.substring(0, primerEspacio);
            apellido = nombreCompleto.substring(primerEspacio + 1);
        }

        TypeIdentityDocument tipoDocumento = TypeIdentityDocument.DNI;
        if (tipoDocStr != null) {
            if (tipoDocStr.equalsIgnoreCase("RUC")) {
                tipoDocumento = TypeIdentityDocument.RUC;
            } else if (tipoDocStr.equalsIgnoreCase("CE") || tipoDocStr.equalsIgnoreCase("Carné de extranjería")) {
                tipoDocumento = TypeIdentityDocument.CE;
            }
        }

        LocalDate fechaNac = LocalDate.now();

        State estado = State.activo;
        String estadoStr = request.getParameter("estado");
        if (estadoStr != null && estadoStr.equalsIgnoreCase("INACTIVO")) {
            estado = State.inactivo;
        }

        ClienteDTO dto = new ClienteDTO();
        dto.setNombre(nombre);
        dto.setApellido(apellido);
        dto.setTipoDocumento(tipoDocumento);
        dto.setNumeroDocumento(numeroDocumento);
        dto.setTelefono(telefono);
        dto.setDireccion(direccion);
        dto.setFechaNacimiento(fechaNac);
        dto.setEmail(correo);
        dto.setTipoCliente(tipoCliente);
        dto.setEstado(estado);

        return dto;
    }
}