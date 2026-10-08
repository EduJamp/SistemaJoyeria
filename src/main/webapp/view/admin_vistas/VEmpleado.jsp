<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Empleado" %>
<%
boolean esEmpleados = "empleados".equals(request.getAttribute("vistaActiva"));
List<Empleado> listaEmpleados = (List<Empleado>) request.getAttribute("empleados");

  // Cálculo dinámico de KPIs
  int totalEmpleados = 0;
  int activos = 0;
  int desactivados = 0;

  if (listaEmpleados != null) {
  totalEmpleados = listaEmpleados.size();
  for (Empleado emp : listaEmpleados) {
  // Si no tiene fecha de fin, asumimos que sigue activo en la empresa
  if (emp.getFechaFin() == null) {
  activos++;
  } else {
  desactivados++;
  }
  }
  }
  %>

  <section id="view-empleados" class="view-section <%= esEmpleados ? "active" : "" %>">
  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1">Empleados</h3>
      <p class="text-muted mb-0">Administración de colaboradores</p>
    </div>
    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoEmpleadoModal">
      <i class="bi bi-plus-lg"></i> Nuevo empleado
    </button>
  </div>

  <!-- KPIs RÁPIDOS DINÁMICOS -->
  <div class="row g-3 mb-4">
    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL EMPLEADOS</small>
          <span class="fw-bold fs-5"><%= totalEmpleados %></span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">ACTIVOS</small>
          <span class="fw-bold fs-5" style="color:#22c55e;"><%= activos %></span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">DESACTIVADOS</small>
          <span class="fw-bold fs-5" style="color:#eab308;"><%= desactivados %></span>
        </div>
      </div>
    </div>
  </div>

  <!-- BUSCADOR -->
  <div class="custom-card card border-0 mb-4 p-3">
    <div class="input-group" style="max-width: 400px;">
      <input type="text" id="empleadoBuscador" class="form-control" placeholder="Buscar empleado por nombre o DNI...">
      <button type="button" class="btn btn-primary-custom">
        <i class="bi bi-search"></i>
      </button>
    </div>
  </div>

  <!-- TABLA DE EMPLEADOS -->
  <div class="custom-card card border-0">
    <div class="card-body p-4">
      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle mb-0 text-nowrap">
          <thead>
          <tr>
            <th>NOMBRE</th>
            <th>APELLIDO</th>
            <th>DOC.</th>
            <th>NUMERO</th>
            <th>TELÉFONO</th>
            <th>DIRECCIÓN</th>
            <th>F. NACIMIENTO</th>
            <th>SALARIO</th>
            <th>INGRESO</th>
            <th>SALIDA</th>
            <th class="text-end">ACCIONES</th>
          </tr>
          </thead>
          <tbody>
          <% if (listaEmpleados != null && !listaEmpleados.isEmpty()) {
          for (Empleado emp : listaEmpleados) { %>
          <tr>
            <td class="fw-semibold"><%= emp.getNombre() %></td>
            <td><%= emp.getApellido() %></td>
            <td><span class="badge bg-secondary"><%= emp.getTipoDocumento() %></span></td>
            <td class="fw-bold text-primary-custom"><%= emp.getNumeroDocumento() %></td>
            <td><%= emp.getTelefono() %></td>
            <td class="text-truncate" style="max-width: 150px;" title="<%= emp.getDireccion() != null ? emp.getDireccion() : "" %>">
            <%= emp.getDireccion() != null ? emp.getDireccion() : "-" %>
            </td>
            <td><%= emp.getFechaNacimiento() != null ? emp.getFechaNacimiento() : "-" %></td>
            <td class="fw-semibold">S/ <%= emp.getSalario() %></td>
            <td><%= emp.getFechaInicio() != null ? emp.getFechaInicio() : "-" %></td>
            <td><%= emp.getFechaFin() != null ? emp.getFechaFin() : "-" %></td>
            <td class="text-end">
              <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Editar" data-bs-toggle="modal" data-bs-target="#editarEmpleadoModal_<%= emp.getNumeroDocumento() %>">
                <i class="bi bi-pencil-square fs-5"></i>
              </button>
              <button type="button" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar" data-bs-toggle="modal" data-bs-target="#eliminarEmpleadoModal_<%= emp.getNumeroDocumento() %>">
                <i class="bi bi-trash fs-5"></i>
              </button>
            </td>
          </tr>
          <%  }
          } else { %>
          <tr>
            <td colspan="11" class="text-center text-muted py-4">No hay empleados registrados todavía. ¡Agrega uno nuevo!</td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVO EMPLEADO -->
  <div class="modal fade" id="nuevoEmpleadoModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <form action="<%= request.getContextPath() %>/svempleado" method="POST">
          <input type="hidden" name="accion" value="crear">
          <div class="modal-header border-0 pb-0">
            <div>
              <h5 class="modal-title fw-bold title-font">Nuevo empleado</h5>
              <small class="text-muted">Ingresa los datos del nuevo colaborador</small>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                <input type="text" name="nombre" class="form-control" placeholder="Ej: Edu Jampier" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">APELLIDO</label>
                <input type="text" name="apellido" class="form-control" placeholder="Ej: Caceres Ruiz" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE DOCUMENTO</label>
                <select name="tipoDocumento" class="form-select" required>
                  <option value="" selected disabled>Selecciona tipo...</option>
                  <option value="DNI">DNI</option>
                  <option value="RUC">RUC</option>
                  <option value="PASAPORTE">Pasaporte</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NÚMERO DE DOCUMENTO</label>
                <input type="number" name="numeroDocumento" class="form-control" placeholder="Ej: 45782301" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
                <input type="number" name="telefono" class="form-control" placeholder="Ej: 987654321" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE NACIMIENTO</label>
                <input type="date" name="fechaNacimiento" class="form-control" required>
              </div>
              <div class="col-md-12">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
                <input type="text" name="direccion" class="form-control" placeholder="Av. Los Incas 123, Ica" required>
              </div>
              <hr class="my-2" style="border-color: var(--border-color);">
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SALARIO (S/)</label>
                <input type="number" step="1" name="salario" class="form-control" placeholder="1500" required>
              </div>
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE INGRESO</label>
                <input type="date" name="fechaInicio" class="form-control" required>
              </div>
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE SALIDA (OPCIONAL)</label>
                <input type="date" name="fechaFin" class="form-control">
              </div>
            </div>
          </div>
          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">
              <i class="bi bi-check2-circle"></i> Guardar empleado
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DE EDICIÓN Y ELIMINACIÓN -->
  <% if (listaEmpleados != null && !listaEmpleados.isEmpty()) {
  for (Empleado emp : listaEmpleados) {
  String tipoDocActual = emp.getTipoDocumento() != null ? emp.getTipoDocumento().name() : "DNI";
  %>

  <!-- MODAL: EDITAR EMPLEADO -->
  <div class="modal fade" id="editarEmpleadoModal_<%= emp.getNumeroDocumento() %>" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <form action="<%= request.getContextPath() %>/svempleado" method="POST">
          <input type="hidden" name="accion" value="actualizar">
          <!-- LLAVE PRIMARIA PARA EL UPDATE OCULTA (Ya que el input visible está deshabilitado por seguridad) -->
          <input type="hidden" name="numeroDocumento" value="<%= emp.getNumeroDocumento() %>">

          <div class="modal-header border-0 pb-0">
            <div>
              <h5 class="modal-title fw-bold title-font">Editar empleado</h5>
              <small class="text-muted">Modifica la información de: <%= emp.getNombre() %></small>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                <input type="text" name="nombre" class="form-control" value="<%= emp.getNombre() %>" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">APELLIDO</label>
                <input type="text" name="apellido" class="form-control" value="<%= emp.getApellido() %>" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE DOCUMENTO</label>
                <select name="tipoDocumento" class="form-select" required>
                  <option value="DNI" <%= tipoDocActual.equalsIgnoreCase("DNI") ? "selected" : "" %>>DNI</option>
                  <option value="RUC" <%= tipoDocActual.equalsIgnoreCase("RUC") ? "selected" : "" %>>RUC</option>
                  <option value="PASAPORTE" <%= tipoDocActual.equalsIgnoreCase("PASAPORTE") ? "selected" : "" %>>Pasaporte</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NÚMERO DE DOCUMENTO</label>
                <input type="text" class="form-control" value="<%= emp.getNumeroDocumento() %>" disabled>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
                <input type="number" name="telefono" class="form-control" value="<%= emp.getTelefono() %>" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE NACIMIENTO</label>
                <input type="date" name="fechaNacimiento" class="form-control" value="<%= emp.getFechaNacimiento() != null ? emp.getFechaNacimiento() : "" %>">
              </div>
              <div class="col-md-12">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
                <input type="text" name="direccion" class="form-control" value="<%= emp.getDireccion() != null ? emp.getDireccion() : "" %>" required>
              </div>
              <hr class="my-2" style="border-color: var(--border-color);">
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SALARIO (S/)</label>
                <input type="number" step="1" name="salario" class="form-control" value="<%= emp.getSalario() %>" required>
              </div>
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE INGRESO</label>
                <input type="date" name="fechaInicio" class="form-control" value="<%= emp.getFechaInicio() != null ? emp.getFechaInicio() : "" %>">
              </div>
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE SALIDA (OPCIONAL)</label>
                <input type="date" name="fechaFin" class="form-control" value="<%= emp.getFechaFin() != null ? emp.getFechaFin() : "" %>">
              </div>
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
  <div class="modal fade" id="eliminarEmpleadoModal_<%= emp.getNumeroDocumento() %>" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content custom-card border-0">
        <div class="modal-body text-center p-4">
          <div class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width:60px;height:60px;background:rgba(220,53,69,.1);">
            <i class="bi bi-trash text-danger fs-4"></i>
          </div>
          <h5 class="fw-bold title-font">¿Eliminar empleado?</h5>
          <p class="text-muted mb-4">
            Estás a punto de eliminar a <strong><%= emp.getNombre() %> <%= emp.getApellido() %></strong> (Doc: <%= emp.getNumeroDocumento() %>).
            Esta operación es permanente.
          </p>
          <div class="d-flex justify-content-center gap-2">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
            <form action="<%= request.getContextPath() %>/svempleado" method="POST" style="margin:0;">
              <input type="hidden" name="accion" value="eliminar">
              <input type="hidden" name="numeroDocumento" value="<%= emp.getNumeroDocumento() %>">
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