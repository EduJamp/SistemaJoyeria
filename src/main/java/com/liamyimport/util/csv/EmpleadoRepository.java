package com.liamyimport.util.csv;

import com.liamyimport.util.enums.TypeIdentityDocument;
import com.liamyimport.model.Empleado;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;

public class EmpleadoRepository extends GenericCsvRepository<Empleado, Integer> {

    public EmpleadoRepository() {
        super(System.getProperty("user.home") + "/OneDrive/Desktop/RepositoryLiamy/empleados.csv");
        verificarYCrearArchivoVacio();
    }

    private void verificarYCrearArchivoVacio() {
        File file = new File(System.getProperty("user.home") + "/OneDrive/Desktop/RepositoryLiamy/empleados.csv");
        if (!file.exists()) {
            try {
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
    protected Empleado mapearDesdeCsv(String lineaCsv) {
        String[] datos = lineaCsv.split(",");

        if (datos.length < 10) {
            return null;
        }

        Empleado emp = new Empleado();
        emp.setNombre(datos[0].trim());
        emp.setApellido(datos[1].trim());
        emp.setTipoDocumento(TypeIdentityDocument.valueOf(datos[2].trim()));
        emp.setNumeroDocumento(Integer.parseInt(datos[3].trim()));
        emp.setTelefono(Integer.parseInt(datos[4].trim()));
        emp.setDireccion(datos[5].trim());

        emp.setFechaNacimiento(!datos[6].trim().isEmpty() && !datos[6].equals("null") ? LocalDate.parse(datos[6].trim()) : null);

        emp.setSalario(Integer.parseInt(datos[7].trim()));

        emp.setFechaInicio(!datos[8].trim().isEmpty() && !datos[8].equals("null") ? LocalDate.parse(datos[8].trim()) : null);
        emp.setFechaFin(!datos[9].trim().isEmpty() && !datos[9].equals("null") ? LocalDate.parse(datos[9].trim()) : null);

        return emp;
    }

    @Override
    protected String mapearHaciaCsv(Empleado emp) {
        return emp.getNombre() + "," +
                emp.getApellido() + "," +
                emp.getTipoDocumento() + "," +
                emp.getNumeroDocumento() + "," +
                emp.getTelefono() + "," +
                emp.getDireccion() + "," +
                emp.getFechaNacimiento() + "," +
                emp.getSalario() + "," +
                emp.getFechaInicio() + "," +
                emp.getFechaFin();
    }

    @Override
    protected Integer obtenerId(Empleado entidad) {
        return entidad.getNumeroDocumento();
    }
}