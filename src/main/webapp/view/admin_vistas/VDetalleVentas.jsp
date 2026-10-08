<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Venta" %>
<% boolean esDetalleVentas = "detalle-ventas".equals(request.getAttribute("vistaActiva")); %>

<section id="view-detalle-ventas" class="view-section <%= esDetalleVentas ? "active" : "" %>">
<div class="mb-4">
  <h3 class="fw-bold title-font mb-1">Detalle de Ventas</h3>
  <p class="text-muted">Consulta el detalle de todas las ventas realizadas en un rango de fechas.</p>
</div>

<!-- FILTRO DE FECHAS -->
<div class="custom-card card border-0 mb-4 p-3">
  <div class="row g-3 align-items-end">
    <div class="col-md-4"><label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA INICIO</label><input type="date" class="form-control"></div>
    <div class="col-md-4"><label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA FIN</label><input type="date" class="form-control"></div>
    <div class="col-md-2"><button type="button" class="btn btn-primary-custom w-100 fw-bold">BUSCAR</button></div>
    <div class="col-md-2"><button type="button" class="btn btn-outline-secondary w-100 fw-bold">LIMPIAR</button></div>
  </div>
</div>

<!-- TABLA DE VENTAS GENERALES -->
<div class="custom-card card border-0">
  <div class="card-body p-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h5 class="fw-bold title-font mb-0">Ventas del período</h5>
      <button type="button" class="btn btn-outline-secondary btn-sm fw-semibold"><i class="bi bi-download"></i> Exportar CSV</button>
    </div>

    <div class="table-responsive">
      <table class="table custom-table table-hover align-middle text-nowrap mb-0">
        <thead>
        <tr>
          <th>FECHA Y HORA</th><th>COMPROBANTE</th><th>CLIENTE</th><th>EMPLEADO</th><th>MÉTODO DE PAGO</th><th>TOTAL</th>
        </tr>
        </thead>
        <tbody>
        <%
        List<Venta> detalleVentasList = (List<Venta>) request.getAttribute("ventasList");
          if (detalleVentasList != null && !detalleVentasList.isEmpty()) {
          for (Venta v : detalleVentasList) {
          %>
          <tr>
            <td class="text-muted"><%= v.getFechaHora() %></td>
            <td class="text-primary-custom fw-bold"><%= v.getComprobante() %></td>
            <td><%= v.getCliente() %></td>
            <td><%= v.getEmpleado() %></td>
            <td><span class="badge bg-light text-dark border"><%= v.getMetodoPago() %></span></td>
            <td class="fw-bold">S/ <%= String.format("%.2f", v.getTotal()) %></td>
          </tr>
          <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</section>