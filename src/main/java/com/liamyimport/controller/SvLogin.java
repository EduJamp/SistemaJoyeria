package com.liamyimport.controller;

import com.liamyimport.facade.UsuarioFacade;
import com.liamyimport.facade.interfaces.IUsuarioFacade;
import com.liamyimport.mapper.UsuarioMapper;
import com.liamyimport.model.dto.UsuarioDTO;
import com.liamyimport.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/svlogin")
public class SvLogin extends HttpServlet {
    private IUsuarioFacade usuarioFacade;

    public SvLogin() {
    }

    @Override
    public void init() throws ServletException {
        super.init();
        usuarioFacade = new UsuarioFacade();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String userParam = request.getParameter("nombreUsuario");
        String userPass = request.getParameter("password");

        Usuario usuarioAutenticado = null;

        try {
            List<UsuarioDTO> listaDTOs = usuarioFacade.getAllUsers();

            if (listaDTOs != null) {
                for (UsuarioDTO dto : listaDTOs) {
                    if (dto.getNombreUsuario() != null &&
                            dto.getNombreUsuario().equals(userParam) &&
                            dto.getPassword() != null &&
                            dto.getPassword().equals(userPass)) {

                        usuarioAutenticado = UsuarioMapper.toEntity(dto);
                        break;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (usuarioAutenticado != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuarioLogueado", usuarioAutenticado);

            if (usuarioAutenticado.getRol() != null) {
                switch (usuarioAutenticado.getRol()) {
                    case ADMINISTRADOR:
                        response.sendRedirect("view/admin_vista.jsp");
                        break;
                    case VENDEDOR:
                        response.sendRedirect("view/vendedor_vista.jsp");
                        break;
                    case CAJERO:
                        response.sendRedirect("view/cajero_vista.jsp");
                        break;
                    default:
                        response.sendRedirect("index.jsp");
                        break;
                }
            } else {
                response.sendRedirect("index.jsp");
            }

        } else {
            request.setAttribute("error", "true");
            request.setAttribute("mensajeError", "El usuario o la contraseña no coinciden.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><title>SvLogin</title></head>");
            out.println("<body>");
            out.println("<h2>" + request.getContextPath() + "</h2>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
