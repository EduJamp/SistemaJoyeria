<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.liamyimport.model.Caja" %>

<%
  boolean esPOS = "punto-venta".equals(request.getAttribute("vistaActiva"));
  Caja cajaActual = (Caja) request.getAttribute("cajaActual");

  boolean cajaAbierta = (cajaActual != null && "ABIERTA".equalsIgnoreCase(cajaActual.getEstado()));
%>

<section id="view-pos" class="view-section <%= esPOS ? "active" : "" %>">

<!-- Encabezado -->
<div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3 mb-4">

  <div>
    <div class="d-flex align-items-center gap-2 mb-1">
      <h2 class="title-font fw-bold mb-0" style="color: var(--text-color);">Punto de Venta</h2>
      <span class="badge bg-primary-subtle text-primary rounded-pill px-3">
                    Caja
                </span>
    </div>

    <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">
      Gestiona pedidos pendientes, aplica promociones y procesa los pagos.
    </p>
  </div>

  <div class="d-flex align-items-center gap-2">
    <!-- Badge de estado dinámico según la Caja -->
    <span class="badge px-3 py-2 rounded-pill text-white" style="background-color: <%= cajaAbierta ? "#22c55e" : "#ef4444" %>;">
    <i class="bi bi-circle-fill me-1" style="font-size:7px;"></i>
    <%= cajaAbierta ? "Caja abierta (" + cajaActual.getSede() + ")" : "Caja cerrada" %>
    </span>

    <button type="button"
            class="btn btn-primary-custom"
            data-bs-toggle="modal"
            data-bs-target="#modalBuscarVenta">
      <i class="bi bi-search me-2"></i>
      Buscar venta
    </button>
  </div>

</div>

<% if (!cajaAbierta) { %>
<!-- ALERTA SI LA CAJA ESTÁ CERRADA -->
<div class="alert alert-danger mb-4 shadow-sm" role="alert">
  <h4 class="alert-heading fw-bold"><i class="bi bi-exclamation-triangle-fill me-2"></i>¡Atención! La caja se encuentra cerrada</h4>
  <p class="mb-0">Para procesar pagos y emitir comprobantes en el Punto de Venta, primero debes realizar la <strong>Apertura de Caja</strong>.</p>
  <hr>
  <a href="<%= request.getContextPath() %>/svcaja?view=apertura-caja" class="btn btn-sm btn-danger fw-bold">Ir a Apertura de Caja</a>
</div>
<% } %>

