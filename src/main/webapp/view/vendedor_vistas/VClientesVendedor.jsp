<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Cliente" %>

<%
boolean esClientes = "clientes".equals(request.getAttribute("vistaActiva"));
List<Cliente> listaClientes = (List<Cliente>) request.getAttribute("clientes");
  %>

  <section id="view-clientes_view" class="view-section <%= esClientes ? "active" : "" %>">

  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">Clientes</h3>
      <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">Consulta el historial y los datos de contacto de tus clientes.</p>
    </div>

    <!-- Botón Nuevo Cliente -->
    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoClienteModal">
      <i class="bi bi-plus-lg"></i> Nuevo cliente
    </button>
  </div>

  <!-- BUSCADOR -->
  <div class="custom-card card border-0 mb-4 p-3">
    <div class="input-group" style="max-width: 400px;">
      <input type="text" id="clientesBuscador" class="form-control" placeholder="Buscar por nombre, DNI/RUC o teléfono...">
      <button type="button" class="btn btn-primary-custom">
        <i class="bi bi-search"></i>
      </button>
    </div>
  </div>

  <!-- TABLA DE CLIENTES -->
  <div class="custom-card card border-0">
    <div class="card-body p-4">
      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle text-nowrap mb-0">
          <thead>
          <tr>
            <th>CLIENTE</th>
            <th>DOC. IDENTIDAD</th>
            <th>TELÉFONO</th>
            <th>TIPO</th>
            <th class="text-center">N° COMPRAS</th>
            <th>TOTAL COMPRADO</th>
            <th class="text-end">ACCIÓN</th>
          </tr>
          </thead>
          <tbody>
          <%
          if (listaClientes != null && !listaClientes.isEmpty()) {
          for (Cliente c : listaClientes) {

          String nombre = c.getNombre() != null ? c.getNombre() : "";
          String apellido = c.getApellido() != null ? c.getApellido() : "";
          String nombreCompleto = (nombre + " " + apellido).trim();

          String iniciales = "CL";
          if (!nombre.isEmpty()) {
          iniciales = String.valueOf(nombre.charAt(0)).toUpperCase();
          if (!apellido.isEmpty()) {
          iniciales += String.valueOf(apellido.charAt(0)).toUpperCase();
          } else if (nombre.length() > 1) {
          iniciales += String.valueOf(nombre.charAt(1)).toUpperCase();
          }
          }

          int modalId = c.getNumeroDocumento();
          %>
          <tr>
            <td>
              <div class="d-flex align-items-center gap-2">
                <span class="avatar" style="width:32px; height:32px; min-width:32px; font-size:0.8rem;"><%= iniciales %></span>
                <span class="fw-semibold"><%= nombreCompleto %></span>
              </div>
            </td>
            <td><%= c.getNumeroDocumento() %> <span class="badge bg-secondary ms-1" style="font-size:0.6rem;"><%= c.getTipoDocumento() %></span></td>
            <td><%= c.getTelefono() %></td>
            <td>
              <span class="badge bg-light text-dark border"><%= c.getTipoCliente() != null ? c.getTipoCliente().toUpperCase() : "NATURAL" %></span>
            </td>
            <!-- Mocks de Compras -->
            <td class="text-center fw-bold">0</td>
            <td class="fw-bold">S/ 0.00</td>
            <td class="text-end">
              <button type="button" class="btn btn-link text-primary-custom p-0" title="Ver detalle" data-bs-toggle="modal" data-bs-target="#clienteModal_<%= modalId %>">
                <i class="bi bi-eye fs-5"></i>
              </button>
            </td>
          </tr>
          <%    }
          } else { %>
          <tr>
            <td colspan="7" class="text-center py-4" style="color: var(--text-color); opacity: 0.7;">No hay clientes registrados aún.</td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVO CLIENTE -->
  <div class="modal fade" id="nuevoClienteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <form action="<%= request.getContextPath() %>/svcliente" method="POST">
          <input type="hidden" name="accion" value="crear">

          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold title-font">Registrar Cliente</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">TIPO DE CLIENTE</label>
                <select name="tipoCliente" class="form-select" required>
                  <option value="natural" selected>Natural</option>
                  <option value="empresa">Empresa</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">TIPO DE DOCUMENTO</label>
                <select name="tipoDocumento" class="form-select" required>
                  <option value="DNI" selected>DNI</option>
                  <option value="RUC">RUC</option>
                  <option value="CE">Carné de extranjería</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">NÚMERO DE DOCUMENTO</label>
                <input type="number" name="numeroDocumento" class="form-control" required>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">NOMBRE COMPLETO / RAZÓN SOCIAL</label>
                <input type="text" name="nombre" class="form-control" placeholder="Ej: Edu Caceres" required>
              </div>
              <div class="col-md-4">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">TELÉFONO</label>
                <input type="number" name="telefono" class="form-control" required>
              </div>
              <div class="col-md-8">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">CORREO ELECTRÓNICO</label>
                <input type="email" name="correo" class="form-control" required>
              </div>
              <div class="col-md-12">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">DIRECCIÓN</label>
                <input type="text" name="direccion" class="form-control" required>
              </div>
            </div>
          </div>

          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-bold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">Guardar Cliente</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DE DETALLE -->
  <%
  if (listaClientes != null && !listaClientes.isEmpty()) {
  for (Cliente c : listaClientes) {
  String nombre = c.getNombre() != null ? c.getNombre() : "";
  String apellido = c.getApellido() != null ? c.getApellido() : "";
  String nombreCompleto = (nombre + " " + apellido).trim();

  String iniciales = "CL";
  if (!nombre.isEmpty()) {
  iniciales = String.valueOf(nombre.charAt(0)).toUpperCase();
  if (!apellido.isEmpty()) {
  iniciales += String.valueOf(apellido.charAt(0)).toUpperCase();
  } else if (nombre.length() > 1) {
  iniciales += String.valueOf(nombre.charAt(1)).toUpperCase();
  }
  }
  %>
  <div class="modal fade" id="clienteModal_<%= c.getNumeroDocumento() %>" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">

        <div class="modal-header border-0 pb-0">
          <h5 class="modal-title fw-bold title-font">Detalle del cliente</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>

        <div class="modal-body p-4">
          <div class="d-flex align-items-center gap-3 mb-4">
            <span class="avatar" style="width:56px; height:56px; min-width:56px; font-size:1.3rem;"><%= iniciales %></span>
            <div>
              <h4 class="fw-bold title-font mb-0"><%= nombreCompleto %></h4>
              <small style="color: var(--text-color); opacity: 0.7;">Tipo: <%= c.getTipoCliente() != null ? c.getTipoCliente().toUpperCase() : "NATURAL" %></small>
            </div>
          </div>

          <div class="row g-3 mb-4">
            <div class="col-md-3">
              <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;"><%= c.getTipoDocumento() != null ? c.getTipoDocumento().name() : "DOC" %></small>
              <span class="fw-semibold"><%= c.getNumeroDocumento() %></span>
            </div>
            <div class="col-md-3">
              <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">TELÉFONO</small>
              <span class="fw-semibold"><%= c.getTelefono() %></span>
            </div>
            <div class="col-md-6">
              <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">CORREO</small>
              <span class="fw-semibold"><%= c.getEmail() != null ? c.getEmail() : "No registrado" %></span>
            </div>
            <div class="col-md-12">
              <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">DIRECCIÓN</small>
              <span class="fw-semibold"><%= c.getDireccion() != null ? c.getDireccion() : "-" %></span>
            </div>
          </div>

          <div class="row g-3 mb-4">
            <div class="col-md-4">
              <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">TOTAL COMPRADO</small>
              <span class="fw-bold fs-5 text-primary-custom">S/ 0.00</span>
            </div>
            <div class="col-md-4">
              <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">N° DE COMPRAS</small>
              <span class="fw-bold fs-5">0</span>
            </div>
            <div class="col-md-4">
              <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">TICKET PROMEDIO</small>
              <span class="fw-bold fs-5">S/ 0.00</span>
            </div>
          </div>

          <hr style="border-color: var(--border-color);">

          <h6 class="fw-bold mb-3">Historial de compras (Demostrativo)</h6>
          <div class="table-responsive">
            <table class="table custom-table align-middle mb-0">
              <thead>
              <tr>
                <th>FECHA</th>
                <th>COMPROBANTE</th>
                <th>TOTAL</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <td colspan="3" class="text-center py-3" style="color: var(--text-color); opacity: 0.7;">No hay compras registradas para este cliente.</td>
              </tr>
              </tbody>
            </table>
          </div>

        </div>

        <div class="modal-footer border-0 pt-0">
          <button type="button" class="btn btn-primary-custom fw-bold" data-bs-dismiss="modal">
            Cerrar
          </button>
        </div>

      </div>
    </div>
  </div>
  <%
  }
  }
  %>

  </section>