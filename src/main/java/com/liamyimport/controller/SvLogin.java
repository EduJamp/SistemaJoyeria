package com.liamyimport.controller;

import com.liamyimport.util.enums.Rol;
import com.liamyimport.util.enums.TypeIdentityDocument;
import com.liamyimport.model.Empleado;
import com.liamyimport.model.Usuario;
import com.liamyimport.util.csv.UsuarioRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/svlogin") // Ruta accesible en el navegador: http://localhost:8081/LiammyImport/svlogin
public class SvLogin extends HttpServlet {
    private UsuarioRepository uRepo;

    public SvLogin() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userParam = request.getParameter("usuario");
        String userPass = request.getParameter("password");

        Usuario usuarioAutenticado = null;

        List<Usuario> usuarios = uRepo.obtenerTodos();

        for (Usuario usuarioActual : usuarios) {
            if (usuarioActual.getNombreUsuario().equals(userParam) &&
                    usuarioActual.getContraseña().equals(userPass)) {

                usuarioAutenticado = usuarioActual;
                break;
            }
        }

        if (usuarioAutenticado != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuarioLogueado", usuarioAutenticado);

            switch (usuarioAutenticado.getRol()) {
                case ADMINISTRADOR:
                    response.sendRedirect("view/admin_vista.jsp");
                    break;
                case VENDEDOR:
                    response.sendRedirect("view/vendedor_vista.jsp");
                    break;
                case CAJERO:
                    response.sendRedirect("view/cajero_vista.jsp");
                    break;
                default:
                    response.sendRedirect("index.jsp");
                    break;
            }

        } else {
            request.setAttribute("error", "true");
            request.setAttribute("mensajeError", "El usuario o la contraseña no coinciden.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    }

    @Override
    public void init() throws ServletException {
        super.init();
        uRepo = new UsuarioRepository();

        Usuario adminExistente = uRepo.buscarPorId("edu@admin");

        if (adminExistente == null) {
            Empleado empleado = new Empleado();
            empleado.setNombre("Edu Jampier");
            empleado.setApellido("Caceres Ruiz");
            empleado.setTipoDocumento(TypeIdentityDocument.DNI);
            empleado.setNumeroDocumento(77372155);
            empleado.setTelefono(924919132);
            empleado.setDireccion("Elias Aguirre cdra 13");
            empleado.setFechaNacimiento(LocalDate.of(2005, 6, 13));
            empleado.setSalario(200);
            empleado.setFechaInicio(LocalDate.now());
            empleado.setFechaFin(LocalDate.now().plusMonths(3));

            Usuario usuario = new Usuario();
            usuario.setNombreUsuario("edu@admin");
            usuario.setContraseña("123456"); // Recuerda usar el nombre de tu método exacto
            usuario.setRol(Rol.ADMINISTRADOR);
            usuario.setEmpleado(empleado);

            uRepo.agregar(usuario);

            System.out.println("Administrador creado y guardado en el archivo CSV exitosamente.");

        } else {
            System.out.println("El administrador ya existe en el archivo CSV. Omitiendo creación.");
        }
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><title>SvLogin</title></head>");
            out.println("<body>");
            out.println("<h2>" + request.getContextPath() + "</h2>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
