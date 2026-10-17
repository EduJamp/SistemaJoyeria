package com.liamyimport.controller;

import com.liamyimport.facade.CategoriaFacade;
import com.liamyimport.facade.ProductoFacade;
import com.liamyimport.facade.interfaces.ICategoriaFacade;
import com.liamyimport.facade.interfaces.IProductoFacade;
import com.liamyimport.model.Categoria;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.CategoriaDTO;
import com.liamyimport.model.dto.ProductoDTO;
import com.liamyimport.util.enums.State;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/svproducto")
public class SvProductos extends HttpServlet {

    private IProductoFacade facade;
    private ICategoriaFacade categoriaFacade;

    @Override
    public void init() throws ServletException {
        super.init();
        facade = new ProductoFacade();
        categoriaFacade = new CategoriaFacade();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String criterio = request.getParameter("criterio");
            List<ProductoDTO> listaProductos;

            if (criterio != null && !criterio.trim().isEmpty()) {
                ProductoDTO searchDto = new ProductoDTO();
                searchDto.setNombre(criterio);
                listaProductos = facade.searchProducts(searchDto);
            } else {
                listaProductos = facade.getAllProducts();
            }

            request.setAttribute("productos", listaProductos);

            List<CategoriaDTO> listaCategorias = categoriaFacade.getCategorias();
            request.setAttribute("categorias", listaCategorias);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar los productos: " + e.getMessage());
        }

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

            request.getRequestDispatcher(vistaDestino).forward(request, response);

        } else {
            response.sendRedirect(vistaDestino);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
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
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("svproducto");
    }

    private void crearProducto(HttpServletRequest request) throws SQLException {
        ProductoDTO dto = extraerProductoDelFormulario(request);

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            dto.setIdSede(1);
        }

        facade.addProduct(dto);
    }

    private void actualizarProducto(HttpServletRequest request) throws SQLException {
        ProductoDTO dto = extraerProductoDelFormulario(request);

        String idParam = request.getParameter("idProducto");
        if (idParam != null && !idParam.isEmpty()) {
            dto.setId(Integer.parseInt(idParam));
        }

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            dto.setIdSede(1);
        }

        facade.updateProduct(dto);
    }

    private void eliminarProducto(HttpServletRequest request) throws SQLException {
        String idParam = request.getParameter("idProducto");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            facade.deleteProduct(id);
        }
    }

    private ProductoDTO extraerProductoDelFormulario(HttpServletRequest request) {
        ProductoDTO dto = new ProductoDTO();

        dto.setCodigoBarras(request.getParameter("codigoBarras"));
        dto.setNombre(request.getParameter("nombre"));
        dto.setDescripcion(request.getParameter("descripcion"));
        dto.setImagen(request.getParameter("imagen"));

        String precioUnidad = request.getParameter("precioUnidad");
        if (precioUnidad != null && !precioUnidad.isEmpty()) dto.setPrecioUnidad(Double.parseDouble(precioUnidad));

        String precio3 = request.getParameter("precio3");
        if (precio3 != null && !precio3.isEmpty()) dto.setPrecioX3(Double.parseDouble(precio3));

        String precio6 = request.getParameter("precio6");
        if (precio6 != null && !precio6.isEmpty()) dto.setPrecioX6(Double.parseDouble(precio6));

        String precio12 = request.getParameter("precio12");
        if (precio12 != null && !precio12.isEmpty()) dto.setPrecioX12(Double.parseDouble(precio12));

        String precioPaquete = request.getParameter("precioPaquete");
        if (precioPaquete != null && !precioPaquete.isEmpty()) dto.setPrecioPaquete(Double.parseDouble(precioPaquete));

        String estado = request.getParameter("estado");
        if (estado != null && !estado.isEmpty()) {
            dto.setEstado(State.valueOf(estado.toLowerCase()));
        }

        String idCategoriaParam = request.getParameter("idCategoria");
        if (idCategoriaParam != null && !idCategoriaParam.isEmpty()) {
            Categoria cat = new Categoria();
            cat.setId(Integer.parseInt(idCategoriaParam));
            dto.setCategoria(cat);
        }

        String cantidadParam = request.getParameter("cantidad");
        if (cantidadParam != null && !cantidadParam.isEmpty()) {
            dto.setCantidad(Integer.parseInt(cantidadParam));
        }

        return dto;
    }
}