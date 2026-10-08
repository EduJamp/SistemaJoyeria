package com.liamyimport.controller;

import com.liamyimport.util.enums.TypeIdentityDocument;
import com.liamyimport.model.Empleado;
import com.liamyimport.util.csv.EmpleadoRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/svempleado")
public class SvEmpleado extends HttpServlet {

    private EmpleadoRepository repo;

    @Override
    public void init() throws ServletException {
        super.init();
        repo = new EmpleadoRepository();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Empleado> listaEmpleados = repo.obtenerTodos();

        request.setAttribute("empleados", listaEmpleados);

        request.setAttribute("vistaActiva", "empleados");
        request.getRequestDispatcher("/view/admin_vista.jsp").forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

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

        response.sendRedirect(request.getContextPath() + "/svempleado");
    }

    private void crearEmpleado(HttpServletRequest request) {
        Empleado emp = extraerEmpleadoDelFormulario(request);
        if (emp != null) {
            repo.agregar(emp);
        }
    }

    private void actualizarEmpleado(HttpServletRequest request) {
        Empleado emp = extraerEmpleadoDelFormulario(request);
        if (emp != null) {
            repo.actualizar(emp);
        }
    }

    private void eliminarEmpleado(HttpServletRequest request) {
        String docParam = request.getParameter("numeroDocumento");
        if (docParam != null && !docParam.isEmpty()) {
            int numeroDocumento = Integer.parseInt(docParam);
            repo.eliminar(numeroDocumento);
        }
    }

    private Empleado extraerEmpleadoDelFormulario(HttpServletRequest request) {
        try {
            Empleado emp = new Empleado();
            emp.setNombre(request.getParameter("nombre"));
            emp.setApellido(request.getParameter("apellido"));
            emp.setTipoDocumento(TypeIdentityDocument.valueOf(request.getParameter("tipoDocumento")));
            emp.setNumeroDocumento(Integer.parseInt(request.getParameter("numeroDocumento")));
            emp.setTelefono(Integer.parseInt(request.getParameter("telefono")));
            emp.setDireccion(request.getParameter("direccion"));

            String fechaNacStr = request.getParameter("fechaNacimiento");
            if (fechaNacStr != null && !fechaNacStr.isEmpty()) {
                emp.setFechaNacimiento(LocalDate.parse(fechaNacStr));
            }

            emp.setSalario(Integer.parseInt(request.getParameter("salario")));

            String fechaIniStr = request.getParameter("fechaInicio");
            if (fechaIniStr != null && !fechaIniStr.isEmpty()) {
                emp.setFechaInicio(LocalDate.parse(fechaIniStr));
            }

            String fechaFinStr = request.getParameter("fechaFin");
            if (fechaFinStr != null && !fechaFinStr.isEmpty()) {
                emp.setFechaFin(LocalDate.parse(fechaFinStr));
            }

            return emp;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}