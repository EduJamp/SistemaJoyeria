<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.liamyimport.model.dto.InventarioDTO" %>

<c:set var="esConteo" value="${vistaActiva == 'conteo-productos'}" />

<!-- CÁLCULO DE KPIs DINÁMICOS CON JSTL -->
<c:set var="totalProductos" value="${fn:length(listaInventario)}" />
<c:set var="contados" value="0" />
<c:set var="unidadesTotales" value="0" />

<c:if test="${not empty listaInventario}">
    <c:forEach var="inv" items="${listaInventario}">
        <c:if test="${not empty inv.fechaConteo and inv.fechaConteo ne '-'}">
            <c:set var="contados" value="${contados + 1}" />
        </c:if>
        <c:set var="unidadesTotales" value="${unidadesTotales + inv.stockFisico}" />
    </c:forEach>
</c:if>

<c:set var="pendientes" value="${totalProductos - contados}" />

<section id="view-conteo-productos" class="view-section ${esConteo ? 'active' : ''}">

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
            ${contados} de ${totalProductos} productos contados
        </span>
    </div>

    <!-- FILTROS -->
    <div class="custom-card card border-0 mb-4 p-3">
        <form action="${pageContext.request.contextPath}/svinventario" method="GET" class="row g-3 align-items-end">
            <div class="col-md-9">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                    BUSCAR PRODUCTO
                </label>
                <div class="input-group">
                    <input type="text" name="criterio" class="form-control" placeholder="Nombre o código de barras..." value="${param.criterio}">
                    <button type="submit" class="btn btn-primary-custom">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </div>
            <div class="col-md-3">
                <a href="${pageContext.request.contextPath}/svinventario" class="btn btn-outline-secondary w-100 fw-semibold">
                    <i class="bi bi-arrow-counterclockwise"></i> Limpiar
                </a>
            </div>
        </form>
    </div>

    <!-- RESUMEN DEL CONTEO -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-lg-4">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">PRODUCTOS CONTADOS</small>
                    <span id="resumenContados" class="fw-bold fs-5" style="color: var(--text-color);">${contados} / ${totalProductos}</span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-4">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">UNIDADES REGISTRADAS</small>
                    <span id="resumenUnidades" class="fw-bold fs-5" style="color: var(--text-color);">${unidadesTotales}</span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-4">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="fw-bold d-block mb-1" style="font-size: 0.65rem; color: var(--text-color); opacity: 0.7;">PENDIENTES</small>
                    <span id="resumenPendientes" class="fw-bold fs-5" style="color:#eab308;">${pendientes}</span>
                </div>
            </div>
        </div>
    </div>

    <!-- TABLA KARDEX DE CONTEO -->
    <div class="custom-card card border-0">
        <div class="card-body p-4">

            <form action="${pageContext.request.contextPath}/svinventario" method="POST">
                <!-- Acción mapeada al método guardarConteoMasivo del servlet SvInventario -->
                <input type="hidden" name="accion" value="guardarConteo">

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
                        <c:choose>
                            <c:when test="${not empty listaInventario}">
                                <c:forEach var="inv" items="${listaInventario}">
                                    <tr class="fila-conteo">
                                        <td style="color: var(--text-color);">${not empty inv.codigoBarras ? inv.codigoBarras : '-'}</td>
                                        <td class="fw-semibold" style="color: var(--text-color);">${not empty inv.nombreProducto ? inv.nombreProducto : 'Producto #' += inv.idProducto}</td>
                                        <td style="color: var(--text-color); opacity: 0.8;">${not empty inv.nombreSede ? inv.nombreSede : 'Sede Principal'}</td>
                                        <td class="text-center fw-bold" style="color: var(--text-color);">${inv.stockSistema}</td>
                                        <td class="text-center">
                                            <!-- El input se genera dinámicamente con el ID del producto para ser capturado en el servlet -->
                                            <input type="number"
                                                   name="contado_${inv.idProducto}"
                                                   class="form-control text-center input-conteo"
                                                   min="0"
                                                   value="${inv.stockFisico > 0 ? inv.stockFisico : ''}"
                                                   placeholder="Cantidad...">
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="text-center py-4" style="color: var(--text-color); opacity: 0.7;">No hay registros de inventario disponibles.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </form>

        </div>
    </div>

</section>