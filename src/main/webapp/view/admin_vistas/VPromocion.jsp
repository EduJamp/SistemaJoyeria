<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Promocion" %>
<%
  boolean esPromocion = "promociones".equals(request.getAttribute("vistaActiva"));
  List<Promocion> promociones = (List<Promocion>) request.getAttribute("promociones");
  %>

  <section id="view-promociones" class="view-section <%= esPromocion ? "active" : "" %>">

  <!-- ENCABEZADO -->
  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-3">
    <div>
      <div class="d-flex align-items-center gap-2 mb-1">
        <h3 class="fw-bold title-font mb-0">Gestión de Promociones</h3>
        <span class="badge rounded-pill px-3 py-2" style="background: rgba(34, 197, 94, 0.12); color: var(--primary-custom);">
                    Administrador
                </span>
      </div>
      <p class="text-muted mb-0">Administra las promociones, descuentos y beneficios disponibles para los clientes.</p>
    </div>
    <button type="button" class="btn btn-primary-custom d-flex align-items-center gap-2 px-3 py-2" data-bs-toggle="modal" data-bs-target="#modalNuevaPromocion">
      <i class="bi bi-plus-lg"></i>
      <span>Nueva promoción</span>
    </button>
  </div>

  <!-- RESUMEN -->
  <div class="row g-3 mb-4">
    <!-- Puedes hacer estos números dinámicos en el servlet, aquí se mantienen fieles a tu diseño -->
    <div class="col-12 col-sm-6 col-xl-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-4">
          <div class="d-flex justify-content-between align-items-start">
            <div>
              <p class="text-muted small mb-1">Total promociones</p>
              <h3 class="fw-bold title-font mb-0"><%= promociones != null ? promociones.size() : 0 %></h3>
            </div>
            <div class="rounded-3 d-flex align-items-center justify-content-center" style="width:44px;height:44px;background:rgba(34,197,94,.12);">
              <i class="bi bi-megaphone text-primary-custom fs-5"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="col-12 col-sm-6 col-xl-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-4">
          <div class="d-flex justify-content-between align-items-start">
            <div>
              <p class="text-muted small mb-1">Promociones activas</p>
              <h3 class="fw-bold title-font mb-0">8</h3>
            </div>
            <div class="rounded-3 d-flex align-items-center justify-content-center" style="width:44px;height:44px;background:rgba(34,197,94,.12);">
              <i class="bi bi-check-circle text-success fs-5"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Tarjetas de "Por vencer" e "Inactivas" omitidas para no saturar, se mantienen igual en tu código real -->
  </div>

  <!-- LISTADO DE PROMOCIONES -->
  <div class="custom-card card border-0">
    <div class="card-body p-0">
      <div class="p-4 border-bottom">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
          <div>
            <h5 class="fw-bold title-font mb-1">Promociones registradas</h5>
            <p class="text-muted small mb-0">Gestiona las promociones disponibles en el sistema.</p>
          </div>
          <span class="text-muted small">Mostrando <%= promociones != null ? promociones.size() : 0 %> promociones</span>
        </div>
      </div>

      <!-- TARJETAS DINÁMICAS -->
      <div class="p-4">
        <div class="row g-4">
          <% if(promociones != null) {
          for(Promocion p : promociones) {
          // Lógica para color de estado
          String badgeClase = "bg-success";
          if(p.getEstado().equals("Por vencer")) badgeClase = "bg-warning text-dark";
          else if(p.getEstado().equals("Inactiva")) badgeClase = "bg-secondary";
          else if(p.getEstado().equals("Programada")) badgeClase = "bg-info text-dark";
          %>
          <div class="col-12 col-md-6 col-xl-4">
            <div class="card border h-100 overflow-hidden">
              <div class="position-relative p-4" style="background:<%= p.getColorFondo() %>;min-height:145px;">
                <div class="d-flex justify-content-between align-items-start">
                  <span class="badge bg-white text-dark rounded-pill px-3 py-2"><%= p.getTipo() %></span>
                  <span class="badge <%= badgeClase %> rounded-pill"><%= p.getEstado() %></span>
                </div>
                <div class="position-absolute bottom-0 start-0 p-4 text-white">
                  <h5 class="fw-bold title-font text-white mb-1"><%= p.getNombre() %></h5>
                  <small class="text-white opacity-75"><%= p.getSede() %></small>
                </div>
              </div>
              <div class="card-body p-4">
                <p class="text-muted small mb-4"><%= p.getDescripcion() %></p>
                <div class="small text-muted mb-2">
                  <i class="bi bi-calendar3 me-2"></i> <%= p.getFechaInicio() %> - <%= p.getFechaFin() %>
                </div>
                <div class="small text-muted mb-3">
                  <i class="bi bi-shop me-2"></i> <%= p.getSede() %>
                </div>
                <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                  <button type="button" class="btn btn-sm btn-outline-secondary" title="Editar"><i class="bi bi-pencil"></i></button>

                  <!-- Formulario para eliminar -->
                  <form action="<%= request.getContextPath() %>/svpromocion" method="POST" class="d-inline">
                    <input type="hidden" name="accion" value="eliminar">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Eliminar" onclick="return confirm('¿Seguro que deseas eliminar esta promoción?');">
                      <i class="bi bi-trash"></i>
                    </button>
                  </form>

                </div>
              </div>
            </div>
          </div>
          <%      }
          } %>
        </div>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVA PROMOCIÓN -->
  <div class="modal fade" id="modalNuevaPromocion" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <form action="<%= request.getContextPath() %>/svpromocion" method="POST">
          <input type="hidden" name="accion" value="crear">

          <div class="modal-header border-0">
            <div>
              <h5 class="modal-title fw-bold title-font">Nueva promoción</h5>
              <p class="text-muted small mb-0">Registra una nueva promoción para los clientes.</p>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-12">
                <label class="form-label fw-semibold">Nombre de la promoción</label>
                <input type="text" name="nombre" class="form-control" placeholder="Ej. 20% de descuento" required>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-semibold">Tipo de promoción</label>
                <select name="tipo" class="form-select" required>
                  <option value="" selected disabled>Seleccionar tipo</option>
                  <option value="Descuento">Descuento</option>
                  <option value="2 + 1">2 + 1</option>
                  <option value="Combo">Combo</option>
                  <option value="Cliente frecuente">Cliente frecuente</option>
                  <option value="Oferta relámpago">Oferta relámpago</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-semibold">Aplicación (Sede)</label>
                <select name="sede" class="form-select">
                  <option value="Todas las sedes" selected>Todas las sedes</option>
                  <option value="Sede Principal">Sede Principal</option>
                  <option value="Sede Lima Norte">Sede Lima Norte</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-semibold">Fecha de inicio</label>
                <input type="date" name="fechaInicio" class="form-control" required>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-semibold">Fecha de finalización</label>
                <input type="date" name="fechaFin" class="form-control" required>
              </div>
              <div class="col-12">
                <label class="form-label fw-semibold">Descripción</label>
                <textarea name="descripcion" class="form-control" rows="4" placeholder="Describe las condiciones..." required></textarea>
              </div>
              <div class="col-12">
                <div class="form-check form-switch">
                  <input class="form-check-input" type="checkbox" name="promocionActiva" id="promocionActiva" checked>
                  <label class="form-check-label fw-semibold" for="promocionActiva">Activar promoción inmediatamente</label>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer border-0">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom">
              <i class="bi bi-check-lg me-1"></i> Crear promoción
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
  </section>