<!-- RESUMEN DE CAJA -->
<div class="row g-3 mb-4">

  <div class="col-12 col-sm-6 col-xl-3">
    <div class="custom-card h-100 p-3" style="background-color: var(--card-bg); color: var(--text-color);">
      <div class="d-flex justify-content-between align-items-start">
        <div>
          <span class="small" style="color: var(--text-color); opacity: 0.7;">Pedidos pendientes</span>
          <h3 class="fw-bold mt-2 mb-0" style="color: var(--text-color);">08</h3>
        </div>

        <div class="rounded-3 p-2 bg-warning-subtle text-warning">
          <i class="bi bi-receipt-cutoff fs-5"></i>
        </div>
      </div>

      <small class="d-block mt-2" style="color: var(--text-color); opacity: 0.7;">
        Esperando ser cobrados
      </small>
    </div>
  </div>

  <div class="col-12 col-sm-6 col-xl-3">
    <div class="custom-card h-100 p-3" style="background-color: var(--card-bg); color: var(--text-color);">
      <div class="d-flex justify-content-between align-items-start">
        <div>
          <span class="small" style="color: var(--text-color); opacity: 0.7;">Ventas cobradas</span>
          <h3 class="fw-bold mt-2 mb-0" style="color: var(--text-color);">24</h3>
        </div>

        <div class="rounded-3 p-2 bg-success-subtle text-success">
          <i class="bi bi-check-circle fs-5"></i>
        </div>
      </div>

      <small class="d-block mt-2" style="color: var(--text-color); opacity: 0.7;">
        Durante la jornada
      </small>
    </div>
  </div>

  <div class="col-12 col-sm-6 col-xl-3">
    <div class="custom-card h-100 p-3" style="background-color: var(--card-bg); color: var(--text-color);">
      <div class="d-flex justify-content-between align-items-start">
        <div>
          <span class="small" style="color: var(--text-color); opacity: 0.7;">Recaudado hoy</span>
          <h3 class="fw-bold mt-2 mb-0" style="color: var(--text-color);">
            S/ <%= cajaAbierta ? String.format("%.2f", cajaActual.getMontoInicial()) : "0.00" %>
          </h3>
        </div>

        <div class="rounded-3 p-2 bg-primary-subtle text-primary">
          <i class="bi bi-cash-stack fs-5"></i>
        </div>
      </div>

      <small class="text-success d-block mt-2">
        <i class="bi bi-arrow-up-short"></i>
        Monto inicial registrado
      </small>
    </div>
  </div>

  <div class="col-12 col-sm-6 col-xl-3">
    <div class="custom-card h-100 p-3" style="background-color: var(--card-bg); color: var(--text-color);">
      <div class="d-flex justify-content-between align-items-start">
        <div>
          <span class="small" style="color: var(--text-color); opacity: 0.7;">Responsable de caja</span>
          <h6 class="fw-bold mt-2 mb-0 text-truncate" style="color: var(--text-color);" title="<%= cajaAbierta ? cajaActual.getResponsable() : "Ninguno" %>">
          <%= cajaAbierta ? cajaActual.getResponsable() : "N/D" %>
          </h6>
        </div>

        <div class="rounded-3 p-2 bg-info-subtle text-info">
          <i class="bi bi-person-badge fs-5"></i>
        </div>
      </div>

      <small class="d-block mt-2" style="color: var(--text-color); opacity: 0.7;">
        Turno actual activo
      </small>
    </div>
  </div>

</div>

