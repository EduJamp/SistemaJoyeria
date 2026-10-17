package com.liamyimport.facade;

import com.liamyimport.facade.interfaces.IProductoFacade;
import com.liamyimport.mapper.ProductoMapper;
import com.liamyimport.model.Producto;
import com.liamyimport.model.dto.ProductoDTO;
import com.liamyimport.persistence.dao.ProductoDAO;
import com.liamyimport.persistence.dao.interfaces.IProductoDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoFacade implements IProductoFacade {
    private IProductoDAO productoDAO = new ProductoDAO();

    @Override
    public boolean addProduct(ProductoDTO dto) throws SQLException {
        try {
            if (dto != null && !dto.getNombre().trim().isEmpty()) {

                Producto p = ProductoMapper.toEntity(dto);
                boolean guardado = productoDAO.addProducto(p);

                if (guardado) {
                    if (dto.getCantidad() >= 0 && dto.getIdSede() > 0) {
                        productoDAO.registerStockInitial(p.getId(), dto.getIdSede(), dto.getCantidad());
                    }
                    return true;
                }
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ProductoDTO> getAllProducts() throws SQLException {
        try {
            List<Producto> productos = productoDAO.getAllProductos();

            return productos.stream()
                    .map(ProductoMapper::toDTO)
                    .toList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ProductoDTO> searchProducts(ProductoDTO dto) throws SQLException {
        try {
            String criterio = (dto != null && dto.getNombre() != null) ? dto.getNombre() : "";

            List<Producto> productos = productoDAO.searchProduct(criterio);

            if (productos != null && !productos.isEmpty()) {
                return productos.stream()
                        .map(ProductoMapper::toDTO)
                        .toList();
            }

            return new ArrayList<>();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateProduct(ProductoDTO dto) throws SQLException {
        try {
            if (dto != null && dto.getNombre() != null && !dto.getNombre().trim().isEmpty()) {
                boolean actualizado = productoDAO.updateProducto(ProductoMapper.toEntity(dto));

                if (actualizado && dto.getIdSede() > 0) {
                    productoDAO.updateStock(dto.getId(), dto.getIdSede(), dto.getCantidad());
                }
                return actualizado;
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteProduct(int id) throws SQLException {
        try {
            if (id > 0) {
                return productoDAO.deleteProducto(id);
            }

            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public ProductoDTO getProductById(int id) throws SQLException {
        try {
            if (id > 0) {
                Producto producto = productoDAO.getProductById(id);
                return producto != null ? ProductoMapper.toDTO(producto) : null;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}