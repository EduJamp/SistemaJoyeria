package com.liamyimport.util.csv;

import com.liamyimport.model.Producto;
import com.liamyimport.model.Categoria;
import com.liamyimport.util.enums.State;
import java.io.File;

public class ProductoRepository extends GenericCsvRepository<Producto, String> {

    private static final String RUTA = System.getProperty("user.home") + "/OneDrive/Desktop/RepositoryLiamy/productos.csv";

    public ProductoRepository() {
        super(RUTA);

        File archivoCsv = new File(RUTA);
        File carpetaEscritorio = archivoCsv.getParentFile();

        if (carpetaEscritorio != null && !carpetaEscritorio.exists()) {
            carpetaEscritorio.mkdirs();
        }
    }

    @Override
    protected String obtenerId(Producto entidad) {
        return entidad.getCodigoBarras(); // Esta es la llave única del producto
    }

    @Override
    protected String mapearHaciaCsv(Producto p) {
        String idCategoria = (p.getCategoria() != null) ? String.valueOf(p.getCategoria().getId()) : "null";

        return p.getCodigoBarras() + "," +
                p.getImagen() + "," +
                p.getNombre() + "," +
                p.getDescripcion() + "," +
                p.getPrecioUnidad() + "," +
                p.getPrecioX3() + "," +
                p.getPrecioX6() + "," +
                p.getPrecioX12() + "," +
                p.getPrecioPaquete() + "," +
                p.getCantidad() + "," +
                p.getEstado().name() + "," + // Convertimos el Enum State a texto
                idCategoria; // Guardamos solo la llave foránea de la categoría
    }

    @Override
    protected Producto mapearDesdeCsv(String lineaCsv) {
        String[] datos = lineaCsv.split(",");

        if (datos.length < 12) {
            return null;
        }

        Producto p = new Producto();
        p.setCodigoBarras(datos[0]);
        p.setImagen(datos[1]);
        p.setNombre(datos[2]);
        p.setDescripcion(datos[3]);

        // Convertimos los textos nuevamente a double e int
        p.setPrecioUnidad(Double.parseDouble(datos[4]));
        p.setPrecioX3(Double.parseDouble(datos[5]));
        p.setPrecioX6(Double.parseDouble(datos[6]));
        p.setPrecioX12(Double.parseDouble(datos[7]));
        p.setPrecioPaquete(Double.parseDouble(datos[8]));
        p.setCantidad(Integer.parseInt(datos[9]));

        // Convertimos el texto nuevamente al Enum State
        p.setEstado(State.valueOf(datos[10]));

        // Inicializamos la categoría solo con su ID por el momento
        Categoria categoria = new Categoria();
        // categoria.setId(datos[11]); // Descomenta y ajusta esto según cómo sea tu clase Categoria
        p.setCategoria(categoria);

        return p;
    }
}