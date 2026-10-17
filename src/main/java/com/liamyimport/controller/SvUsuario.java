package com.liamyimport.controller;

import com.liamyimport.facade.EmpleadoFacade;
import com.liamyimport.facade.UsuarioFacade;
import com.liamyimport.facade.interfaces.IEmpleadoFacade;
import com.liamyimport.facade.interfaces.IUsuarioFacade;
import com.liamyimport.model.dto.EmpleadoDTO;
import com.liamyimport.model.dto.UsuarioDTO;
import com.liamyimport.util.enums.Rol;
import com.liamyimport.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/svusuario")
public class SvUsuario extends HttpServlet {

    private IUsuarioFacade usuarioFacade;
    private IEmpleadoFacade empleadoFacade;

    @Override
    public void init() throws ServletException {
        super.init();
        usuarioFacade = new UsuarioFacade();
        empleadoFacade = new EmpleadoFacade();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String criterio = request.getParameter("criterio");
        List<UsuarioDTO> listaUsuarios;

        if (criterio != null && !criterio.trim().isEmpty()) {
            UsuarioDTO searchDto = new UsuarioDTO();
            searchDto.setNombreUsuario(criterio);
            listaUsuarios = usuarioFacade.searchUsers(searchDto);
        } else {
            listaUsuarios = usuarioFacade.getAllUsers();
        }

        // Obtenemos la lista de empleados en formato DTO para el selector (<select>) del modal
        List<EmpleadoDTO> listaEmpleados = empleadoFacade.getAllEmployees();

        request.setAttribute("usuarios", listaUsuarios);
        request.setAttribute("empleados", listaEmpleados);
        request.setAttribute("vistaActiva", "usuarios");

        // Control de acceso por sesión y redirección (siguiendo el estándar del proyecto)
        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            switch (userLogueado.getRol()) {
                case ADMINISTRADOR:
                    vistaDestino = "view/admin_vista.jsp";
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
        UsuarioDTO dto = extraerUsuarioDelFormulario(request);
        if (dto != null) {
            usuarioFacade.addUser(dto);
        }
    }

    private void actualizarUsuario(HttpServletRequest request) {
        UsuarioDTO dto = extraerUsuarioDelFormulario(request);

        String idParam = request.getParameter("idUsuario");
        if (idParam != null && !idParam.isEmpty()) {
            dto.setIdUsuario(Integer.parseInt(idParam));
        }

        if (dto != null) {
            usuarioFacade.updateUser(dto);
        }
    }

    private void eliminarUsuario(HttpServletRequest request) {
        String idParam = request.getParameter("idUsuario");
        if (idParam != null && !idParam.isEmpty()) {
            int idUsuario = Integer.parseInt(idParam);
            usuarioFacade.deleteUser(idUsuario);
        }
    }

    private UsuarioDTO extraerUsuarioDelFormulario(HttpServletRequest request) {
        try {
            UsuarioDTO dto = new UsuarioDTO();

            dto.setNombreUsuario(request.getParameter("nombreUsuario"));
            dto.setPassword(request.getParameter("password")); // Alineado con la propiedad 'password' del modelo y DTO

            String rolStr = request.getParameter("rol");
            if (rolStr != null && !rolStr.isEmpty()) {
                dto.setRol(Rol.valueOf(rolStr));
            }

            String empleadoIdParam = request.getParameter("idEmpleado");
            if (empleadoIdParam != null && !empleadoIdParam.isEmpty()) {
                dto.setIdEmpleado(Integer.parseInt(empleadoIdParam));
            }

            return dto;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}