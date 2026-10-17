package com.liamyimport.controller;

import com.liamyimport.facade.EmpleadoFacade;
import com.liamyimport.facade.interfaces.IEmpleadoFacade;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.EmpleadoDTO;
import com.liamyimport.util.enums.TypeIdentityDocument;
import com.liamyimport.model.Empleado;
import com.liamyimport.util.csv.EmpleadoRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/svempleado")
public class SvEmpleado extends HttpServlet {

    private IEmpleadoFacade facade;

    @Override
    public void init() throws ServletException {
        super.init();
        facade = new EmpleadoFacade();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String criterio = request.getParameter("criterio");
        List<EmpleadoDTO> listaEmpleados;

        if (criterio != null && !criterio.trim().isEmpty()) {
            EmpleadoDTO searchDto = new EmpleadoDTO();
            searchDto.setNombre(criterio);
            listaEmpleados = facade.searchEmployees(searchDto);
        } else {
            listaEmpleados = facade.getAllEmployees();
        }

        request.setAttribute("empleados", listaEmpleados);

        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            switch (userLogueado.getRol()) {
                case ADMINISTRADOR:
                    vistaDestino = "view/admin_vista.jsp";
                    request.setAttribute("vistaActiva", "empleados");
                    break;
                default:
                    vistaDestino = (userLogueado.getRol().name().equals("VENDEDOR")) ? "view/vendedor_vista.jsp" : "view/cajero_vista.jsp";
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
                    crearEmpleado(request);
                    break;
                case "actualizar":
                    actualizarEmpleado(request);
                    break;
                case "eliminar":
                    eliminarEmpleado(request);
                    break;
            }
        }

        response.sendRedirect("svempleado");
    }

    private void crearEmpleado(HttpServletRequest request) {
        EmpleadoDTO dto = extraerEmpleadoDelFormulario(request);
        if (dto != null) {
            facade.addEmployee(dto);
        }
    }

    private void actualizarEmpleado(HttpServletRequest request) {
        EmpleadoDTO dto = extraerEmpleadoDelFormulario(request);

        if (dto != null) {
            String idParam = request.getParameter("idEmpleado");
            if (idParam != null && !idParam.isEmpty()) {
                dto.setIdEmpleado(Integer.parseInt(idParam));
            }
            facade.updateEmployees(dto);
        } else {
            System.out.println("Error: No se pudo extraer el DTO del formulario de actualización.");
        }
    }

    private void eliminarEmpleado(HttpServletRequest request) {
        String idParam = request.getParameter("idEmpleado");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            facade.deleteEmployees(id);
        }
    }

    private EmpleadoDTO extraerEmpleadoDelFormulario(HttpServletRequest request) {
        try {
            EmpleadoDTO dto = new EmpleadoDTO();

            dto.setNombre(request.getParameter("nombre"));
            dto.setApellido(request.getParameter("apellido"));

            String tipoDocStr = request.getParameter("tipoDocumento");
            if (tipoDocStr != null && !tipoDocStr.isEmpty()) {
                dto.setTipoDocumento(TypeIdentityDocument.valueOf(tipoDocStr));
            }

            String numDocStr = request.getParameter("numeroDocumento");
            if (numDocStr != null && !numDocStr.isEmpty()) {
                dto.setNumeroDocumento(Integer.parseInt(numDocStr));
            }

            String telStr = request.getParameter("telefono");
            if (telStr != null && !telStr.isEmpty()) {
                dto.setTelefono(Integer.parseInt(telStr));
            }

            dto.setDireccion(request.getParameter("direccion"));

            String fechaNacStr = request.getParameter("fechaNacimiento");
            if (fechaNacStr != null && !fechaNacStr.isEmpty()) {
                dto.setFechaNacimiento(LocalDate.parse(fechaNacStr));
            }

            String salarioStr = request.getParameter("salario");
            if (salarioStr != null && !salarioStr.isEmpty()) {
                dto.setSalario(Double.parseDouble(salarioStr));
            }

            String fechaIniStr = request.getParameter("fechaInicio");
            if (fechaIniStr != null && !fechaIniStr.isEmpty()) {
                dto.setFechaInicio(LocalDate.parse(fechaIniStr));
            }

            String fechaFinStr = request.getParameter("fechaFin");
            if (fechaFinStr != null && !fechaFinStr.isEmpty()) {
                dto.setFechaFin(LocalDate.parse(fechaFinStr));
            }

            String idSedeStr = request.getParameter("idSede");
            if (idSedeStr != null && !idSedeStr.isEmpty()) {
                dto.setIdSede(Integer.parseInt(idSedeStr));
            }

            return dto;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}