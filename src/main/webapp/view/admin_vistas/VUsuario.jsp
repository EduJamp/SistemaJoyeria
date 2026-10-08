<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Usuario" %>
<%@ page import="com.liamyimport.model.Empleado" %>
<%
boolean esUsuarios = "usuarios".equals(request.getAttribute("vistaActiva"));
List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("usuarios");
  List<Empleado> listaEmpleadosUsuarios = (List<Empleado>) request.getAttribute("empleados");

    // Cálculo dinámico de KPIs
    int totalUsers = 0, totalAdmins = 0, totalVendedores = 0, totalCajeros = 0;
    if(listaUsuarios != null) {
    totalUsers = listaUsuarios.size();
    for(Usuario u : listaUsuarios) {
    if(u.getRol() != null) {
    String rolName = u.getRol().name().toUpperCase();
    if(rolName.contains("ADMIN")) totalAdmins++;
    else if(rolName.contains("VENDEDOR")) totalVendedores++;
    else if(rolName.contains("CAJERO")) totalCajeros++;
    }
    }
    }
    %>

    <section id="view-usuarios" class="view-section <%= esUsuarios ? "active" : "" %>">

    <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
      <div>
        <h3 class="fw-bold title-font mb-1">Usuarios</h3>
        <p class="text-muted mb-0">Administración de usuarios del sistema.</p>
      </div>
      <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoUsuarioModal">
        <i class="bi bi-plus-lg"></i> Nuevo usuario
      </button>
    </div>

    <!-- KPIs RÁPIDOS -->
    <div class="row g-3 mb-4">
      <div class="col-6 col-lg-3">
        <div class="custom-card card border-0 h-100">
          <div class="card-body p-3">
            <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL USUARIOS</small>
            <span class="fw-bold fs-5"><%= totalUsers %></span>
          </div>
        </div>
      </div>
      <div class="col-6 col-lg-3">
        <div class="custom-card card border-0 h-100">
          <div class="card-body p-3">
            <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">ADMINISTRADORES</small>
            <span class="fw-bold fs-5"><%= totalAdmins %></span>
          </div>
        </div>
      </div>
      <div class="col-6 col-lg-3">
        <div class="custom-card card border-0 h-100">
          <div class="card-body p-3">
            <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">VENDEDORES</small>
            <span class="fw-bold fs-5"><%= totalVendedores %></span>
          </div>
        </div>
      </div>
      <div class="col-6 col-lg-3">
        <div class="custom-card card border-0 h-100">
          <div class="card-body p-3">
            <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">CAJEROS</small>
            <span class="fw-bold fs-5"><%= totalCajeros %></span>
          </div>
        </div>
      </div>
    </div>

    <!-- FILTROS -->
    <div class="custom-card card border-0 mb-4 p-3">
      <div class="row g-3 align-items-end">
        <div class="col-md-8">
          <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">BUSCAR</label>
          <div class="input-group">
            <input type="text" id="usuarioBuscador" class="form-control" placeholder="Usuario o nombre del empleado...">
            <button type="button" class="btn btn-primary-custom"><i class="bi bi-search"></i></button>
          </div>
        </div>
        <div class="col-md-4">
          <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ROL</label>
          <select class="form-select">
            <option value="">Todos</option>
            <option>Administrador</option>
            <option>Vendedor</option>
            <option>Cajero</option>
          </select>
        </div>
      </div>
    </div>

    <!-- TABLA DE USUARIOS -->
    <div class="custom-card card border-0">
      <div class="card-body p-4">
        <div class="table-responsive">
          <table class="table custom-table table-hover align-middle mb-0">
            <thead>
            <tr>
              <th>USUARIO</th>
              <th>EMPLEADO ASOCIADO</th>
              <th>ROL</th>
              <th class="text-end">ACCIONES</th>
            </tr>
            </thead>
            <tbody>
            <% if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
            for (Usuario u : listaUsuarios) {
            String username = u.getNombreUsuario();
            String iniciales = (username != null && username.length() >= 2) ? username.substring(0, 2).toUpperCase() : "US";
            String nombreEmpleado = "Sin empleado asociado";

            if (u.getEmpleado() != null) {
            nombreEmpleado = u.getEmpleado().getNombre() + " " + u.getEmpleado().getApellido();
            }

            String badgeBg = "#4b5563"; // Vendedor (Gris)
            String rolName = "SIN ROL";
            if (u.getRol() != null) {
            rolName = u.getRol().name();
            if (rolName.contains("ADMIN")) badgeBg = "var(--primary-custom)";
            else if (rolName.contains("CAJERO")) badgeBg = "#eab308";
            }
            String modalId = username != null ? username.replace(".", "_").replace("@", "_") : "default";
            %>
            <tr>
              <td>
                <div class="d-flex align-items-center gap-2">
                  <span class="avatar" style="width:32px; height:32px; min-width:32px; font-size:0.8rem;"><%= iniciales %></span>
                  <span class="fw-semibold"><%= username %></span>
                </div>
              </td>
              <td><%= nombreEmpleado %></td>
              <td>
                <span class="badge" style="background-color: <%= badgeBg %>;"><%= rolName %></span>
              </td>
              <td class="text-end">
                <!-- Botón Editar llama al Modal -->
                <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Editar" data-bs-toggle="modal" data-bs-target="#editarUsuarioModal_<%= modalId %>">
                  <i class="bi bi-pencil-square fs-5"></i>
                </button>
                <!-- Botón Eliminar llama al Modal -->
                <button type="button" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar" data-bs-toggle="modal" data-bs-target="#eliminarUsuarioModal_<%= modalId %>">
                  <i class="bi bi-trash fs-5"></i>
                </button>
              </td>
            </tr>
            <%  }
            } else { %>
            <tr>
              <td colspan="4" class="text-center text-muted py-4">No hay usuarios registrados todavía. ¡Crea uno nuevo!</td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- MODAL: NUEVO USUARIO -->
    <div class="modal fade" id="nuevoUsuarioModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content custom-card border-0">
          <form action="<%= request.getContextPath() %>/svusuario" method="POST">
            <input type="hidden" name="accion" value="crear">
            <div class="modal-header border-0 pb-0">
              <h5 class="modal-title fw-bold title-font">Nuevo usuario</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body p-4">
              <div class="mb-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">EMPLEADO ASOCIADO</label>
                <select name="empleadoId" class="form-select" required>
                  <option value="" selected disabled>Selecciona un empleado...</option>
                  <% if (listaEmpleadosUsuarios != null && !listaEmpleadosUsuarios.isEmpty()) {
                  for (Empleado emp : listaEmpleadosUsuarios) { %>
                  <option value="<%= emp.getNumeroDocumento() %>"><%= emp.getNombre() %> <%= emp.getApellido() %> (Doc: <%= emp.getNumeroDocumento() %>)</option>
                  <%  }
                  } else { %>
                  <option value="" disabled>No hay empleados registrados</option>
                  <% } %>
                </select>
              </div>
              <div class="mb-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE DE USUARIO</label>
                <input type="text" name="nombreUsuario" class="form-control" placeholder="Ej: rosa.f" required>
              </div>
              <div class="mb-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ROL</label>
                <select name="rol" class="form-select" required>
                  <option value="" selected disabled>Selecciona un rol...</option>
                  <option value="ADMIN">Administrador</option>
                  <option value="VENDEDOR">Vendedor</option>
                  <option value="CAJERO">Cajero</option>
                </select>
              </div>
              <div class="mb-0">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CONTRASEÑA</label>
                <div class="input-group">
                  <input type="password" id="nuNuevaPassword" name="contrasena" class="form-control" placeholder="Mínimo 8 caracteres" required minlength="8">
                  <button type="button" class="btn btn-outline-secondary btn-toggle-pass" data-target="nuNuevaPassword" title="Mostrar/ocultar">
                    <i class="bi bi-eye"></i>
                  </button>
                </div>
              </div>
            </div>
            <div class="modal-footer border-0 pt-0">
              <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary-custom fw-bold">
                <i class="bi bi-check2-circle"></i> Crear usuario
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- MODALES DE EDICIÓN Y ELIMINACIÓN -->
    <% if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
    for (Usuario u : listaUsuarios) {
    String modalId = u.getNombreUsuario() != null ? u.getNombreUsuario().replace(".", "_").replace("@", "_") : "default";
    String rolActual = u.getRol() != null ? u.getRol().name() : "VENDEDOR";
    int docEmpleadoActual = (u.getEmpleado() != null) ? u.getEmpleado().getNumeroDocumento() : 0;
    String passwordActual = (u.getContraseña() != null) ? u.getContraseña() : "";
    %>

    <!-- MODAL: EDITAR USUARIO -->
    <div class="modal fade" id="editarUsuarioModal_<%= modalId %>" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content custom-card border-0">
          <form action="<%= request.getContextPath() %>/svusuario" method="POST">
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" name="nombreUsuarioOriginal" value="<%= u.getNombreUsuario() %>">

            <div class="modal-header border-0 pb-0">
              <div>
                <h5 class="modal-title fw-bold title-font">Editar usuario</h5>
                <small class="text-muted">Modifica los datos de: <%= u.getNombreUsuario() %></small>
              </div>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4">
              <div class="mb-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">EMPLEADO ASOCIADO</label>
                <select name="empleadoId" class="form-select" required>
                  <option value="" disabled>Selecciona un empleado...</option>
                  <% if (listaEmpleadosUsuarios != null) {
                  for (Empleado emp : listaEmpleadosUsuarios) {
                  boolean esAsociado = (emp.getNumeroDocumento() == docEmpleadoActual); %>
                  <option value="<%= emp.getNumeroDocumento() %>" <%= esAsociado ? "selected" : "" %>>
                  <%= emp.getNombre() %> <%= emp.getApellido() %> (Doc: <%= emp.getNumeroDocumento() %>)
                  </option>
                  <%  }
                  } %>
                </select>
              </div>

              <div class="mb-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE DE USUARIO</label>
                <input type="text" class="form-control" name="nombreUsuario" value="<%= u.getNombreUsuario() %>" required>
              </div>

              <div class="mb-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ROL</label>
                <select name="rol" class="form-select" required>
                  <option value="ADMIN" <%= rolActual.contains("ADMIN") ? "selected" : "" %>>Administrador</option>
                  <option value="VENDEDOR" <%= rolActual.contains("VENDEDOR") ? "selected" : "" %>>Vendedor</option>
                  <option value="CAJERO" <%= rolActual.contains("CAJERO") ? "selected" : "" %>>Cajero</option>
                </select>
              </div>

              <hr style="border-color: var(--border-color);">

              <!-- CONTRASEÑA CARGADA DINÁMICAMENTE AQUÍ -->
              <label class="form-label text-muted fw-bold mb-2" style="font-size: 0.75rem;">CONTRASEÑA</label>
              <div class="input-group">
                <input type="password" id="euPassword_<%= modalId %>" name="contrasena" class="form-control" value="<%= passwordActual %>" required minlength="8">
                <button type="button" class="btn btn-outline-secondary btn-toggle-pass" data-target="euPassword_<%= modalId %>" title="Mostrar/ocultar">
                  <i class="bi bi-eye"></i>
                </button>
              </div>
            </div>

            <div class="modal-footer border-0 pt-0">
              <button type="button" class="btn btn-outline-secondary fw-semibold me-auto" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary-custom fw-bold">
                <i class="bi bi-check2-circle"></i> Guardar cambios
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- MODAL: CONFIRMAR ELIMINACIÓN -->
    <div class="modal fade" id="eliminarUsuarioModal_<%= modalId %>" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content custom-card border-0">
          <div class="modal-body text-center p-4">
            <div class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width:60px;height:60px;background:rgba(220,53,69,.1);">
              <i class="bi bi-trash text-danger fs-4"></i>
            </div>
            <h5 class="fw-bold title-font">¿Eliminar usuario?</h5>
            <p class="text-muted mb-4">
              Estás a punto de eliminar al usuario <strong><%= u.getNombreUsuario() %></strong>.
              Esta operación es permanente y no se puede deshacer.
            </p>
            <div class="d-flex justify-content-center gap-2">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
              <form action="<%= request.getContextPath() %>/svusuario" method="POST" style="margin:0;">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="nombreUsuario" value="<%= u.getNombreUsuario() %>">
                <button type="submit" class="btn btn-danger">
                  <i class="bi bi-trash me-1"></i> Eliminar
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <%  }
    } %>
    </section>