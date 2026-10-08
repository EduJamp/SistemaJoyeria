<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Inventario" %>

<%
boolean esConteo = "conteo-productos".equals(request.getAttribute("vistaActiva"));
List<Inventario> listaInventario = (List<Inventario>) request.getAttribute("listaInventario");

    int totalProductos = (listaInventario != null) ? listaInventario.size() : 0;
    int contados = 0;
    int unidadesTotales = 0;

    if (listaInventario != null) {
    for (Inventario inv : listaInventario) {
    if (inv.getFechaConteo() != null && !inv.getFechaConteo().equals("-")) {
    contados++;
    }
    unidadesTotales += inv.getContado();
    }
    }
    int pendientes = totalProductos - contados;
    int porcentajeProgreso = totalProductos > 0 ? (contados * 100) / totalProductos : 0;
    %>

    <section id="view-conteo-productos" class="view-section <%= esConteo ? "active" : "" %>">

    <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
        <div>
            <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">
                Conteo de Inventario
            </h3>
            <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">
                Registra la cantidad física que encuentres de cada producto.
            </p>
        </div>

        <span id="conteoProgreso" class="badge bg-pink-light text-primary-custom fw-semibold">
            <%= contados %> de <%= totalProductos %> productos contados
        </span>
    </div>

    <!-- FILTROS -->
    <div class="custom-card card border-0 mb-4 p-3">
        <div class="row g-3 align-items-end">
            <div class="col-md-4">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                    SEDE
                </label>
                <select class="form-select">
                    <option>Sede Central</option>
                    <option>Miraflores</option>
                    <option>San Isidro</option>
                </select>
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

            <div class="col-md-5">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                    BUSCAR PRODUCTO
                </label>
                <div class="input-group">
                    <input type="text" id="conteoBuscador" class="form-control" placeholder="Nombre o código de barras...">
                    <button type="button" class="btn btn-primary-custom">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- RESUMEN DEL CONTEO -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-lg-4">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">PRODUCTOS CONTADOS</small>
                    <span id="resumenContados" class="fw-bold fs-5" style="color: var(--text-color);"><%= contados %> / <%= totalProductos %></span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-4">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">UNIDADES REGISTRADAS</small>
                    <span id="resumenUnidades" class="fw-bold fs-5" style="color: var(--text-color);"><%= unidadesTotales %></span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-4">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">PENDIENTES</small>
                    <span id="resumenPendientes" class="fw-bold fs-5" style="color:#eab308;"><%= pendientes %></span>
                </div>
            </div>
        </div>
    </div>

    <!-- TABLA KARDEX DE CONTEO -->
    <div class="custom-card card border-0">
        <div class="card-body p-4">

            <form action="<%= request.getContextPath() %>/svinventario" method="POST">
                <input type="hidden" name="accion" value="guardar">

                <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                    <h5 class="fw-bold title-font mb-0" style="color: var(--text-color);">
                        Detalle del conteo
                    </h5>

                    <button type="submit" id="btnGuardarConteo" class="btn btn-primary-custom fw-bold">
                        <i class="bi bi-save2"></i>
                        Guardar conteo
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table custom-table align-middle mb-0" id="tablaConteo" style="color: var(--text-color);">
                        <thead>
                        <tr>
                            <th>CÓDIGO DE BARRAS</th>
                            <th>PRODUCTO</th>
                            <th>SEDE</th>
                            <th class="text-center">STOCK SISTEMA</th>
                            <th class="text-center" style="min-width:160px;">CANTIDAD CONTADA</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                        if (listaInventario != null && !listaInventario.isEmpty()) {
                        for (Inventario inv : listaInventario) {
                        %>
                        <tr class="fila-conteo">
                            <td style="color: var(--text-color);"><%= inv.getCodigoBarras() %></td>
                            <td class="fw-semibold" style="color: var(--text-color);"><%= inv.getProducto() %></td>
                            <td style="color: var(--text-color); opacity: 0.8;"><%= inv.getSede() %></td>
                            <td class="text-center fw-bold" style="color: var(--text-color);"><%= inv.getStockSistema() %></td>
                            <td class="text-center">
                                <input type="number"
                                       name="contado_<%= inv.getCodigoBarras() %>"
                                       class="form-control text-center input-conteo"
                                       min="0"
                                       value="<%= inv.getContado() > 0 ? inv.getContado() : "" %>"
                                placeholder="Cantidad...">
                            </td>
                        </tr>
                        <%
                        }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center py-4" style="color: var(--text-color); opacity: 0.7;">No hay registros de inventario disponibles.</td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </form>

        </div>
    </div>

    </section>