<!-- CONTENIDO PRINCIPAL -->
<div class="row g-4">

  <!-- LISTA DE PEDIDOS -->
  <div class="col-12 col-xl-7">

    <div class="custom-card h-100" style="background-color: var(--card-bg); color: var(--text-color);">

      <div class="p-4 border-bottom" style="border-color: var(--border-color) !important;">

        <div class="d-flex flex-column flex-md-row justify-content-between gap-3">

          <div>
            <h5 class="title-font fw-bold mb-1" style="color: var(--text-color);">
              Pedidos por cobrar
            </h5>

            <p class="small mb-0" style="color: var(--text-color); opacity: 0.75;">
              Selecciona un pedido para revisar y procesar su pago.
            </p>
          </div>

          <div class="input-group" style="max-width:280px;">
                            <span class="input-group-text bg-transparent border-end-0" style="border-color: var(--border-color); color: var(--text-color);">
                                <i class="bi bi-search"></i>
                            </span>

            <input type="text"
                   class="form-control border-start-0"
                   placeholder="Buscar pedido o cliente..." style="background-color: transparent; color: var(--text-color); border-color: var(--border-color);">
          </div>

        </div>

        <!-- FILTROS -->
        <div class="d-flex flex-wrap gap-2 mt-3">
          <button class="btn btn-sm btn-primary-custom">
            Todos <span class="badge bg-white text-primary ms-1">8</span>
          </button>
          <button class="btn btn-sm btn-outline-secondary">
            Pendientes <span class="badge bg-light text-dark ms-1">5</span>
          </button>
        </div>

      </div>

      <!-- PEDIDO 1 (Ejemplo estático funcional) -->
      <div class="p-4 border-bottom" style="border-color: var(--border-color) !important;">
        <div class="d-flex gap-3">
          <div class="rounded-3 bg-primary-subtle text-primary d-flex align-items-center justify-content-center flex-shrink-0"
               style="width:48px;height:48px;">
            <i class="bi bi-receipt fs-5"></i>
          </div>
          <div class="flex-grow-1">
            <div class="d-flex flex-column flex-md-row justify-content-between gap-2">
              <div>
                <div class="d-flex align-items-center gap-2">
                  <h6 class="fw-bold mb-0" style="color: var(--text-color);">Pedido #PED-00481</h6>
                  <span class="badge bg-warning-subtle text-warning">Pendiente</span>
                </div>
                <small style="color: var(--text-color); opacity: 0.7;">Carlos Mendoza · Hace 4 min</small>
              </div>
              <div class="text-md-end">
                <strong class="fs-5" style="color: var(--text-color);">S/ 2,244.50</strong>
                <div class="small" style="color: var(--text-color); opacity: 0.7;">3 productos</div>
              </div>
            </div>
            <div class="d-flex justify-content-end mt-3">
              <button type="button"
                      class="btn btn-sm btn-primary-custom <%= !cajaAbierta ? "disabled" : "" %>"
              onclick="seleccionarPedido('PED-00481')">
              Cobrar pedido
              <i class="bi bi-arrow-right ms-1"></i>
              </button>
            </div>
          </div>
        </div>
      </div>

    </div>

  </div>

  <!-- PANEL DE COBRO -->
  <div class="col-12 col-xl-5">

    <div class="custom-card sticky-xl-top" style="top:80px; background-color: var(--card-bg); color: var(--text-color);">

      <!-- CABECERA -->
      <div class="p-4 border-bottom" style="border-color: var(--border-color) !important;">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <span class="small" style="color: var(--text-color); opacity: 0.7;">Pedido seleccionado</span>
            <h4 class="title-font fw-bold mb-1" style="color: var(--text-color);">#PED-00481</h4>
            <span style="color: var(--text-color); opacity: 0.8;">Carlos Mendoza</span>
          </div>
          <button class="btn btn-sm btn-light border" title="Cambiar pedido">
            <i class="bi bi-arrow-left-right"></i>
          </button>
        </div>
      </div>

      <!-- TOTAL Y BOTÓN DE CONFIRMACIÓN CONECTADO A LA CAJA -->
      <div class="p-4">
        <div class="d-flex justify-content-between mb-2">
          <span style="color: var(--text-color); opacity: 0.7;">Subtotal</span>
          <span style="color: var(--text-color);">S/ 2,440.00</span>
        </div>

        <div class="d-flex justify-content-between align-items-center pt-3 border-top" style="border-color: var(--border-color) !important;">
          <span class="fw-bold" style="color: var(--text-color);">TOTAL</span>
          <span class="fs-3 fw-bold text-primary">S/ 2,244.50</span>
        </div>

        <!-- Botón deshabilitado si la caja está cerrada -->
        <button type="button"
                class="btn btn-primary-custom w-100 py-3 mt-3 fw-semibold <%= !cajaAbierta ? "disabled" : "" %>"
        data-bs-toggle="modal" data-bs-target="#modalConfirmarCobro">
        <i class="bi bi-check2-circle me-2"></i>
        Confirmar y cobrar S/ 2,244.50
        </button>

        <% if (!cajaAbierta) { %>
        <small class="text-danger d-block text-center mt-2">Debes abrir caja para confirmar pagos.</small>
        <% } %>
      </div>

    </div>

  </div>

</div>

</section>

<!-- MODAL: CONFIRMAR COBRO -->
<div class="modal fade" id="modalConfirmarCobro" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="background-color: var(--card-bg); color: var(--text-color);">
      <div class="modal-header border-0">
        <h5 class="modal-title title-font fw-bold">Confirmar cobro</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center p-4">
        <div class="rounded-circle bg-success-subtle text-success d-flex align-items-center justify-content-center mx-auto mb-3" style="width:70px;height:70px;">
          <i class="bi bi-check2-circle fs-1"></i>
        </div>
        <h5 class="fw-bold">¿Confirmar el pago?</h5>
        <p class="small mb-3" style="opacity: 0.8;">Se registrará el ingreso a nombre de: <strong><%= cajaAbierta ? cajaActual.getResponsable() : "N/D" %></strong></p>
      </div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Revisar</button>
        <button type="button" class="btn btn-primary-custom" onclick="alert('¡Pago procesado con éxito en la caja de la sede <%= cajaAbierta ? cajaActual.getSede() : "" %>!'); location.reload();">
        <i class="bi bi-check-lg me-1"></i> Confirmar pago
        </button>
      </div>
    </div>
  </div>
</div>