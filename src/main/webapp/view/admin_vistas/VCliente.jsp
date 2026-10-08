<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Cliente" %>
<%
  boolean esClientes = "clientes".equals(request.getAttribute("vistaActiva"));
  List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    int totalClientes = (clientes != null) ? clientes.size() : 0;
  %>

  <section id="view-clientes" class="view-section <%= esClientes ? "active" : "" %>">

  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1">Clientes</h3>
      <p class="text-muted mb-0">Administra la base de clientes del negocio.</p>
    </div>
    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoClienteModal">
      <i class="bi bi-plus-lg"></i> Nuevo cliente
    </button>
  </div>

  <!-- KPIs RÁPIDOS -->
  <div class="row g-3 mb-4">
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL CLIENTES</small>
          <span id="kpiTotalClientes" class="fw-bold fs-5"><%= totalClientes %></span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">CLIENTES ACTIVOS</small>
          <span id="kpiClientesActivos" class="fw-bold fs-5" style="color:#22c55e;"><%= totalClientes %></span>
        </div>
      </div>
    </div>
    <!-- KPIs fijos/simulados -->
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">EMPRESAS (RUC)</small>
          <span class="fw-bold fs-5">0</span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
        <div class="card-body p-3">
          <div class="kpi-decor bg-pink-light"></div>
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">FACTURADO TOTAL</small>
          <span class="fw-bold fs-5 text-primary-custom">S/ 8,915.50</span>
        </div>
      </div>
    </div>
  </div>

  <!-- FILTROS (Se mantienen de tu HTML original) -->
  <div class="custom-card card border-0 mb-4 p-3">
    <div class="row g-3 align-items-end">
      <!-- (Contenido de filtros omitido para brevedad, consérvalo tal cual tu diseño) -->
      <div class="col-md-4">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">BUSCAR</label>
        <div class="input-group">
          <input type="text" id="clientesBuscador" class="form-control" placeholder="Nombre, DNI/RUC, teléfono...">
          <button type="button" class="btn btn-primary-custom"><i class="bi bi-search"></i></button>
        </div>
      </div>
      <div class="col-md-3">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE CLIENTE</label>
        <select class="form-select">
          <option value="">Todos</option>
          <option value="natural">Persona natural</option>
          <option value="empresa">Empresa</option>
        </select>
      </div>
      <div class="col-md-3">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SEDE</label>
        <select class="form-select"><option value="">Todas</option><option>Sede Central</option></select>
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
        <select class="form-select"><option value="">Todos</option><option>Activo</option></select>
      </div>
    </div>
  </div>

  <!-- TABLA DE CLIENTES -->
  <div class="custom-card card border-0">
    <div class="card-body p-4">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold title-font mb-0">Listado de clientes</h5>
        <button type="button" class="btn btn-outline-secondary btn-sm fw-semibold">
          <i class="bi bi-download"></i> Exportar CSV
        </button>
      </div>

      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle text-nowrap mb-0" id="tablaClientes">
          <thead>
          <tr>
            <th>CLIENTE</th>
            <th>DOC.</th>
            <th>TELÉFONO</th>
            <th>CORREO</th>
            <th>SEDE</th>
            <th>VENDEDOR ASIGNADO</th>
            <th class="text-center">N° COMPRAS</th>
            <th>TOTAL COMPRADO</th>
            <th>ÚLTIMA COMPRA</th>
            <th>ESTADO</th>
            <th class="text-end">ACCIONES</th>
          </tr>
          </thead>
          <tbody id="clientesBody">
          <% if(clientes != null) {
          int i = 0;
          for(Cliente c : clientes) {
          i++;
          String nom = (c.getNombre() != null) ? c.getNombre() : "";
          String ape = (c.getApellido() != null) ? c.getApellido() : "";
          String nombreCompleto = nom + " " + ape;

          // Generar iniciales (1 o 2 letras)
          String iniciales = (!nom.isEmpty() ? nom.substring(0,1).toUpperCase() : "") +
          (!ape.isEmpty() ? ape.substring(0,1).toUpperCase() : "");
          %>
          <tr>
            <td>
              <div class="d-flex align-items-center gap-2">
                <span class="avatar" style="width:32px; height:32px; min-width:32px; font-size:0.8rem;"><%= iniciales %></span>
                <span class="fw-semibold"><%= nombreCompleto %></span>
              </div>
            </td>
            <td><%= c.getTipoDocumento() %> <%= c.getNumeroDocumento() %></td>
            <td><%= c.getTelefono() %></td>
            <td><%= c.getEmail() %></td>
            <td>Sede Central</td> <!-- Simulado, no en modelo -->
            <td>Sin asignar</td> <!-- Simulado, no en modelo -->
            <td class="text-center fw-bold">0</td>
            <td class="fw-bold text-primary-custom">S/ 0.00</td>
            <td>--/--/----</td>
            <td><span class="badge" style="background-color:#22c55e;">Activo</span></td>
            <td class="text-end">
              <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Ver detalle" data-bs-toggle="modal" data-bs-target="#clienteModal<%= i %>">
                <i class="bi bi-eye fs-5"></i>
              </button>
              <button type="button" class="btn btn-link text-muted p-0" title="Editar">
                <i class="bi bi-pencil fs-5"></i>
              </button>
            </td>
          </tr>
          <%  }
          } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVO CLIENTE (Envuelto en form) -->
  <div class="modal fade" id="nuevoClienteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <form action="<%= request.getContextPath() %>/svcliente" method="POST">
          <input type="hidden" name="accion" value="crear">

          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold title-font">Nuevo cliente</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE CLIENTE</label>
                <select name="tipoCliente" class="form-select">
                  <option value="natural">Persona natural</option>
                  <option value="empresa">Empresa</option>
                </select>
              </div>
              <div class="col-md-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE DOCUMENTO</label>
                <select name="tipoDocumento" class="form-select">
                  <option value="DNI">DNI</option>
                  <option value="RUC">RUC</option>
                  <option value="CE">Carné de extranjería</option>
                </select>
              </div>
              <div class="col-md-5">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">N° DE DOCUMENTO</label>
                <input type="number" name="numeroDocumento" class="form-control" placeholder="Ej: 45782301" required>
              </div>
              <div class="col-md-12">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRES COMPLETOS / RAZÓN SOCIAL</label>
                <input type="text" name="nombre" class="form-control" placeholder="Ej: Rosa Fernández / Importadora Vega SAC" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
                <input type="number" name="telefono" class="form-control" placeholder="987654321" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CORREO</label>
                <input type="email" name="correo" class="form-control" placeholder="cliente@correo.com" required>
              </div>
              <div class="col-md-12">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
                <input type="text" name="direccion" class="form-control" placeholder="Av. Ejemplo 123, distrito">
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SEDE</label>
                <select name="sede" class="form-select">
                  <option>Sede Central</option>
                  <option>Miraflores</option>
                  <option>San Isidro</option>
                </select>
              </div>
            </div>
          </div>

          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">
              <i class="bi bi-check2-circle"></i> Guardar cliente
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DE DETALLE DINÁMICOS -->
  <% if(clientes != null) {
  int j = 0;
  for(Cliente c : clientes) {
  j++;
  String nombreCompleto = c.getNombre() + " " + (c.getApellido()!=null?c.getApellido():"");
  String iniciales = (!c.getNombre().isEmpty() ? c.getNombre().substring(0,1).toUpperCase() : "") +
  (c.getApellido() != null && !c.getApellido().isEmpty() ? c.getApellido().substring(0,1).toUpperCase() : "");
  %>
  <div class="modal fade" id="clienteModal<%= j %>" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <div class="modal-header border-0 pb-0">
          <h5 class="modal-title fw-bold title-font">Detalle del cliente</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>
        <div class="modal-body p-4">
          <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
            <div class="d-flex align-items-center gap-3">
              <span class="avatar" style="width:56px; height:56px; min-width:56px; font-size:1.3rem;"><%= iniciales %></span>
              <div>
                <h4 class="fw-bold title-font mb-0"><%= nombreCompleto %></h4>
                <small class="text-muted">Cliente registrado recientemente</small>
              </div>
            </div>
            <span class="badge" style="background-color:#22c55e;">Activo</span>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-3">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;"><%= c.getTipoDocumento() %></small>
              <span class="fw-semibold"><%= c.getNumeroDocumento() %></span>
            </div>
            <div class="col-md-3">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">TELÉFONO</small>
              <span class="fw-semibold"><%= c.getTelefono() %></span>
            </div>
            <div class="col-md-3">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">CORREO</small>
              <span class="fw-semibold"><%= c.getEmail() %></span>
            </div>
          </div>

          <div class="row g-3 mb-4">
            <div class="col-md-6">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">DIRECCIÓN</small>
              <span class="fw-semibold"><%= c.getDireccion() %></span>
            </div>
            <div class="col-md-3">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">SEDE HABITUAL</small>
              <span class="fw-semibold">Sede Central</span>
            </div>
            <div class="col-md-3">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">TIPO</small>
              <span class="fw-semibold"><%= "empresa".equals(c.getTipoCliente()) ? "Empresa" : "Persona natural" %></span>
            </div>
          </div>

          <div class="row g-3 mb-4">
            <div class="col-md-4">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">TOTAL COMPRADO</small>
              <span class="fw-bold fs-5 text-primary-custom">S/ 0.00</span>
            </div>
            <div class="col-md-4">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">N° DE COMPRAS</small>
              <span class="fw-bold fs-5">0</span>
            </div>
            <div class="col-md-4">
              <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">TICKET PROMEDIO</small>
              <span class="fw-bold fs-5">S/ 0.00</span>
            </div>
          </div>
        </div>
        <div class="modal-footer border-0 pt-0">
          <button type="button" class="btn btn-outline-danger fw-semibold me-auto" onclick="confirm('¿Desactivar cliente?')">
            <i class="bi bi-slash-circle"></i> Desactivar cliente
          </button>
          <button type="button" class="btn btn-primary-custom fw-bold" data-bs-dismiss="modal">Cerrar</button>
        </div>
      </div>
    </div>
  </div>
  <%      }
  } %>
  </section>