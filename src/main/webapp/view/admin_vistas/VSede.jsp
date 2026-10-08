<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Sede" %>

<%
String vistaActivaSede = (String) request.getAttribute("vistaActiva");
boolean esSedes = "sedes".equals(vistaActivaSede);
%>

<section id="view-sedes" class="view-section <%= esSedes ? "active" : "" %>">

<div class="mb-4">
  <h3 class="fw-bold title-font mb-1">
    Sedes
  </h3>
  <p class="text-muted">
    Administración de las sedes de Liamy Import.
  </p>
</div>

<div class="custom-card card border-0">
  <div class="card-body p-4">

    <!-- CABECERA -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
      <div class="input-group search-wrapper" style="max-width: 400px;">
        <input type="text" class="form-control" placeholder="Buscar sedes...">
        <button type="button" class="btn btn-primary-custom px-3">
          <i class="bi bi-search"></i>
        </button>
      </div>

      <button type="button" class="btn btn-primary-custom fw-semibold" data-bs-toggle="modal" data-bs-target="#nuevaSedeModal">
        <i class="bi bi-plus-lg me-1"></i>
        Nuevo
      </button>
    </div>

    <!-- TABLA -->
    <div class="table-responsive">
      <table class="table custom-table table-hover align-middle text-nowrap mb-0">
        <thead>
        <tr>
          <th>Principal</th>
          <th>Nombre <i class="bi bi-arrow-down-up ms-1 text-muted"></i></th>
          <th>Dirección <i class="bi bi-arrow-down-up ms-1 text-muted"></i></th>
          <th>Ciudad <i class="bi bi-arrow-down-up ms-1 text-muted"></i></th>
          <th>Teléfono <i class="bi bi-arrow-down-up ms-1 text-muted"></i></th>
          <th>Estado</th>
          <th class="text-end">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
        List<Sede> listaSedes = (List<Sede>) request.getAttribute("sedesList");
          if (listaSedes != null && !listaSedes.isEmpty()) {
          for (Sede s : listaSedes) {
          String estadoStr = s.getEstado() != null ? String.valueOf(s.getEstado()) : "";
          String colorBadge = "Activo".equalsIgnoreCase(estadoStr) ? "#22c55e" : "#ef4444";
          %>
          <tr>
            <td>
              <% if (s.isEsPrincipal()) { %>
              <span class="badge bg-pink-light text-primary-custom">Sí</span>
              <% } else { %>
              <span class="text-muted">No</span>
              <% } %>
            </td>
            <td class="fw-semibold"><%= s.getNombre() %></td>
            <td class="text-muted"><%= s.getDireccion() %></td>
            <td><%= s.getCiudad() %></td>
            <td><%= s.getTelefono() %></td>
            <td>
                            <span class="badge" style="background-color: <%= colorBadge %>;">
                                <%= s.getEstado() %>
                            </span>
            </td>
            <td class="text-end">
              <!-- Botón Editar abre modal dinámico -->
              <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Editar" data-bs-toggle="modal" data-bs-target="#modalEditarSede_<%= s.getId() %>">
                <i class="bi bi-pencil-square fs-5"></i>
              </button>

              <!-- Formulario Eliminar -->
              <form action="svsede" method="POST" style="display: inline; margin: 0; padding: 0;">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="id" value="<%= s.getId() %>">
                <button type="submit" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar" onclick="return confirm('¿Deseas eliminar esta sede?');">
                  <i class="bi bi-trash fs-5"></i>
                </button>
              </form>
            </td>
          </tr>
          <%
          }
          } else {
          %>
          <tr>
            <td colspan="7" class="text-center py-5">
              <div class="d-flex flex-column align-items-center justify-content-center text-muted">
                <i class="bi bi-inbox fs-1 mb-2"></i>
                <h6 class="fw-semibold mb-0">No hay registros disponibles</h6>
                <small>No se encontraron datos para mostrar en esta tabla.</small>
              </div>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>

  </div>
</div>

<!-- MODAL: NUEVA SEDE -->
<div class="modal fade" id="nuevaSedeModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content custom-card border-0">
      <form action="<%= request.getContextPath() %>/svsede" method="POST">
        <input type="hidden" name="accion" value="crear">
        <div class="modal-header border-0 pb-0">
          <h5 class="modal-title fw-bold title-font">Nueva Sede</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>

        <div class="modal-body p-4">
          <div class="mb-3">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
            <input type="text" name="nombre" class="form-control" placeholder="Ej: Sede Norte" required>
          </div>
          <div class="mb-3">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
            <input type="text" name="direccion" class="form-control" placeholder="Ej: Av. Los Pinos 123" required>
          </div>
          <div class="mb-3">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CIUDAD</label>
            <input type="text" name="ciudad" class="form-control" placeholder="Ej: Chimbote" required>
          </div>
          <div class="mb-3">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
            <input type="text" name="telefono" class="form-control" placeholder="Ej: 987654321">
          </div>
          <div class="mb-3 form-check">
            <input type="checkbox" name="esPrincipal" value="true" class="form-check-input" id="checkPrincipal">
            <label class="form-check-label fw-semibold" for="checkPrincipal" style="font-size: 0.85rem;">¿Es sede principal?</label>
          </div>
          <div class="mb-0">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
            <select name="estado" class="form-select" required>
              <option value="Activo">Activo</option>
              <option value="Inactivo">Inactivo</option>
            </select>
          </div>
        </div>

        <div class="modal-footer border-0 pt-0">
          <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-primary-custom fw-bold">
            <i class="bi bi-check2-circle"></i> Guardar sede
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODALES DE EDICIÓN DINÁMICOS -->
<%
if (listaSedes != null && !listaSedes.isEmpty()) {
for (Sede s : listaSedes) {
String estadoStrEdit = s.getEstado() != null ? String.valueOf(s.getEstado()) : "";
%>
<div class="modal fade" id="modalEditarSede_<%= s.getId() %>" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content custom-card border-0">
      <form action="svsede" method="POST">
        <input type="hidden" name="accion" value="actualizar">
        <input type="hidden" name="id" value="<%= s.getId() %>">
        <div class="modal-header border-0 pb-0">
          <h5 class="modal-title fw-bold title-font">Editar Sede</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>

        <div class="modal-body p-4">
          <div class="mb-3">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
            <input type="text" name="nombre" class="form-control" value="<%= s.getNombre() %>" required>
          </div>
          <div class="mb-3">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
            <input type="text" name="direccion" class="form-control" value="<%= s.getDireccion() %>" required>
          </div>
          <div class="mb-3">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CIUDAD</label>
            <input type="text" name="ciudad" class="form-control" value="<%= s.getCiudad() %>" required>
          </div>
          <div class="mb-3">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
            <input type="text" name="telefono" class="form-control" value="<%= s.getTelefono() != null ? s.getTelefono() : "" %>">
          </div>
          <div class="mb-3 form-check">
            <input type="checkbox" name="esPrincipal" value="true" class="form-check-input" id="checkPrincipal_<%= s.getId() %>" <%= s.isEsPrincipal() ? "checked" : "" %>>
            <label class="form-check-label fw-semibold" for="checkPrincipal_<%= s.getId() %>" style="font-size: 0.85rem;">¿Es sede principal?</label>
          </div>
          <div class="mb-0">
            <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
            <select name="estado" class="form-select" required>
              <option value="Activo" <%= "Activo".equalsIgnoreCase(estadoStrEdit) ? "selected" : "" %>>Activo</option>
              <option value="Inactivo" <%= "Inactivo".equalsIgnoreCase(estadoStrEdit) ? "selected" : "" %>>Inactivo</option>
            </select>
          </div>
        </div>

        <div class="modal-footer border-0 pt-0">
          <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-primary-custom fw-bold">
            <i class="bi bi-check2-circle"></i> Guardar cambios
          </button>
        </div>
      </form>
    </div>
  </div>
</div>
<%
}
}
%>

</section>