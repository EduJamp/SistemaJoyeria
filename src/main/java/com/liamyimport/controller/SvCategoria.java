package com.liamyimport.controller;

import com.liamyimport.model.Categoria;
import com.liamyimport.model.Usuario;
import com.liamyimport.util.csv.CategoriaRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/svcategoria")
public class SvCategoria extends HttpServlet {

    private CategoriaRepository repo;

    @Override
    public void init() throws ServletException {
        super.init();
        repo = new CategoriaRepository();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Categoria> listaCategorias = repo.obtenerTodos();
        request.setAttribute("categorias", listaCategorias);

        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {

            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            switch (userLogueado.getRol()) {
                case ADMINISTRADOR:
                    vistaDestino = "view/admin_vista.jsp";
                    request.setAttribute("vistaActiva", "categorias"); // Indicamos que se active la vista de categorías
                    break;
                case VENDEDOR:
                    vistaDestino = "view/vendedor_categorias.jsp";
                    break;
                case CAJERO:
                    vistaDestino = "view/cajero_categorias.jsp";
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

        String accion = request.getParameter("accion");

        if ("crear".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");

            Categoria c = new Categoria();
            c.setNombre(nombre);
            c.setDescripcion(descripcion);

            repo.agregar(c);
        }

        response.sendRedirect("svcategoria");
    }
}