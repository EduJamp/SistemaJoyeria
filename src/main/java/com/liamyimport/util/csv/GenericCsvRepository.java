package com.liamyimport.util.csv;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public abstract class GenericCsvRepository<T, ID> {

    private final String rutaArchivo;

    public GenericCsvRepository(String rutaArchivo) {
        this.rutaArchivo = rutaArchivo;
    }

    // Cada clase hija (UsuarioRepo, ProductoRepo) deberá enseñar cómo hacer esto:
    protected abstract T mapearDesdeCsv(String lineaCsv);
    protected abstract String mapearHaciaCsv(T entidad);
    protected abstract ID obtenerId(T entidad);

    // --- 1. MOSTRAR TODOS (READ ALL) ---
    public List<T> obtenerTodos() {
        List<T> lista = new ArrayList<>();
        File archivo = new File(rutaArchivo);
        if (!archivo.exists()) return lista;

        try (BufferedReader br = new BufferedReader(new FileReader(archivo))) {
            String linea;
            while ((linea = br.readLine()) != null) {
                // IGNORAR LÍNEAS EN BLANCO: Si la línea está vacía, la saltamos
                if (linea.trim().isEmpty()) {
                    continue;
                }

                T entidad = mapearDesdeCsv(linea);
                // Si la entidad se creó correctamente, la agregamos
                if (entidad != null) {
                    lista.add(entidad);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // --- 2. BUSCAR POR ID (READ ONE) ---
    public T buscarPorId(ID id) {
        for (T entidad : obtenerTodos()) {
            // DOBLE VALIDACIÓN: Nos aseguramos de que entidad no sea nula antes de pedir su ID
            if (entidad != null && obtenerId(entidad) != null && obtenerId(entidad).equals(id)) {
                return entidad;
            }
        }
        return null;
    }

    // --- AGREGAR (CREATE) ---
    public void agregar(T entidad) {
        // 'true' al final de FileWriter significa "añadir al final del archivo"
        try (FileWriter fw = new FileWriter(rutaArchivo, true);
             PrintWriter pw = new PrintWriter(fw)) {
            pw.println(mapearHaciaCsv(entidad));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // --- ACTUALIZAR (UPDATE) ---
    public void actualizar(T entidadActualizada) {
        List<T> lista = obtenerTodos();
        for (int i = 0; i < lista.size(); i++) {
            // Buscamos el objeto viejo que tenga el mismo ID que el nuevo
            if (obtenerId(lista.get(i)).equals(obtenerId(entidadActualizada))) {
                lista.set(i, entidadActualizada); // Lo reemplazamos en la lista
                break;
            }
        }
        sobrescribirArchivo(lista);
    }

    // --- ELIMINAR (DELETE) ---
    public void eliminar(ID id) {
        List<T> lista = obtenerTodos();
        // Borramos de la lista el elemento que coincida con el ID
        lista.removeIf(entidad -> obtenerId(entidad).equals(id));
        sobrescribirArchivo(lista);
    }

    // MÉTODO INTERNO PARA GUARDAR CAMBIOS MASIVOS
    private void sobrescribirArchivo(List<T> lista) {
        // 'false' significa que borra todo el contenido viejo y escribe el nuevo
        try (FileWriter fw = new FileWriter(rutaArchivo, false);
             PrintWriter pw = new PrintWriter(fw)) {
            for (T entidad : lista) {
                pw.println(mapearHaciaCsv(entidad));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
