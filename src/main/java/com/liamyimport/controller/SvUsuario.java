package com.liamyimport.controller;

import com.liamyimport.util.enums.Rol;
import com.liamyimport.model.Empleado;
import com.liamyimport.model.Usuario;
import com.liamyimport.util.csv.EmpleadoRepository;
import com.liamyimport.util.csv.UsuarioRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/svusuario")
public class SvUsuario extends HttpServlet {

    private UsuarioRepository repo;
    private EmpleadoRepository empleadoRepo;

    @Override
    public void init() throws ServletException {
        super.init();
        repo = new UsuarioRepository();
        empleadoRepo = new EmpleadoRepository();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Usuario> listaUsuarios = repo.obtenerTodos();

        List<Empleado> listaEmpleados = empleadoRepo.obtenerTodos();

        request.setAttribute("usuarios", listaUsuarios);
        request.setAttribute("empleados", listaEmpleados);

        request.setAttribute("vistaActiva", "usuarios");

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
                    crearUsuario(request);
                    break;

                case "actualizar":
                    actualizarUsuario(request);
                    break;

                case "eliminar":
                    eliminarUsuario(request);
                    break;
            }
        }

        response.sendRedirect(request.getContextPath() + "/svusuario");
    }

    private void crearUsuario(HttpServletRequest request) {
        Usuario u = extraerUsuarioDelFormulario(request);
        if (u != null) {
            repo.agregar(u);
        }
    }

    private void actualizarUsuario(HttpServletRequest request) {
        Usuario u = extraerUsuarioDelFormulario(request);
        if (u != null) {
            repo.actualizar(u);
        }
    }

    private void eliminarUsuario(HttpServletRequest request) {
        String nombreUsuario = request.getParameter("nombreUsuario");
        if (nombreUsuario != null && !nombreUsuario.isEmpty()) {
            repo.eliminar(nombreUsuario);
        }
    }

    private Usuario extraerUsuarioDelFormulario(HttpServletRequest request) {
        try {
            Usuario u = new Usuario();
            u.setNombreUsuario(request.getParameter("nombreUsuario"));
            u.setContraseña(request.getParameter("contrasena"));
            u.setRol(Rol.valueOf(request.getParameter("rol")));

            String empleadoDocParam = request.getParameter("empleadoId");
            if (empleadoDocParam != null && !empleadoDocParam.isEmpty()) {
                int numDoc = Integer.parseInt(empleadoDocParam);
                Empleado empleadoAsociado = empleadoRepo.buscarPorId(numDoc);
                u.setEmpleado(empleadoAsociado);
            }

            return u;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}