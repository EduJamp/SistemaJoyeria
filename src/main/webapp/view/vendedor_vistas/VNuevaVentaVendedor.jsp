<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% boolean esNuevaVenta = "nueva-venta".equals(request.getAttribute("vistaActiva")); %>

<section id="view-nueva-venta" class="view-section <%= esNuevaVenta ? "active" : "" %>">

<div class="mb-4">
  <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">Nueva Venta</h3>
  <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">Registra una nueva venta y agrega los productos al carrito.</p>
</div>

<div class="row g-4">

  <!-- COLUMNA IZQUIERDA -->
  <div class="col-lg-8">

    <!-- ============ DATOS DE LA VENTA ============ -->
    <div class="custom-card card border-0 mb-4">
      <div class="card-body p-4">

        <h5 class="fw-bold mb-4 title-font" style="color: var(--text-color);">Datos de la venta</h5>

        <div class="row g-3">

          <!-- CLIENTE  -->
          <div class="col-md-7">

            <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
              CLIENTE
            </label>

            <div class="position-relative">

              <div class="input-group">
                <input
                        type="text"
                        id="clienteBuscador"
                        class="form-control"
                        placeholder="Buscar cliente por nombre o DNI..."
                        autocomplete="off"
                >
                <button type="button" id="btnNuevoCliente" class="btn btn-outline-secondary" title="Registrar cliente nuevo" data-bs-toggle="modal" data-bs-target="#nuevoClienteVentaModal">
                  <i class="bi bi-person-plus"></i>
                </button>
              </div>

              <!-- Dropdown de sugerencias -->
              <div id="clienteDropdown" class="search-dropdown d-none"></div>

            </div>

            <!-- Chip del cliente seleccionado -->
            <div id="clienteSeleccionadoChip" class="selected-chip d-none mt-2">
              <i class="bi bi-person-check-fill text-primary-custom"></i>
              <span id="clienteSeleccionadoNombre" class="fw-semibold"></span>
              <button type="button" id="btnQuitarCliente" class="chip-close" title="Quitar cliente">
                <i class="bi bi-x"></i>
              </button>
            </div>

          </div>

          <!-- TIPO DE COMPROBANTE -->
          <div class="col-md-2">
            <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
              COMPROBANTE
            </label>
            <select id="ventaComprobante" class="form-select">
              <option>Boleta</option>
              <option>Factura</option>
            </select>
          </div>

          <!-- SEDE -->
          <div class="col-md-3">
            <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
              SEDE
            </label>
            <div class="locked-field">
              <i class="bi bi-geo-alt-fill text-primary-custom"></i>
              <span id="ventaSedeFija">Sede Central</span>
              <i class="bi bi-lock-fill locked-icon" title="La sede se toma de tu sesión activa"></i>
            </div>
          </div>

        </div>

      </div>
    </div>

    <!-- ============ BUSCAR Y AGREGAR PRODUCTO ============ -->
    <div class="custom-card card border-0 mb-4">
      <div class="card-body p-4">

        <h5 class="fw-bold mb-3 title-font" style="color: var(--text-color);">Agregar producto</h5>

        <div class="position-relative mb-3">

          <div class="input-group">
                            <span class="input-group-text bg-transparent" style="border-color: var(--input-border);">
                                <i class="bi bi-search" style="color: var(--text-color); opacity: 0.7;"></i>
                            </span>
            <input
                    type="text"
                    id="productoBuscador"
                    class="form-control"
                    placeholder="Busca por nombre o código de barras..."
                    autocomplete="off"
            >
          </div>

          <!-- Dropdown de sugerencias de productos -->
          <div id="productoDropdown" class="search-dropdown d-none"></div>

        </div>

        <!-- Panel del producto seleccionado -->
        <div id="productoSeleccionadoPanel" class="d-none">

          <div class="d-flex align-items-center gap-3 mb-3 p-3" style="background: var(--bg-primary); border-radius: 12px;">

            <div class="d-flex align-items-center justify-content-center" style="width:56px; height:56px; min-width:56px; background: var(--card-bg); border-radius:12px;">
              <i class="bi bi-gem text-primary-custom fs-4"></i>
            </div>

            <div class="flex-grow-1">
              <span id="psNombre" class="fw-bold d-block" style="color: var(--text-color);"></span>
              <small id="psCodigo" style="color: var(--text-color); opacity: 0.7;"></small>
            </div>

            <button type="button" id="btnQuitarProducto" class="btn btn-link p-0" style="color: var(--text-color); opacity: 0.7;" title="Cambiar producto">
              <i class="bi bi-x-circle fs-5"></i>
            </button>

          </div>

          <!-- Tabla de precios por volumen (NO editable) -->
          <label class="form-label fw-bold mb-2" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
            PRECIOS POR VOLUMEN
          </label>

          <div class="row g-2 mb-4" id="tablaTarifas">

            <div class="col-6 col-md-3">
              <div class="tarifa-box" data-tier="unidad">
                <small class="d-block" style="font-size:0.65rem; color: var(--text-color); opacity: 0.7;">UNIDAD</small>
                <span class="fw-bold tarifa-precio" data-precio-tier="unidad">S/ 0.00</span>
              </div>
            </div>

            <div class="col-6 col-md-3">
              <div class="tarifa-box" data-tier="cuarto">
                <small class="d-block" style="font-size:0.65rem; color: var(--text-color); opacity: 0.7;">1/4 DOCENA (3+)</small>
                <span class="fw-bold tarifa-precio" data-precio-tier="cuarto">S/ 0.00</span>
              </div>
            </div>

            <div class="col-6 col-md-3">
              <div class="tarifa-box" data-tier="media">
                <small class="d-block" style="font-size:0.65rem; color: var(--text-color); opacity: 0.7;">1/2 DOCENA (6+)</small>
                <span class="fw-bold tarifa-precio" data-precio-tier="media">S/ 0.00</span>
              </div>
            </div>

            <div class="col-6 col-md-3">
              <div class="tarifa-box" data-tier="docena">
                <small class="d-block" style="font-size:0.65rem; color: var(--text-color); opacity: 0.7;">DOCENA A MÁS (12+)</small>
                <span class="fw-bold tarifa-precio" data-precio-tier="docena">S/ 0.00</span>
              </div>
            </div>

          </div>

          <div class="row g-3 align-items-end">

            <div class="col-md-3">
              <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">CANTIDAD</label>
              <input type="number" id="productoCantidad" class="form-control" min="1" value="1">
            </div>

            <div class="col-md-4">
              <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">TARIFA APLICADA</label>
              <div class="locked-field">
                <span id="tarifaAplicadaNombre" class="fw-semibold">Unidad</span>
              </div>
            </div>

            <div class="col-md-3">
              <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">PRECIO UNIT.</label>
              <div class="locked-field justify-content-center">
                <span id="precioAplicado" class="fw-bold text-primary-custom">S/ 0.00</span>
              </div>
            </div>

            <div class="col-md-2">
              <button type="button" id="btnAgregarProducto" class="btn btn-primary-custom w-100 fw-bold">
                <i class="bi bi-plus-lg"></i>
              </button>
            </div>

          </div>

        </div>

        <!-- Estado vacío antes de elegir un producto -->
        <div id="productoVacioMensaje" class="text-center py-4" style="color: var(--text-color); opacity: 0.7;">
          <i class="bi bi-search fs-3 d-block mb-2"></i>
          Busca un producto arriba para ver sus precios y agregarlo.
        </div>

      </div>
    </div>

    <!-- ============ CARRITO ============ -->
    <div class="custom-card card border-0">
      <div class="card-body p-4">

        <h5 class="fw-bold mb-4 title-font" style="color: var(--text-color);">Productos agregados</h5>

        <div class="table-responsive">
          <table class="table custom-table align-middle mb-0">
            <thead>
            <tr>
              <th>PRODUCTO</th>
              <th>CANTIDAD</th>
              <th>TARIFA</th>
              <th>PRECIO UNIT.</th>
              <th>SUBTOTAL</th>
              <th class="text-end">ACCIÓN</th>
            </tr>
            </thead>
            <tbody id="carritoBody">
            <tr id="carritoVacio">
              <td colspan="6" class="text-center py-4" style="color: var(--text-color); opacity: 0.7;">
                Aún no agregaste productos a esta venta.
              </td>
            </tr>
            </tbody>
          </table>
        </div>

      </div>
    </div>

  </div>

  <!-- COLUMNA DERECHA: RESUMEN -->
  <div class="col-lg-4">

    <div class="custom-card card border-0 h-100">
      <div class="card-body p-4 d-flex flex-column">

        <h5 class="fw-bold mb-4 title-font" style="color: var(--text-color);">Resumen</h5>

        <div class="d-flex justify-content-between mb-2">
          <span style="color: var(--text-color); opacity: 0.75;">Items</span>
          <span id="resumenItems" class="fw-semibold">0</span>
        </div>

        <div class="d-flex justify-content-between mb-2">
          <span style="color: var(--text-color); opacity: 0.75;">Subtotal</span>
          <span id="resumenSubtotal" class="fw-semibold">S/ 0.00</span>
        </div>

        <div class="d-flex justify-content-between mb-3">
          <span style="color: var(--text-color); opacity: 0.75;">Ahorro por mayoreo</span>
          <span id="resumenAhorro" class="fw-semibold" style="color:#22c55e;">S/ 0.00</span>
        </div>

        <hr style="border-color: var(--border-color);">

        <div class="d-flex justify-content-between mb-4">
          <span class="fw-bold title-font" style="color: var(--text-color);">Total a pagar</span>
          <span id="resumenTotal" class="fw-bold title-font fs-4 text-primary-custom">S/ 0.00</span>
        </div>

        <button type="button" id="btnRegistrarVenta" class="btn btn-primary-custom fw-bold mt-auto">
          <i class="bi bi-check2-circle"></i>
          Registrar venta
        </button>

      </div>
    </div>

  </div>

</div>

<!-- MODAL: NUEVO CLIENTE -->
<div class="modal fade" id="nuevoClienteVentaModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content custom-card border-0">

      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold title-font" style="color: var(--text-color);">Registrar cliente</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>

      <div class="modal-body p-4">

        <div class="row g-3">

          <div class="col-md-5">
            <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">DOCUMENTO</label>
            <input type="text" id="ncvDocumento" class="form-control" placeholder="DNI o RUC">
          </div>

          <div class="col-md-7">
            <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">NOMBRE / RAZÓN SOCIAL</label>
            <input type="text" id="ncvNombre" class="form-control" placeholder="Nombre completo">
          </div>

          <div class="col-md-12">
            <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">TELÉFONO (OPCIONAL)</label>
            <input type="text" id="ncvTelefono" class="form-control" placeholder="987 654 321">
          </div>

        </div>

      </div>

      <div class="modal-footer border-0 pt-0">
        <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" id="btnGuardarClienteVenta" class="btn btn-primary-custom fw-bold">
          <i class="bi bi-check2-circle"></i>
          Guardar y usar en esta venta
        </button>
      </div>

    </div>
  </div>
</div>

</section>