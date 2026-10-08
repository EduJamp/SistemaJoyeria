<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.liamyimport.model.Venta" %>

<%
boolean esMisVentas = "mis-ventas".equals(request.getAttribute("vistaActiva"));

List<Venta> listaVentas = (List<Venta>) request.getAttribute("ventasList");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    String fechaHoyStr = sdf.format(new Date());

    double totalDia = 0.0, totalEfectivo = 0.0, totalTarjeta = 0.0;
    double totalYape = 0.0, totalPlin = 0.0, totalTransaccion = 0.0, totalSip = 0.0;

    if (listaVentas != null && !listaVentas.isEmpty()) {
    for (Venta v : listaVentas) {

    if (v.getFechaHora() != null && v.getFechaHora().startsWith(fechaHoyStr)) {

    double monto = v.getTotal();
    String metodo = v.getMetodoPago() != null ? v.getMetodoPago().toUpperCase() : "EFECTIVO";

    totalDia += monto;
    if (metodo.contains("EFECTIVO")) totalEfectivo += monto;
    else if (metodo.contains("TARJETA")) totalTarjeta += monto;
    else if (metodo.contains("YAPE")) totalYape += monto;
    else if (metodo.contains("PLIN")) totalPlin += monto;
    else if (metodo.contains("TRANS") || metodo.contains("TRANSFERENCIA")) totalTransaccion += monto;
    else if (metodo.contains("SIP")) totalSip += monto;

    }
    }
    }
    %>

    <section id="view-mis-ventas" class="view-section <%= esMisVentas ? "active" : "" %>">

    <div class="mb-4">
        <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">Mis Ventas</h3>
        <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">Historial de ventas realizadas por ti.</p>
    </div>

    <!-- RESUMEN DEL DÍA -->
    <div class="custom-card card border-0 mb-4">
        <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
                <h5 class="fw-bold title-font mb-0" style="color: var(--text-color);">Resumen del día</h5>
                <span id="misVentasFechaHoy" class="badge bg-pink-light text-primary-custom fw-semibold">
          <%= fechaHoyStr %>
        </span>
            </div>

            <div class="row g-3">
                <div class="col-6 col-md-4 col-lg-2">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">TOTAL DEL DÍA</small>
                    <span id="misVentasTotalHoy" class="fw-bold fs-5 text-primary-custom">S/ <%= String.format("%.2f", totalDia) %></span>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">EFECTIVO</small>
                    <span id="misVentasEfectivo" class="fw-bold" style="color: var(--text-color);">S/ <%= String.format("%.2f", totalEfectivo) %></span>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">TARJETA</small>
                    <span id="misVentasTarjeta" class="fw-bold" style="color: var(--text-color);">S/ <%= String.format("%.2f", totalTarjeta) %></span>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">YAPE</small>
                    <span id="misVentasYape" class="fw-bold" style="color: var(--text-color);">S/ <%= String.format("%.2f", totalYape) %></span>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">PLIN</small>
                    <span id="misVentasPlin" class="fw-bold" style="color: var(--text-color);">S/ <%= String.format("%.2f", totalPlin) %></span>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">TRANSACCIÓN</small>
                    <span id="misVentasTransaccion" class="fw-bold" style="color: var(--text-color);">S/ <%= String.format("%.2f", totalTransaccion) %></span>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">SIP</small>
                    <span id="misVentasSip" class="fw-bold" style="color: var(--text-color);">S/ <%= String.format("%.2f", totalSip) %></span>
                </div>
            </div>
        </div>
    </div>

    <div class="custom-card card border-0">
        <div class="card-body p-4">

            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4" >
                <div class="input-group search-wrapper" style="max-width: 400px;" >
                    <input type="text" id="buscadorMisVentas" class="form-control" placeholder="Buscar por cliente o comprobante..." >
                    <button type="button" class="btn btn-primary-custom">
                        <i class="bi bi-search"></i>
                    </button>
                </div>

                <button type="button" class="btn btn-outline-secondary btn-sm fw-semibold">
                    <i class="bi bi-download"></i> Exportar CSV
                </button>
            </div>

            <!-- TABLA DE VENTAS DINÁMICA -->
            <div class="table-responsive">
                <table class="table custom-table table-hover align-middle text-nowrap mb-0">
                    <thead>
                    <tr>
                        <th>FECHA Y HORA</th>
                        <th>COMPROBANTE</th>
                        <th>CLIENTE</th>
                        <th>SEDE</th>
                        <th>MÉTODO DE PAGO</th>
                        <th>TOTAL</th>
                        <th>ESTADO</th>
                        <th class="text-end">ACCIÓN</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (listaVentas != null && !listaVentas.isEmpty()) {
                    for (Venta v : listaVentas) {
                    // Control de colores del badge de estado
                    String estado = v.getEstado() != null ? v.getEstado() : "PAGADO";
                    String bgBadge = "#22c55e"; // Pagado = Verde
                    if (estado.equalsIgnoreCase("PENDIENTE")) bgBadge = "#eab308"; // Pendiente = Amarillo
                    else if (estado.equalsIgnoreCase("ANULADO")) bgBadge = "#ef4444"; // Anulado = Rojo
                    %>
                    <tr>
                        <!-- Uso correcto de getFechaHora() que tienes en tu clase Venta -->
                        <td><%= v.getFechaHora() != null ? v.getFechaHora() : "-" %></td>

                        <td class="text-primary-custom fw-bold"><%= v.getComprobante() %></td>

                        <td><%= v.getCliente() != null ? v.getCliente() : "Cliente General" %></td>

                        <td><%= v.getSede() != null ? v.getSede() : "-" %></td>

                        <td><%= v.getMetodoPago() != null ? v.getMetodoPago() : "EFECTIVO" %></td>

                        <td class="fw-bold">S/ <%= String.format("%.2f", v.getTotal()) %></td>

                        <td>
                            <span class="badge" style="background-color: <%= bgBadge %>;"><%= estado %></span>
                        </td>

                        <td class="text-end">
                            <button type="button" class="btn btn-link text-primary-custom p-0" title="Ver detalle" data-bs-toggle="modal" data-bs-target="#verVentaModal_<%= v.getId() %>">
                                <i class="bi bi-eye fs-5"></i>
                            </button>
                        </td>
                    </tr>
                    <%    }
                    } else { %>
                    <tr>
                        <td colspan="8" class="text-center py-4" style="color: var(--text-color); opacity: 0.7;">No se encontraron ventas registradas.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
    </section>