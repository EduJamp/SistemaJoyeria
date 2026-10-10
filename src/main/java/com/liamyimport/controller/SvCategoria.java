package com.liamyimport.controller;

import com.liamyimport.facade.CategoriaFacade;
import com.liamyimport.facade.interfaces.ICategoriaFacade;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.CategoriaDTO;

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

    private ICategoriaFacade categoriaFacade;

    @Override
    public void init() throws ServletException {
        super.init();
        categoriaFacade = new CategoriaFacade();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("vistaActiva", "categorias");

        String criterio = request.getParameter("criterio");
        List<CategoriaDTO> listaCategorias;

        if (criterio != null && !criterio.trim().isEmpty()) {
            CategoriaDTO dtoBusqueda = new CategoriaDTO(0, criterio, null);
            listaCategorias = categoriaFacade.searchCategorias(dtoBusqueda);
        } else {
            listaCategorias = categoriaFacade.getCategorias();
        }

        request.setAttribute("categorias", listaCategorias);

        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            switch (userLogueado.getRol()) {
                case ADMINISTRADOR:
                    vistaDestino = "view/admin_vista.jsp";
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "crear":
                    crearCategoria(request);
                    break;
                case "actualizar":
                    actualizarCategoria(request);
                    break;
                case "eliminar":
                    eliminarCategoria(request);
                    break;
            }
        }

        response.sendRedirect("svcategoria");
    }

    private void crearCategoria(HttpServletRequest request) {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        CategoriaDTO dto = new CategoriaDTO(0, nombre, descripcion);
        categoriaFacade.createCategoria(dto);
    }

    private void actualizarCategoria(HttpServletRequest request) {
        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            CategoriaDTO dto = new CategoriaDTO(id, nombre, descripcion);
            categoriaFacade.modifyCategoria(dto);
        }
    }

    private void eliminarCategoria(HttpServletRequest request) {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            categoriaFacade.deleteCategoria(id);
        }
    }
}