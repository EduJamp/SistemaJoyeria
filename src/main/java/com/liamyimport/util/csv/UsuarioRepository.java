package com.liamyimport.util.csv;

import com.liamyimport.util.enums.Rol;
import com.liamyimport.model.Empleado;
import com.liamyimport.model.Usuario;

public class UsuarioRepository extends GenericCsvRepository<Usuario, String>{

    public UsuarioRepository() {
        super(System.getProperty("user.home") + "/OneDrive/Desktop/RepositoryLiamy/usuarios.csv");
    }

    @Override
    protected Usuario mapearDesdeCsv(String lineaCsv) {
        String[] datos = lineaCsv.split(",");

        if (datos.length < 3) {
            return null;
        }

        Usuario u = new Usuario();
        u.setNombreUsuario(datos[0]);
        u.setContraseña(datos[1]);
        u.setRol(Rol.valueOf(datos[2]));

        if (datos.length >= 4 && !datos[3].equals("0")) {
            try {
                int numDoc = Integer.parseInt(datos[3]);
                EmpleadoRepository empRepo = new EmpleadoRepository();
                Empleado emp = empRepo.buscarPorId(numDoc);
                u.setEmpleado(emp);
            } catch (Exception e) {
                u.setEmpleado(null);
            }
        }

        return u;
    }

    @Override
    protected String mapearHaciaCsv(Usuario u) {
        // Cómo se guarda en el Excel
        String docEmpleado = "0"; // Valor por defecto si no tiene empleado
        if (u.getEmpleado() != null) {
            docEmpleado = String.valueOf(u.getEmpleado().getNumeroDocumento());
        }

        return u.getNombreUsuario() + "," +
                u.getContraseña() + "," +
                u.getRol().name() + "," +
                docEmpleado;
    }

    @Override
    protected String obtenerId(Usuario entidad) {
        return entidad.getNombreUsuario();
    }
}
