package com.liamyimport.facade.interfaces;

import com.liamyimport.model.Producto;
import com.liamyimport.model.dto.ProductoDTO;

import java.sql.SQLException;
import java.util.List;

public interface IProductoFacade {
    boolean addProduct(ProductoDTO dto) throws SQLException;
    List<ProductoDTO> getAllProducts() throws SQLException;
    List<ProductoDTO> searchProducts(ProductoDTO dto) throws SQLException;
    boolean updateProduct(ProductoDTO dto) throws SQLException;
    boolean deleteProduct(int id) throws SQLException;
    ProductoDTO getProductById(int id) throws SQLException;
}
