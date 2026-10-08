<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Inventario" %>

<%
String vistaActivaAud = (String) request.getAttribute("vistaActiva");
boolean esAuditoria = "auditoria-inventario".equals(vistaActivaAud);
%>

<section id="view-auditoria-inventario" class="view-section <%= esAuditoria ? "active" : "" %>">

<div class="mb-4">
  <h3 class="fw-bold title-font mb-1">
    Resultados de Conteo
  </h3>
  <p class="text-muted">
    Compara el conteo físico registrado por tus vendedores contra el stock del sistema.
  </p>
</div>

<!-- FILTROS -->
<div class="custom-card card border-0 mb-4 p-3">
  <div class="row g-3 align-items-end">
    <div class="col-md-3">
      <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SEDE</label>
      <select id="rcFiltroSede" class="form-select">
        <option value="">Todas</option>
        <option>Sede Central</option>
        <option>Miraflores</option>
        <option>San Isidro</option>
      </select>
    </div>

    <div class="col-md-3">
      <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">VENDEDOR</label>
      <select id="rcFiltroVendedor" class="form-select">
        <option value="">Todos</option>
        <option>Luciana R.</option>
        <option>Diego M.</option>
      </select>
    </div>

    <div class="col-md-3">
      <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
      <select id="rcFiltroEstado" class="form-select">
        <option value="">Todos</option>
        <option value="Correcto">Correcto</option>
        <option value="Faltante">Faltante</option>
        <option value="Sobrante">Sobrante</option>
      </select>
    </div>

    <div class="col-md-3">
      <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">BUSCAR PRODUCTO</label>
      <div class="input-group">
        <input type="text" id="rcBuscador" class="form-control" placeholder="Nombre o código...">
        <button type="button" id="btnRcFiltrar" class="btn btn-primary-custom">
          <i class="bi bi-search"></i>
        </button>
      </div>
    </div>
  </div>
</div>

<!-- RESUMEN GENERAL -->
<div class="row g-3 mb-4">
  <div class="col-6 col-lg-2">
    <div class="custom-card card border-0 h-100">
      <div class="card-body p-3">
        <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">PRODUCTOS CONTADOS</small>
        <span id="rcTotalContados" class="fw-bold fs-5">2</span>
      </div>
    </div>
  </div>

  <div class="col-6 col-lg-2">
    <div class="custom-card card border-0 h-100">
      <div class="card-body p-3">
        <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">COINCIDENCIAS</small>
        <span id="rcTotalCorrectos" class="fw-bold fs-5" style="color:#22c55e;">1</span>
      </div>
    </div>
  </div>

  <div class="col-6 col-lg-2">
    <div class="custom-card card border-0 h-100">
      <div class="card-body p-3">
        <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">PRODUCTOS FALTANTES</small>
        <span id="rcTotalFaltantesProductos" class="fw-bold fs-5" style="color:#ef4444;">1</span>
      </div>
    </div>
  </div>

  <div class="col-6 col-lg-2">
    <div class="custom-card card border-0 h-100">
      <div class="card-body p-3">
        <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">UNIDADES FALTANTES</small>
        <span id="rcUnidadesFaltantes" class="fw-bold fs-5" style="color:#ef4444;">2</span>
      </div>
    </div>
  </div>

  <div class="col-6 col-lg-2">
    <div class="custom-card card border-0 h-100">
      <div class="card-body p-3">
        <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">UNIDADES SOBRANTES</small>
        <span id="rcUnidadesSobrantes" class="fw-bold fs-5" style="color:#eab308;">0</span>
      </div>
    </div>
  </div>

  <div class="col-6 col-lg-2">
    <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
      <div class="card-body p-3">
        <div class="kpi-decor bg-pink-light"></div>
        <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">PÉRDIDA VALORIZADA</small>
        <span id="rcValorPerdida" class="fw-bold fs-5 text-primary-custom">S/ 90.00</span>
      </div>
    </div>
  </div>
</div>

<!-- TABLA DE RESULTADOS -->
<div class="custom-card card border-0">
  <div class="card-body p-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h5 class="fw-bold title-font mb-0">Detalle comparativo</h5>
      <button type="button" class="btn btn-outline-secondary btn-sm fw-semibold">
        <i class="bi bi-download"></i> Exportar CSV
      </button>
    </div>

    <div class="table-responsive">
      <table class="table custom-table table-hover align-middle text-nowrap mb-0">
        <thead>
        <tr>
          <th>CÓDIGO</th>
          <th>PRODUCTO</th>
          <th>LÍNEA</th>
          <th>VENDEDOR</th>
          <th class="text-center">STOCK SISTEMA</th>
          <th class="text-center">CONTADO</th>
          <th class="text-center">DIFERENCIA</th>
          <th class="text-end">IMPACTO (S/)</th>
          <th>ESTADO</th>
          <th>FECHA CONTEO</th>
        </tr>
        </thead>
        <tbody id="rcTablaBody">
        <%
        List<Inventario> listaAuditoria = (List<Inventario>) request.getAttribute("auditoriaList");
          if (listaAuditoria != null && !listaAuditoria.isEmpty()) {
          for (Inventario inv : listaAuditoria) {
            String estadoTexto = (inv.getEstado() != null) ? inv.getEstado().name() : "";
            boolean esCorrecto = estadoTexto.equalsIgnoreCase("CORRECTO") || estadoTexto.equalsIgnoreCase("Correcto");
            String colorBadge = esCorrecto ? "#22c55e" : "#ef4444";
          %>
          <tr>
            <td class="text-muted"><%= inv.getCodigoBarras() %></td>
            <td class="fw-semibold"><%= inv.getProducto() %></td>
            <td><%= inv.getSede() %></td>
            <td><%= inv.getVendedor() %></td>
            <td class="text-center"><%= inv.getStockSistema() %></td>
            <td class="text-center fw-bold"><%= inv.getContado() %></td>
            <td class="text-center fw-bold" style="color: <%= colorBadge %>;"><%= inv.getDiferencia() %></td>
            <td class="text-end">S/ <%= String.format("%.2f", inv.getImpacto()) %></td>
            <td>
              <span class="badge" style="background-color: <%= colorBadge %>;">
                <%= inv.getEstado() %>
              </span>
            </td>
            <td class="text-muted"><%= inv.getFechaConteo() %></td>
          </tr>
          <%
          }
          } else {
          %>
          <tr>
            <td colspan="10" class="text-center text-muted py-3">No hay registros de auditoría disponibles.</td>
          </tr>
          <%
          }
          %>
        </tbody>
      </table>
    </div>
  </div>
</div>

</section>