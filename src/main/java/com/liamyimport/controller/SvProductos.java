package com.liamyimport.controller;

import com.liamyimport.util.enums.State;
import com.liamyimport.model.Categoria;
import com.liamyimport.model.Producto;
import com.liamyimport.model.Usuario; // <-- Importación necesaria para leer el rol
import com.liamyimport.util.csv.ProductoRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // <-- Importación necesaria para la sesión

import java.io.IOException;
import java.util.List;

@WebServlet("/svproducto")
public class SvProductos extends HttpServlet {

    private ProductoRepository repo;

    @Override
    public void init() throws ServletException {
        super.init();
        repo = new ProductoRepository();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Cargamos todos los productos del CSV
        List<Producto> listaProductos = repo.obtenerTodos();
        request.setAttribute("productos", listaProductos);

        // Evaluamos la sesión para saber a qué vista separada redirigir
        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {

            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            switch (userLogueado.getRol()) {
                case ADMINISTRADOR:
                    vistaDestino = "view/admin_vista.jsp";
                    request.setAttribute("vistaActiva", "productos");
                    break;
                case VENDEDOR:
                    vistaDestino = "view/vendedor_vista.jsp";
                    request.setAttribute("vistaActiva", "productos");
                    break;
                case CAJERO:
                    vistaDestino = "view/cajero_vista.jsp";
                    break;
            }

            // Redirigimos a la vista seleccionada con los productos cargados
            request.getRequestDispatcher(vistaDestino).forward(request, response);

        } else {
            // Si intenta entrar sin iniciar sesión
            response.sendRedirect(vistaDestino);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null) {

            switch (accion) {

                case "crear":
                    crearProducto(request);
                    break;

                case "actualizar":
                    actualizarProducto(request);
                    break;

                case "eliminar":
                    eliminarProducto(request);
                    break;
            }
        }

        response.sendRedirect("svproducto");
    }

    private void crearProducto(HttpServletRequest request) {
        Producto p = extraerProductoDelFormulario(request);
        repo.agregar(p);
    }

    private void actualizarProducto(HttpServletRequest request) {
        Producto p = extraerProductoDelFormulario(request);
        repo.actualizar(p);
    }

    private void eliminarProducto(HttpServletRequest request) {
        String codigoBarras = request.getParameter("codigoBarras");
        repo.eliminar(codigoBarras);
    }

    private Producto extraerProductoDelFormulario(
            HttpServletRequest request) {

        Producto p = new Producto();

        p.setCodigoBarras(request.getParameter("codigoBarras"));
        p.setNombre(request.getParameter("nombre"));
        p.setDescripcion(request.getParameter("descripcion"));
        p.setImagen(request.getParameter("imagen"));
        p.setPrecioUnidad(Double.parseDouble(request.getParameter("precioUnidad")));
        p.setPrecioX3(Double.parseDouble(request.getParameter("precioX3")));
        p.setPrecioX6(Double.parseDouble(request.getParameter("precioX6")));
        p.setPrecioX12(Double.parseDouble(request.getParameter("precioX12")));
        p.setPrecioPaquete(Double.parseDouble(request.getParameter("precioPaquete")));
        p.setCantidad(Integer.parseInt(request.getParameter("cantidad")));

        String estado = request.getParameter("estado");
        p.setEstado(State.valueOf(estado));

        String idCategoriaParam = request.getParameter("idCategoria");
        int idCategoria = Integer.parseInt(idCategoriaParam);

        Categoria categoria = new Categoria();
        categoria.setId(idCategoria);
        p.setCategoria(categoria);

        return p;
    }
}