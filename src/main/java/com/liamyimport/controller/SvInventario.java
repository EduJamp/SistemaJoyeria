package com.liamyimport.controller;

import com.liamyimport.facade.EmpleadoFacade;
import com.liamyimport.facade.InventarioFacade;
import com.liamyimport.facade.ProductoFacade;
import com.liamyimport.facade.SedeFacade;
import com.liamyimport.facade.interfaces.IEmpleadoFacade;
import com.liamyimport.facade.interfaces.IInventarioFacade;
import com.liamyimport.facade.interfaces.IProductoFacade;
import com.liamyimport.facade.interfaces.ISedeFacade;
import com.liamyimport.model.Inventario;
import com.liamyimport.model.Usuario;
import com.liamyimport.model.dto.EmpleadoDTO;
import com.liamyimport.model.dto.InventarioDTO;
import com.liamyimport.model.dto.ProductoDTO;
import com.liamyimport.model.dto.SedeDTO;
import com.liamyimport.util.enums.InventoryMovementType;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/svinventario")
public class SvInventario extends HttpServlet {

    private IInventarioFacade inventarioFacade;
    private IProductoFacade productoFacade;
    private ISedeFacade sedeFacade;
    private IEmpleadoFacade empleadoFacade;

    @Override
    public void init() throws ServletException {
        super.init();
        inventarioFacade = new InventarioFacade();
        productoFacade = new ProductoFacade();
        sedeFacade = new SedeFacade();
        empleadoFacade = new EmpleadoFacade();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String criterio = request.getParameter("criterio");
        List<InventarioDTO> listaInventario = new ArrayList<>();

        try {
            // Obtenemos todos los productos registrados en el sistema
            List<ProductoDTO> listaProductos = productoFacade.getAllProducts();

            // Obtenemos los inventarios/conteos previos si ya existen en la BD
            List<InventarioDTO> conteosGuardados = inventarioFacade.getAllInventarios();

            // Cruzamos la información: por cada producto creamos un DTO de inventario para el conteo
            if (listaProductos != null) {
                for (ProductoDTO prod : listaProductos) {
                    // Filtrar por criterio de búsqueda si se ingresó alguno
                    if (criterio != null && !criterio.trim().isEmpty()) {
                        boolean matchNombre = prod.getNombre() != null && prod.getNombre().toLowerCase().contains(criterio.toLowerCase());
                        boolean matchCodigo = prod.getCodigoBarras() != null && prod.getCodigoBarras().toLowerCase().contains(criterio.toLowerCase());
                        if (!matchNombre && !matchCodigo) {
                            continue; // Si no coincide, pasamos al siguiente
                        }
                    }

                    InventarioDTO invDto = new InventarioDTO();
                    invDto.setIdProducto(prod.getId());
                    invDto.setCodigoBarras(prod.getCodigoBarras());
                    invDto.setNombreProducto(prod.getNombre());
                    invDto.setNombreSede("Sede Central"); // O asigna la sede actual según tu lógica

                    // Asignamos stock del sistema del producto (puedes adaptarlo si manejas StockSede)
                    invDto.setStockSistema(10); // Valor por defecto o el stock real del producto si lo tienes en ProductoDTO

                    // Verificamos si ya tiene un conteo previo guardado en la BD
                    if (conteosGuardados != null) {
                        for (InventarioDTO guardado : conteosGuardados) {
                            if (guardado.getIdProducto() == prod.getId()) {
                                invDto.setIdInventario(guardado.getIdInventario());
                                invDto.setStockFisico(guardado.getStockFisico());
                                invDto.setFechaConteo(guardado.getFechaConteo());
                                invDto.setEstado(guardado.getEstado());
                                break;
                            }
                        }
                    }

                    listaInventario.add(invDto);
                }
            }

            // Listas auxiliares para los selectores o modales
            List<SedeDTO> listaSedes = sedeFacade.getSedes();
            List<EmpleadoDTO> listaEmpleados = empleadoFacade.getAllEmployees();

            request.setAttribute("listaInventario", listaInventario);
            request.setAttribute("listaSedes", listaSedes);
            request.setAttribute("listaEmpleados", listaEmpleados);
            request.setAttribute("vistaActiva", "conteo-productos");

        } catch (SQLException e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession(false);
        String vistaDestino = "index.jsp";

        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            if (userLogueado.getRol() != null) {
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
                    default:
                        vistaDestino = "index.jsp";
                        break;
                }
            }

            request.getRequestDispatcher(vistaDestino).forward(request, response);
        } else {
            response.sendRedirect(vistaDestino);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "crear":
                    crearInventario(request);
                    break;
                case "actualizar":
                    actualizarInventario(request);
                    break;
                case "eliminar":
                    eliminarInventario(request);
                    break;
                case "guardarConteo":
                    guardarConteoMasivo(request);
                    break;
            }
        }

        response.sendRedirect(request.getContextPath() + "/svinventario");
    }

    private void crearInventario(HttpServletRequest request) {
        InventarioDTO dto = extraerInventarioDelFormulario(request);
        if (dto != null) {
            inventarioFacade.addInventario(dto);
        }
    }

    private void actualizarInventario(HttpServletRequest request) {
        InventarioDTO dto = extraerInventarioDelFormulario(request);
        String idParam = request.getParameter("idInventario");

        if (idParam != null && !idParam.isEmpty() && dto != null) {
            dto.setIdInventario(Integer.parseInt(idParam));
            inventarioFacade.updateInventario(dto);
        }
    }

    private void eliminarInventario(HttpServletRequest request) {
        String idParam = request.getParameter("idInventario");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            inventarioFacade.deleteInventario(id);
        }
    }

    private void guardarConteoMasivo(HttpServletRequest request) {
        try {
            String fechaActual = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

            // Obtenemos el ID del empleado logueado en la sesión de forma segura
            HttpSession session = request.getSession(false);
            int idEmpleadoLogueado = 0;
            if (session != null && session.getAttribute("usuarioLogueado") != null) {
                Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
                if (user.getEmpleado() != null) {
                    idEmpleadoLogueado = user.getEmpleado().getIdEmpleado();
                }
            }

            // Recorremos los parámetros de manera segura filtrando los que empiezan con "contado_"
            java.util.Enumeration<String> parameterNames = request.getParameterNames();
            while (parameterNames != null && parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();

                if (paramName != null && paramName.startsWith("contado_")) {
                    String idStr = paramName.substring("contado_".length());
                    String valorContadoStr = request.getParameter(paramName);

                    if (valorContadoStr != null && !valorContadoStr.trim().isEmpty()) {
                        int stockFisico = Integer.parseInt(valorContadoStr.trim());
                        int idProducto = Integer.parseInt(idStr);

                        // Consultamos el producto mediante el facade
                        ProductoDTO prod = productoFacade.getProductById(idProducto);
                        int stockSistema = (prod != null) ? prod.getCantidad() : 0;
                        double precioUnidad = (prod != null) ? prod.getPrecioUnidad() : 0.0;

                        InventarioDTO dto = new InventarioDTO();
                        dto.setIdProducto(idProducto);
                        dto.setStockFisico(stockFisico);
                        dto.setStockSistema(stockSistema);
                        dto.setIdEmpleado(idEmpleadoLogueado);
                        dto.setFechaConteo(fechaActual);
                        dto.setIdSede(1);

                        int diferencia = stockFisico - stockSistema;
                        if (diferencia < 0) {
                            dto.setFaltantes(Math.abs(diferencia));
                            dto.setSobrantes(0);
                            dto.setEstado("faltante");
                            dto.setImpacto(Math.abs(diferencia) * precioUnidad);
                        } else if (diferencia > 0) {
                            dto.setSobrantes(diferencia);
                            dto.setFaltantes(0);
                            dto.setEstado("sobrante");
                            dto.setImpacto(0.0);
                        } else {
                            dto.setFaltantes(0);
                            dto.setSobrantes(0);
                            dto.setEstado("correcto");
                            dto.setImpacto(0.0);
                        }

                        inventarioFacade.addInventario(dto);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private InventarioDTO extraerInventarioDelFormulario(HttpServletRequest request) {
        try {
            InventarioDTO dto = new InventarioDTO();

            String stockSistemaStr = request.getParameter("stockSistema");
            String stockFisicoStr = request.getParameter("stockFisico");
            String idProductoStr = request.getParameter("idProducto");
            String idSedeStr = request.getParameter("idSede");
            String idEmpleadoStr = request.getParameter("idEmpleado");
            String estado = request.getParameter("estado");

            if (stockSistemaStr != null && !stockSistemaStr.isEmpty()) {
                dto.setStockSistema(Integer.parseInt(stockSistemaStr));
            }

            if (stockFisicoStr != null && !stockFisicoStr.isEmpty()) {
                int fisico = Integer.parseInt(stockFisicoStr);
                dto.setStockFisico(fisico);

                int diferencia = fisico - dto.getStockSistema();
                if (diferencia < 0) {
                    dto.setFaltantes(Math.abs(diferencia));
                    dto.setSobrantes(0);
                } else {
                    dto.setSobrantes(diferencia);
                    dto.setFaltantes(0);
                }
            }

            if (idProductoStr != null && !idProductoStr.isEmpty()) {
                dto.setIdProducto(Integer.parseInt(idProductoStr));
            }

            if (idSedeStr != null && !idSedeStr.isEmpty()) {
                dto.setIdSede(Integer.parseInt(idSedeStr));
            }

            if (idEmpleadoStr != null && !idEmpleadoStr.isEmpty()) {
                dto.setIdEmpleado(Integer.parseInt(idEmpleadoStr));
            }

            dto.setEstado(estado != null ? estado : "REGISTRADO");
            dto.setFechaConteo(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

            return dto;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}