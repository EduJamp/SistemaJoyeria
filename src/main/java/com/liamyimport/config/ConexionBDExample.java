package com.liamyimport.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBDExample {
    private static ConexionBDExample instancia;
    private Connection conexion;

    private static final String URL = "jdbc:postgresql://localhost:5432/nombre_de_tu_base_de_datos";
    private static final String USER = "nombre_usuario_postgresql";
    private static final String PASSWORD = "contraseña_postgresql";

    public ConexionBDExample() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver de PostgreSQL no encontrado.");
            e.printStackTrace();
        }
    }

    public static synchronized ConexionBDExample getInstancia() {
        if (instancia == null) {
            instancia = new ConexionBDExample();
        }
        return instancia;
    }

    public Connection getConexion() {
        try {
            if (conexion == null || conexion.isClosed()) {
                conexion = DriverManager.getConnection(URL, USER, PASSWORD);
            }
        } catch (SQLException e) {
            System.err.println("Error al conectar a la base de datos.");
            e.printStackTrace();
        }
        return conexion;
    }

    public void cerrarConexion() {
        if (conexion != null) {
            try {
                if (!conexion.isClosed()) {
                    conexion.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
