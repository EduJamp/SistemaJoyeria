<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.liamyimport.model.dto.InventarioDTO" %>

<c:set var="esAuditoria" value="${vistaActiva == 'conteo-productos' or vistaActiva == 'auditoria-inventario'}" />

<section id="view-auditoria-inventario" class="view-section ${esAuditoria ? 'active' : ''}">

  <div class="mb-4">
    <h3 class="fw-bold title-font mb-1">
      Resultados de Conteo
    </h3>
    <p class="text-muted">
      Compara el conteo físico registrado por los colaboradores contra el stock del sistema.
    </p>
  </div>

  <!-- FILTROS (Apunta correctamente a /svauditoriainventario) -->
  <div class="custom-card card border-0 mb-4 p-3">
    <form action="${pageContext.request.contextPath}/svauditoriainventario" method="GET" class="row g-3 align-items-end">
      <div class="col-md-9">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">BUSCAR PRODUCTO O ESTADO</label>
        <div class="input-group">
          <input type="text" name="criterio" class="form-control" placeholder="Buscar por estado o detalles..." value="${param.criterio}">
          <button type="submit" class="btn btn-primary-custom">
            <i class="bi bi-search"></i>
          </button>
        </div>
      </div>
      <div class="col-md-3">
        <a href="${pageContext.request.contextPath}/svauditoriainventario" class="btn btn-outline-secondary w-100 fw-semibold">
          <i class="bi bi-arrow-counterclockwise"></i> Limpiar filtros
        </a>
      </div>
    </form>
  </div>

  <!-- RESUMEN GENERAL (KPIs Dinámicos basados en auditoriaList) -->
  <c:set var="totalContados" value="${fn:length(auditoriaList)}" />
  <c:set var="coincidencias" value="0" />
  <c:set var="productosFaltantes" value="0" />
  <c:set var="unidadesFaltantes" value="0" />
  <c:set var="unidadesSobrantes" value="0" />
  <c:set var="perdidaValorizada" value="0.0" />

  <c:if test="${not empty auditoriaList}">
    <c:forEach var="inv" items="${auditoriaList}">
      <c:choose>
        <c:when test="${inv.stockFisico eq inv.stockSistema}">
          <c:set var="coincidencias" value="${coincidencias + 1}" />
        </c:when>
        <c:when test="${inv.stockFisico lt inv.stockSistema}">
          <c:set var="productosFaltantes" value="${productosFaltantes + 1}" />
          <c:set var="dif" value="${inv.stockSistema - inv.stockFisico}" />
          <c:set var="unidadesFaltantes" value="${unidadesFaltantes + dif}" />
        </c:when>
        <c:otherwise>
          <c:set var="difS" value="${inv.stockFisico - inv.stockSistema}" />
          <c:set var="unidadesSobrantes" value="${unidadesSobrantes + difS}" />
        </c:otherwise>
      </c:choose>
      <c:set var="perdidaValorizada" value="${perdidaValorizada + inv.impacto}" />
    </c:forEach>
  </c:if>

  <div class="row g-3 mb-4">
    <div class="col-6 col-lg-2">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">PRODUCTOS CONTADOS</small>
          <span class="fw-bold fs-5">${totalContados}</span>
        </div>
      </div>
    </div>

    <div class="col-6 col-lg-2">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">COINCIDENCIAS</small>
          <span class="fw-bold fs-5" style="color:#22c55e;">${coincidencias}</span>
        </div>
      </div>
    </div>

    <div class="col-6 col-lg-2">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">PRODUCTOS FALTANTES</small>
          <span class="fw-bold fs-5" style="color:#ef4444;">${productosFaltantes}</span>
        </div>
      </div>
    </div>

    <div class="col-6 col-lg-2">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">UNIDADES FALTANTES</small>
          <span class="fw-bold fs-5" style="color:#ef4444;">${unidadesFaltantes}</span>
        </div>
      </div>
    </div>

    <div class="col-6 col-lg-2">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">UNIDADES SOBRANTES</small>
          <span class="fw-bold fs-5" style="color:#eab308;">${unidadesSobrantes}</span>
        </div>
      </div>
    </div>

    <div class="col-6 col-lg-2">
      <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
        <div class="card-body p-3">
          <div class="kpi-decor bg-pink-light"></div>
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">PÉRDIDA VALORIZADA</small>
          <span class="fw-bold fs-5 text-primary-custom">S/ <fmt:formatNumber value="${perdidaValorizada}" pattern="#,##0.00"/></span>
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
            <th>SEDE</th>
            <th>RESPONSABLE</th>
            <th class="text-center">STOCK SISTEMA</th>
            <th class="text-center">CONTADO</th>
            <th class="text-center">DIFERENCIA</th>
            <th class="text-end">IMPACTO (S/)</th>
            <th>ESTADO</th>
            <th>FECHA CONTEO</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${not empty auditoriaList}">
              <c:forEach var="inv" items="${auditoriaList}">
                <c:set var="diferencia" value="${inv.stockFisico - inv.stockSistema}" />
                <c:set var="esCorrecto" value="${diferencia == 0}" />
                <c:set var="colorBadge" value="${esCorrecto ? '#22c55e' : '#ef4444'}" />

                <tr>
                  <td class="text-muted">${not empty inv.codigoBarras ? inv.codigoBarras : '-'}</td>
                  <td class="fw-semibold">${not empty inv.nombreProducto ? inv.nombreProducto : 'Producto #' += inv.idProducto}</td>
                  <td>${not empty inv.nombreSede ? inv.nombreSede : 'Sede Principal'}</td>
                  <td>${not empty inv.nombreEmpleado ? inv.nombreEmpleado : 'Sistema'}</td>
                  <td class="text-center">${inv.stockSistema}</td>
                  <td class="text-center fw-bold">${inv.stockFisico}</td>
                  <td class="text-center fw-bold" style="color: ${colorBadge};">
                    ${diferencia > 0 ? '+' += diferencia : diferencia}
                  </td>
                  <td class="text-end">
                    S/ <fmt:formatNumber value="${inv.impacto}" pattern="#,##0.00"/>
                  </td>
                  <td>
                    <span class="badge" style="background-color: ${colorBadge};">
                      ${not empty inv.estado ? inv.estado : (esCorrecto ? 'CORRECTO' : 'DESVIACIÓN')}
                    </span>
                  </td>
                  <td class="text-muted">${not empty inv.fechaConteo ? inv.fechaConteo : '-'}</td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="10" class="text-center text-muted py-3">No hay registros de auditoría o inventario disponibles.</td>
              </tr>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>

</section>