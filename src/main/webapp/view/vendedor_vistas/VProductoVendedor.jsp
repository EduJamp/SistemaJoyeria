<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Producto" %>
<%@ page import="com.liamyimport.util.csv.ProductoRepository" %>
<%
String vistaActivaProd = (String) request.getAttribute("vistaActiva");
boolean esProductosProd = "productos".equals(vistaActivaProd);
%>
<section id="view-productos" class="view-section <%= esProductosProd ? "active" : "" %>">

<div class="mb-4">
  <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">
    Productos
  </h3>
  <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">
    Consulta el catálogo de bijouterie y su disponibilidad en almacén.
  </p>
</div>

<!-- FILTROS -->
<div class="custom-card card border-0 mb-4 p-3">

  <div class="row g-3 align-items-end">

    <div class="col-md-6">

      <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
        BUSCAR PRODUCTO
      </label>

      <div class="input-group">

        <input type="text" class="form-control" placeholder="Nombre o código de barras..." >

        <button type="button" class="btn btn-primary-custom">
          <i class="bi bi-search"></i>
        </button>

      </div>

    </div>

    <div class="col-md-3">

      <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
        LÍNEA
      </label>

      <select class="form-select">
        <option>Todas</option>
        <option>Dama</option>
        <option>Caballero</option>
      </select>

    </div>

    <div class="col-md-3">

      <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
        DISPONIBILIDAD
      </label>

      <select class="form-select">
        <option>Todos</option>
        <option>Con stock</option>
        <option>Stock bajo</option>
        <option>Agotado</option>
      </select>

    </div>

  </div>

</div>

<!-- GRID DE PRODUCTOS -->
<div class="row g-4" id="gridProductosContainer">
  <%
  List<Producto> listaProductos = (List<Producto>) request.getAttribute("productos");

  if (listaProductos == null) {
  ProductoRepository repoSeguridad = new ProductoRepository();
  listaProductos = repoSeguridad.obtenerTodos();
  }

  if (listaProductos != null && !listaProductos.isEmpty()) {
  for (Producto p : listaProductos) {
  String codigoSeguro = p.getCodigoBarras() != null ? p.getCodigoBarras().trim() : "";
  String stockColor = p.getCantidad() > 5 ? "#22c55e" : "#eab308";
  String nombreCategoria = (p.getCategoria() != null) ? "Categoría ID: " + p.getCategoria().getId() : "General";
  %>

  <!-- TARJETA DINÁMICA DE PRODUCTO -->
  <div class="col-sm-6 col-lg-4 col-xl-3">
    <div class="custom-card card border-0 h-100">
      <div class="d-flex align-items-center justify-content-center" style="height: 160px; background-color: var(--bg-primary); border-radius: 16px 16px 0 0;">
        <i class="bi bi-gem" style="font-size: 2.5rem; color: var(--text-color); opacity: 0.5;"></i>
      </div>
      <div class="card-body p-3">
          <span class="badge bg-pink-light text-primary-custom mb-2" style="font-size: 0.65rem;">
              <%= nombreCategoria %>
          </span>
        <h6 class="fw-bold mb-1" style="color: var(--text-color);">
          <%= p.getNombre() %>
        </h6>
        <small class="d-block mb-2" style="color: var(--text-color); opacity: 0.7;">
          Cód. barras: <%= p.getCodigoBarras() %>
        </small>
        <div class="d-flex justify-content-between align-items-center mb-3">
              <span class="fw-bold text-primary-custom fs-6">
                  S/ <%= String.format("%.2f", p.getPrecioUnidad()) %>
              </span>
          <span class="badge" style="background-color: <%= stockColor %>; color: #000;">
                  <%= p.getCantidad() %> en stock
              </span>
        </div>

        <div class="d-flex gap-2">
          <button type="button" class="btn btn-outline-secondary w-100 fw-semibold" data-bs-toggle="modal" data-bs-target="#productoModal_<%= codigoSeguro %>">
            <i class="bi bi-eye"></i> Ver detalle
          </button>
        </div>

      </div>
    </div>
  </div>

  <%
  }
  } else {
  %>
  <div class="col-12 text-center py-5">
    <p style="color: var(--text-color); opacity: 0.7;">No hay productos registrados todavía.</p>
  </div>
  <% } %>
</div>

<!-- MODALES DE DETALLE -->
<%
List<Producto> listaModalesProductos = (List<Producto>) request.getAttribute("productos");
  if (listaModalesProductos == null) {
  ProductoRepository repoSeguridadModal = new ProductoRepository();
  listaModalesProductos = repoSeguridadModal.obtenerTodos();
  }

  if (listaModalesProductos != null && !listaModalesProductos.isEmpty()) {
  for (Producto p : listaModalesProductos) {
  String codigoSeguro = p.getCodigoBarras() != null ? p.getCodigoBarras().trim() : "";
  String nombreCategoria = (p.getCategoria() != null) ? "Categoría ID: " + p.getCategoria().getId() : "General";
  String descripcion = (p.getDescripcion() != null && !p.getDescripcion().isEmpty()) ? p.getDescripcion() : "Sin descripción disponible para este producto.";
  %>

  <!-- MODAL DINÁMICO DE DETALLE POR PRODUCTO -->
  <div class="modal fade" id="productoModal_<%= codigoSeguro %>" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">

        <div class="modal-header border-0 pb-0">
          <h5 class="modal-title fw-bold title-font" style="color: var(--text-color);">Detalle del producto</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>

        <div class="modal-body p-4">
          <div class="row g-4">
            <div class="col-md-5">
              <div class="d-flex align-items-center justify-content-center" style="height: 220px; background-color: var(--bg-primary); border-radius: 16px;">
                <i class="bi bi-gem" style="font-size: 3.5rem; color: var(--text-color); opacity: 0.5;"></i>
              </div>
            </div>

            <div class="col-md-7">
              <span class="badge bg-pink-light text-primary-custom mb-2">
                  <%= nombreCategoria %>
              </span>
              <h4 class="fw-bold title-font mb-2" style="color: var(--text-color);">
                <%= p.getNombre() %>
              </h4>
              <p class="mb-3" style="font-size: 0.9rem; color: var(--text-color); opacity: 0.8;">
                <%= descripcion %>
              </p>

              <div class="row g-3">
                <div class="col-6">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">PRECIO UNIDAD</small>
                  <span class="fw-bold fs-5 text-primary-custom">S/ <%= String.format("%.2f", p.getPrecioUnidad()) %></span>
                </div>
                <div class="col-6">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">STOCK DISPONIBLE</small>
                  <span class="fw-bold fs-5" style="color: var(--text-color);"><%= p.getCantidad() %> unidades</span>
                </div>
                <div class="col-6">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">ESTADO</small>
                  <span class="fw-semibold" style="color: var(--text-color);"><%= p.getEstado() != null ? p.getEstado().name() : "N/A" %></span>
                </div>
                <div class="col-6">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">PRECIO PAQUETE</small>
                  <span class="fw-semibold" style="color: var(--text-color);">S/ <%= String.format("%.2f", p.getPrecioPaquete()) %></span>
                </div>
              </div>

              <hr style="border-color: var(--border-color);">
              <small class="fw-bold d-block mb-2" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">
                CÓDIGO DE BARRAS
              </small>
              <div class="d-inline-block px-3 py-2" style="background:var(--bg-primary); border-radius:10px;">
                <span class="fw-bold" style="color: var(--text-color);"><%= p.getCodigoBarras() %></span>
              </div>
            </div>
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