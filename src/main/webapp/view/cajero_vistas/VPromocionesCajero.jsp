<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="esPromociones" value="${vistaActiva == 'promociones'}" />

<section id="view-promociones" class="view-section ${esPromociones ? 'active' : ''}">

  <!-- ENCABEZADO ADAPTABLE -->
  <div class="mb-4">
    <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">Promociones Disponibles</h3>
    <p class="mb-0 fs-6" style="color: var(--text-muted);">Conoce las promociones vigentes que puedes ofrecer a tus clientes durante las ventas.</p>
  </div>

  <!-- CONTENEDOR DE PROMOCIONES -->
  <div class="row g-4">

    <c:choose>
      <c:when test="${not empty promociones}">
        <c:forEach var="p" items="${promociones}">

          <!-- LÓGICA DE ÍCONOS DINÁMICOS BASADA EN EL NOMBRE -->
          <c:set var="nombreLower" value="${fn:toLowerCase(p.nombre())}" />
          <c:set var="iconClass" value="bi-tag-fill" />

          <c:choose>
            <c:when test="${fn:contains(nombreLower, 'descuento')}">
              <c:set var="iconClass" value="bi-percent" />
            </c:when>
            <c:when test="${fn:contains(nombreLower, 'combo')}">
              <c:set var="iconClass" value="bi-box-seam-fill" />
            </c:when>
            <c:when test="${fn:contains(nombreLower, 'frecuente')}">
              <c:set var="iconClass" value="bi-star-fill" />
            </c:when>
            <c:when test="${fn:contains(nombreLower, 'relámpago') or fn:contains(nombreLower, 'oferta')}">
              <c:set var="iconClass" value="bi-lightning-charge-fill" />
            </c:when>
            <c:when test="${fn:contains(nombreLower, 'promoción') or fn:contains(nombreLower, '2 + 1')}">
              <c:set var="iconClass" value="bi-cart-check" />
            </c:when>
          </c:choose>

          <!-- LÓGICA PARA BUSCAR EL NOMBRE DE LA SEDE EN LA LISTA DE SEDES -->
          <c:set var="nombreSede" value="Todas las sedes" />
          <c:if test="${p.sede() > 0}">
            <c:forEach var="s" items="${sedes}">
              <c:if test="${s.id == p.sede()}">
                <c:set var="nombreSede" value="${s.nombre}" />
              </c:if>
            </c:forEach>
          </c:if>

          <!-- LÓGICA DEL ESTADO (ENUM) Y COLORES DE BADGE -->
          <c:set var="nomEstado" value="${p.estado().name()}" />
          <c:set var="badgeColor" value="bg-success" />
          <c:set var="textoEstado" value="Activa" />

          <c:choose>
            <c:when test="${nomEstado == 'inactiva'}">
              <c:set var="badgeColor" value="bg-danger" />
              <c:set var="textoEstado" value="Inactiva" />
            </c:when>
            <c:when test="${nomEstado == 'por_vencer'}">
              <c:set var="badgeColor" value="bg-warning text-dark" />
              <c:set var="textoEstado" value="Por vencer" />
            </c:when>
            <c:when test="${nomEstado == 'programada'}">
              <c:set var="badgeColor" value="bg-info text-dark" />
              <c:set var="textoEstado" value="Programada" />
            </c:when>
          </c:choose>

          <!-- TARJETA DE PROMOCIÓN -->
          <div class="col-12 col-md-6 col-xl-4">
            <div class="card border-0 h-100 overflow-hidden shadow-sm" style="background-color: var(--card-bg); color: var(--text-color);">

              <!-- CABECERA VISUAL -->
              <div class="position-relative p-4"
                   style="background: ${not empty p.colorFondo() ? p.colorFondo() : 'var(--gradient-primary)'}; min-height: 150px;">

                <div class="d-flex justify-content-between align-items-start">
                  <span class="badge bg-white text-dark rounded-pill px-3 py-2 fw-semibold shadow-sm">
                      -${p.porcentajeDescuento()}% Dscto
                  </span>

                  <div class="bg-white bg-opacity-25 rounded-circle d-flex align-items-center justify-content-center"
                       style="width: 48px; height: 48px;">
                    <i class="bi ${iconClass} text-white fs-4"></i>
                  </div>
                </div>

                <div class="position-absolute bottom-0 start-0 p-4 text-white w-100" style="background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);">
                  <h4 class="fw-bold title-font mb-1 text-white">
                    ${p.nombre()}
                  </h4>
                  <div class="d-flex justify-content-between align-items-center">
                    <small class="text-white opacity-100 fw-semibold">
                      Sede: ${nombreSede}
                    </small>
                    <span class="badge ${badgeColor}">
                      ${textoEstado}
                    </span>
                  </div>
                </div>

              </div>

              <!-- CONTENIDO CON TEXTOS DINÁMICOS -->
              <div class="card-body p-4 d-flex flex-column">

                <!-- Usamos var(--text-color) con un peso equilibrado -->
                <p class="mb-4" style="color: var(--text-color); opacity: 0.85; font-size: 0.95rem;">
                  ${p.descripcion()}
                </p>

                <div class="mt-auto">
                  <div class="d-flex align-items-center gap-2 mb-2">
                    <i class="bi bi-calendar3 text-primary-custom"></i>
                    <span class="small fw-semibold" style="color: var(--text-color); opacity: 0.8;">
                          Vigencia: ${p.fechaInicio()} al ${p.fechaFin()}
                      </span>
                  </div>

                  <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-info-circle text-primary-custom"></i>
                    <span class="small" style="color: var(--text-color); opacity: 0.8;">
                          Aplica restricciones según sede.
                      </span>
                  </div>
                </div>

              </div>

            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <!-- ESTADO VACÍO -->
        <div class="col-12 text-center py-5">
          <i class="bi bi-tags text-muted" style="font-size: 3rem;"></i>
          <h5 class="mt-3 fw-bold" style="color: var(--text-color);">No hay promociones activas</h5>
          <p style="color: var(--text-muted);">Por el momento no hay promociones disponibles para mostrar.</p>
        </div>
      </c:otherwise>
    </c:choose>

  </div>

</section>