package com.liamyimport.persistence.dao.interfaces;

import com.liamyimport.model.Producto;

import java.sql.SQLException;
import java.util.List;

public interface IProductoDAO {
    boolean addProducto(Producto producto) throws SQLException;
    List<Producto> getAllProductos() throws SQLException;
    Producto getProductById(int id) throws SQLException;
    List<Producto> searchProduct(String criterio) throws SQLException;
    boolean updateProducto(Producto producto) throws SQLException;
    boolean deleteProducto(int id) throws SQLException;
    void registerStockInitial(int idProducto, int idSede, int cantidad) throws  SQLException;
    boolean updateStock(int idProducto, int idSede, int nuevaCantidad) throws SQLException;
}
