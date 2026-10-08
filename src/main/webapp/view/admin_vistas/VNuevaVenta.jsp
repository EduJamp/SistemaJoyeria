<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% boolean esNuevaVenta = "nueva-venta".equals(request.getAttribute("vistaActiva")); %>

<section id="view-nueva-venta" class="view-section <%= esNuevaVenta ? "active" : "" %>">
<div class="mb-4">
  <h3 class="fw-bold title-font mb-1">Nueva Venta</h3>
  <p class="text-muted">Registra una nueva venta y agrega los productos al carrito.</p>
</div>

<form action="<%= request.getContextPath() %>/svventa" method="POST">
  <input type="hidden" name="accion" value="registrar">

  <div class="row g-4">
    <div class="col-lg-8">
      <!-- DATOS DE LA VENTA -->
      <div class="custom-card card border-0 mb-4">
        <div class="card-body p-4">
          <h5 class="fw-bold mb-4 title-font">Datos de la venta</h5>
          <div class="row g-3">
            <div class="col-md-7">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CLIENTE</label>
              <div class="position-relative">
                <div class="input-group">
                  <input type="text" id="clienteBuscador" name="cliente" class="form-control" placeholder="Buscar cliente por nombre o DNI..." autocomplete="off">
                  <button type="button" id="btnNuevoCliente" class="btn btn-outline-secondary" title="Registrar cliente nuevo" data-bs-toggle="modal" data-bs-target="#nuevoClienteVentaModal">
                    <i class="bi bi-person-plus"></i>
                  </button>
                </div>
                <div id="clienteDropdown" class="search-dropdown d-none"></div>
              </div>
            </div>
            <div class="col-md-2">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">COMPROBANTE</label>
              <select id="ventaComprobante" name="comprobante" class="form-select">
                <option value="Boleta">Boleta</option>
                <option value="Factura">Factura</option>
              </select>
            </div>
            <div class="col-md-3">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SEDE</label>
              <div class="locked-field">
                <i class="bi bi-geo-alt-fill text-primary-custom"></i>
                <span id="ventaSedeFija">Sede Central</span>
                <i class="bi bi-lock-fill locked-icon" title="La sede se toma de tu sesión activa"></i>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- BUSCAR Y AGREGAR PRODUCTO -->
      <div class="custom-card card border-0 mb-4">
        <div class="card-body p-4">
          <h5 class="fw-bold mb-3 title-font">Agregar producto</h5>
          <div class="position-relative mb-3">
            <div class="input-group">
              <span class="input-group-text bg-transparent" style="border-color: var(--input-border);"><i class="bi bi-search text-muted"></i></span>
              <input type="text" id="productoBuscador" class="form-control" placeholder="Busca por nombre o código de barras..." autocomplete="off">
            </div>
          </div>
          <div id="productoVacioMensaje" class="text-center text-muted py-4">
            <i class="bi bi-search fs-3 d-block mb-2"></i> Busca un producto arriba para ver sus precios y agregarlo.
          </div>
        </div>
      </div>

      <!-- CARRITO -->
      <div class="custom-card card border-0">
        <div class="card-body p-4">
          <h5 class="fw-bold mb-4 title-font">Productos agregados</h5>
          <div class="table-responsive">
            <table class="table custom-table align-middle mb-0">
              <thead>
              <tr>
                <th>PRODUCTO</th><th>CANTIDAD</th><th>TARIFA</th><th>PRECIO UNIT.</th><th>SUBTOTAL</th><th class="text-end">ACCIÓN</th>
              </tr>
              </thead>
              <tbody>
              <tr><td colspan="6" class="text-center text-muted py-4">Aún no agregaste productos a esta venta.</td></tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- RESUMEN -->
    <div class="col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-4 d-flex flex-column">
          <h5 class="fw-bold mb-4 title-font">Resumen</h5>
          <div class="d-flex justify-content-between mb-2"><span class="text-muted">Items</span><span class="fw-semibold">0</span></div>
          <div class="d-flex justify-content-between mb-2"><span class="text-muted">Subtotal</span><span class="fw-semibold">S/ 0.00</span></div>
          <div class="d-flex justify-content-between mb-3"><span class="text-muted">Ahorro por mayoreo</span><span class="fw-semibold" style="color:#22c55e;">S/ 0.00</span></div>
          <hr style="border-color: var(--border-color);">
          <div class="d-flex justify-content-between mb-4"><span class="fw-bold title-font">Total a pagar</span><span class="fw-bold title-font fs-4 text-primary-custom">S/ 0.00</span></div>

          <button type="submit" class="btn btn-primary-custom fw-bold mt-auto">
            <i class="bi bi-check2-circle"></i> Registrar venta
          </button>
        </div>
      </div>
    </div>
  </div>
</form>

<!-- MODAL CLIENTE -->
<div class="modal fade" id="nuevoClienteVentaModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content custom-card border-0">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold title-font">Registrar cliente</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body p-4">
        <div class="row g-3">
          <div class="col-md-5"><label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DOCUMENTO</label><input type="text" class="form-control" placeholder="DNI o RUC"></div>
          <div class="col-md-7"><label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE / RAZÓN SOCIAL</label><input type="text" class="form-control" placeholder="Nombre completo"></div>
          <div class="col-md-12"><label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label><input type="text" class="form-control" placeholder="987 654 321"></div>
        </div>
      </div>
      <div class="modal-footer border-0 pt-0">
        <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary-custom fw-bold"><i class="bi bi-check2-circle"></i> Guardar y usar</button>
      </div>
    </div>
  </div>
</div>
</section>