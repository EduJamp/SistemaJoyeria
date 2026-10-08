<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Venta" %>
<% boolean esMisVentas = "mis-ventas".equals(request.getAttribute("vistaActiva")); %>

<section id="view-mis-ventas" class="view-section <%= esMisVentas ? "active" : "" %>">
<div class="mb-4">
  <h3 class="fw-bold title-font mb-1">Mis Ventas</h3>
  <p class="text-muted">Historial de ventas realizadas por ti.</p>
</div>

<!-- RESUMEN DEL DÍA -->
<div class="custom-card card border-0 mb-4">
  <div class="card-body p-4">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
      <h5 class="fw-bold title-font mb-0">Resumen del día</h5>
      <span class="badge bg-pink-light text-primary-custom fw-semibold">27/09/2026</span>
    </div>
    <div class="row g-3">
      <div class="col-6 col-md-4 col-lg-2">
        <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL DEL DÍA</small>
        <span class="fw-bold fs-5 text-primary-custom">S/ 465.50</span>
      </div>
      <!-- Otros KPI omitidos visualmente para no extender, puedes pegarlos de tu original -->
    </div>
  </div>
</div>

<div class="custom-card card border-0">
  <div class="card-body p-4">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
      <div class="input-group search-wrapper" style="max-width: 400px;">
        <input type="text" class="form-control" placeholder="Buscar por cliente o comprobante...">
        <button type="button" class="btn btn-primary-custom"><i class="bi bi-search"></i></button>
      </div>
      <button type="button" class="btn btn-outline-secondary btn-sm fw-semibold"><i class="bi bi-download"></i> Exportar CSV</button>
    </div>

    <div class="table-responsive">
      <table class="table custom-table table-hover align-middle text-nowrap mb-0">
        <thead>
        <tr>
          <th>FECHA Y HORA</th><th>COMPROBANTE</th><th>CLIENTE</th><th>SEDE</th><th>TOTAL</th><th>ESTADO</th><th class="text-end">ACCIÓN</th>
        </tr>
        </thead>
        <tbody>
        <%
        List<Venta> misVentasList = (List<Venta>) request.getAttribute("ventasList");
          if (misVentasList != null && !misVentasList.isEmpty()) {
          for (Venta v : misVentasList) {
          String badgeColor = "Pagado".equalsIgnoreCase(v.getEstado()) ? "#22c55e" : "#eab308";
          %>
          <tr>
            <td><%= v.getFechaHora() %></td>
            <td class="text-primary-custom fw-bold"><%= v.getComprobante() %></td>
            <td><%= v.getCliente() %></td>
            <td><%= v.getSede() %></td>
            <td class="fw-bold">S/ <%= String.format("%.2f", v.getTotal()) %></td>
            <td><span class="badge" style="background-color:<%= badgeColor %>;"><%= v.getEstado() %></span></td>
            <td class="text-end"><button class="btn btn-link text-primary-custom p-0"><i class="bi bi-eye fs-5"></i></button></td>
          </tr>
          <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</section>