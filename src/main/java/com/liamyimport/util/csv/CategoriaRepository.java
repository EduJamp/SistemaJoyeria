package com.liamyimport.util.csv;

import com.liamyimport.model.Categoria;

import java.io.File;
import java.io.IOException;

public class CategoriaRepository extends GenericCsvRepository<Categoria, Integer> {

    public CategoriaRepository() {
        super(System.getProperty("user.home") + "/OneDrive/Desktop/RepositoryLiamy/categorias.csv");
        verificarYCrearArchivoVacio();
    }

    private void verificarYCrearArchivoVacio() {
        File file = new File(System.getProperty("user.home") + "/OneDrive/Desktop/RepositoryLiamy/categorias.csv");
        if (!file.exists()) {
            try {
                // Asegura que la carpeta contenedora exista
                if (file.getParentFile() != null) {
                    file.getParentFile().mkdirs();
                }
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected Categoria mapearDesdeCsv(String lineaCsv) {
        String[] datos = lineaCsv.split(",");

        if (datos.length < 2) {
            return null;
        }

        Categoria c = new Categoria();
        c.setId(Integer.parseInt(datos[0].trim()));
        c.setNombre(datos[1].trim());

        if (datos.length >= 3) {
            c.setDescripcion(datos[2].trim());
        }

        return c;
    }

    @Override
    protected String mapearHaciaCsv(Categoria c) {
        String descripcion = c.getDescripcion() != null ? c.getDescripcion() : "";
        return c.getId() + "," +
                c.getNombre() + "," +
                descripcion;
    }

    @Override
    protected Integer obtenerId(Categoria entidad) {
        return entidad.getId();
    }
}