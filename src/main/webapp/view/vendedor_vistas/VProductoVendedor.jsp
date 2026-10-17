<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Producto" %>
<%
String vistaActivaProd = (String) request.getAttribute("vistaActiva");
boolean esProductosProd = "productos".equals(vistaActivaProd);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<section id="view-productos" class="view-section ${vistaActiva == 'productos' ? 'active' : ''}">

  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">
        Productos
      </h3>
      <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">
        Consulta el catálogo de bijouterie y su disponibilidad en almacén.
      </p>
    </div>
  </div>

  <!-- FILTROS Y BUSCADOR -->
  <div class="custom-card card border-0 mb-4 p-3">
    <div class="row g-3 align-items-end">
      <div class="col-md-6">
        <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
          BUSCAR PRODUCTO
        </label>
        <form action="${pageContext.request.contextPath}/svproducto" method="GET" class="input-group">
          <input type="text" name="criterio" class="form-control" placeholder="Nombre o código de barras..." value="${param.criterio}">
          <button type="submit" class="btn btn-primary-custom">
            <i class="bi bi-search"></i>
          </button>
        </form>
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
    <c:choose>
      <c:when test="${not empty productos}">
        <c:forEach var="p" items="${productos}">
          <c:set var="stockColor" value="${p.cantidad > 5 ? '#22c55e' : '#eab308'}" />
          <c:set var="nombreCategoria" value="${not empty p.categoria.nombre ? p.categoria.nombre : 'Categoría ID: ' += p.categoria.id}" />

          <div class="col-sm-6 col-lg-4 col-xl-3">
            <div class="custom-card card border-0 h-100">
              <div class="d-flex align-items-center justify-content-center" style="height: 160px; background-color: var(--bg-primary); border-radius: 16px 16px 0 0;">
                <i class="bi bi-gem" style="font-size: 2.5rem; color: var(--text-color); opacity: 0.5;"></i>
              </div>
              <div class="card-body p-3">
                <span class="badge bg-pink-light text-primary-custom mb-2" style="font-size: 0.65rem;">
                    ${nombreCategoria}
                </span>
                <h6 class="fw-bold mb-1" style="color: var(--text-color);">
                  ${p.nombre}
                </h6>
                <small class="d-block mb-2" style="color: var(--text-color); opacity: 0.7;">
                  Cód. barras: ${p.codigoBarras}
                </small>
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <span class="fw-bold text-primary-custom fs-6">
                        S/ <fmt:formatNumber value="${p.precioUnidad}" pattern="#,##0.00"/>
                    </span>
                  <span class="badge" style="background-color: ${stockColor}; color: #000;">
                        ${p.cantidad} en stock
                    </span>
                </div>

                <div class="d-flex gap-2">
                  <button type="button" class="btn btn-outline-secondary w-100 fw-semibold" data-bs-toggle="modal" data-bs-target="#productoModal_${p.id}">
                    <i class="bi bi-eye"></i> Ver detalle
                  </button>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="col-12 text-center py-5">
          <p style="color: var(--text-color); opacity: 0.7;">No hay productos registrados todavía o no coinciden con la búsqueda.</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- MODAL DE DETALLE (ÚNICO MODAL PERMITIDO PARA VER) -->
  <c:if test="${not empty productos}">
    <c:forEach var="p" items="${productos}">
      <c:set var="nombreCategoria" value="${not empty p.categoria.nombre ? p.categoria.nombre : 'Categoría ID: ' += p.categoria.id}" />
      <c:set var="descripcion" value="${not empty p.descripcion ? p.descripcion : 'Sin descripción disponible para este producto.'}" />

      <div class="modal fade" id="productoModal_${p.id}" tabindex="-1" aria-hidden="true">
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
                  <span class="badge bg-pink-light text-primary-custom mb-2">${nombreCategoria}</span>
                  <h4 class="fw-bold title-font mb-2" style="color: var(--text-color);">${p.nombre}</h4>
                  <p class="mb-3" style="font-size: 0.9rem; color: var(--text-color); opacity: 0.8;">${descripcion}</p>
                  <div class="row g-3">
                    <div class="col-6">
                      <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">PRECIO UNIDAD</small>
                      <span class="fw-bold fs-5 text-primary-custom">S/ <fmt:formatNumber value="${p.precioUnidad}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="col-6">
                      <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">STOCK DISPONIBLE</small>
                      <span class="fw-bold fs-5" style="color: var(--text-color);">${p.cantidad} unidades</span>
                    </div>
                    <div class="col-6">
                      <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">ESTADO</small>
                      <span class="fw-semibold" style="color: var(--text-color);">${not empty p.estado ? p.estado : 'N/A'}</span>
                    </div>
                    <div class="col-6">
                      <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">PRECIO PAQUETE</small>
                      <span class="fw-semibold" style="color: var(--text-color);">S/ <fmt:formatNumber value="${p.precioPaquete}" pattern="#,##0.00"/></span>
                    </div>
                  </div>
                  <hr style="border-color: var(--border-color);">
                  <small class="fw-bold d-block mb-2" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">CÓDIGO DE BARRAS</small>
                  <div class="d-inline-block px-3 py-2" style="background:var(--bg-primary); border-radius:10px;">
                    <span class="fw-bold" style="color: var(--text-color);">${p.codigoBarras}</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer border-0 pt-0">
              <button type="button" class="btn btn-primary-custom fw-bold" data-bs-dismiss="modal">Cerrar</button>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
  </c:if>

</section>