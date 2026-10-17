<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="esPromocion" value="${vistaActiva == 'promociones'}" />

<section id="view-promociones" class="view-section ${esPromocion ? 'active' : ''}">

  <!-- ENCABEZADO -->
  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-3">
    <div>
      <div class="d-flex align-items-center gap-2 mb-1">
        <h3 class="fw-bold title-font mb-0">Gestión de Promociones</h3>
        <span class="badge rounded-pill px-3 py-2" style="background: rgba(34, 197, 94, 0.12); color: var(--primary-custom);">
            Administrador
        </span>
      </div>
      <p class="text-muted mb-0">Administra las promociones, descuentos y beneficios disponibles para los clientes.</p>
    </div>
    <button type="button" class="btn btn-primary-custom d-flex align-items-center gap-2 px-3 py-2" data-bs-toggle="modal" data-bs-target="#modalNuevaPromocion">
      <i class="bi bi-plus-lg"></i>
      <span>Nueva promoción</span>
    </button>
  </div>

  <!-- RESUMEN -->
  <div class="row g-3 mb-4">
    <div class="col-12 col-sm-6 col-xl-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-4">
          <div class="d-flex justify-content-between align-items-start">
            <div>
              <p class="text-muted small mb-1">Total promociones</p>
              <h3 class="fw-bold title-font mb-0"><c:out value="${not empty promociones ? promociones.size() : 0}" /></h3>
            </div>
            <div class="rounded-3 d-flex align-items-center justify-content-center" style="width:44px;height:44px;background:rgba(34,197,94,.12);">
              <i class="bi bi-megaphone text-primary-custom fs-5"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="col-12 col-sm-6 col-xl-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-4">
          <div class="d-flex justify-content-between align-items-start">
            <div>
              <p class="text-muted small mb-1">Promociones activas</p>
              <h3 class="fw-bold title-font mb-0">8</h3>
            </div>
            <div class="rounded-3 d-flex align-items-center justify-content-center" style="width:44px;height:44px;background:rgba(34,197,94,.12);">
              <i class="bi bi-check-circle text-success fs-5"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- LISTADO DE PROMOCIONES -->
  <div class="custom-card card border-0">
    <div class="card-body p-0">
      <div class="p-4 border-bottom">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
          <div>
            <h5 class="fw-bold title-font mb-1">Promociones registradas</h5>
            <p class="text-muted small mb-0">Gestiona las promociones disponibles en el sistema.</p>
          </div>
          <span class="text-muted small">Mostrando <c:out value="${not empty promociones ? promociones.size() : 0}" /> promociones</span>
        </div>
      </div>

      <!-- TARJETAS DINÁMICAS -->
      <div class="p-4">
        <div class="row g-4">

          <c:choose>
            <c:when test="${not empty promociones}">
              <c:forEach var="p" items="${promociones}">

                <c:set var="nomEstado" value="${p.estado().name()}" />
                <c:set var="badgeClase" value="bg-success" />
                <c:set var="textoEstado" value="Activa" />

                <c:choose>
                  <c:when test="${nomEstado == 'por_vencer'}">
                    <c:set var="badgeClase" value="bg-warning text-dark" />
                    <c:set var="textoEstado" value="Por vencer" />
                  </c:when>
                  <c:when test="${nomEstado == 'inactiva'}">
                    <c:set var="badgeClase" value="bg-secondary" />
                    <c:set var="textoEstado" value="Inactiva" />
                  </c:when>
                  <c:when test="${nomEstado == 'programada'}">
                    <c:set var="badgeClase" value="bg-info text-dark" />
                    <c:set var="textoEstado" value="Programada" />
                  </c:when>
                </c:choose>

                <!-- LÓGICA PARA MOSTRAR EL NOMBRE DE LA SEDE EN LA TARJETA -->
                <c:set var="nombreSede" value="Todas las sedes" />
                <c:if test="${p.sede() > 0}">
                  <c:forEach var="s" items="${sedes}">
                    <c:if test="${s.id == p.sede()}">
                      <c:set var="nombreSede" value="${s.nombre}" />
                    </c:if>
                  </c:forEach>
                </c:if>

                <!-- Tarjeta Principal Adaptada a Modo Oscuro -->
                <div class="col-12 col-md-6 col-xl-4">
                  <div class="custom-card card border-0 h-100 overflow-hidden shadow-sm">

                    <!-- Contenido Superior -->
                    <div class="position-relative p-4" style="background:${p.colorFondo()};min-height:145px;">
                      <div class="d-flex justify-content-between align-items-start">
                        <span class="badge bg-white text-dark rounded-pill px-3 py-2 fw-bold shadow-sm">
                            -${p.porcentajeDescuento()}% Dscto
                        </span>
                        <span class="badge ${badgeClase} rounded-pill shadow-sm">${textoEstado}</span>
                      </div>
                      <div class="position-absolute bottom-0 start-0 p-4 text-white">
                        <h5 class="fw-bold title-font text-white mb-1">${p.nombre()}</h5>
                        <small class="text-white opacity-75">${nombreSede}</small>
                      </div>
                    </div>

                    <!-- Contenido Inferior -->
                    <div class="card-body p-4">
                      <p class="text-muted small mb-4">${p.descripcion()}</p>
                      <div class="small text-muted mb-2">
                        <i class="bi bi-calendar3 me-2"></i> ${p.fechaInicio()} - ${p.fechaFin()}
                      </div>
                      <div class="small text-muted mb-3">
                        <i class="bi bi-shop me-2"></i> ${nombreSede}
                      </div>
                      <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                        <!-- Botón para abrir el Modal de Edición -->
                        <button type="button" class="btn btn-sm btn-outline-secondary" title="Editar" data-bs-toggle="modal" data-bs-target="#modalEditarPromocion_${p.idPromocion()}">
                          <i class="bi bi-pencil"></i>
                        </button>

                        <!-- Botón para abrir el Modal de Eliminar -->
                        <button type="button" class="btn btn-sm btn-outline-danger" title="Eliminar" data-bs-toggle="modal" data-bs-target="#modalEliminarPromocion_${p.idPromocion()}">
                          <i class="bi bi-trash"></i>
                        </button>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- MODAL DE EDICIÓN -->
                <div class="modal fade" id="modalEditarPromocion_${p.idPromocion()}" tabindex="-1" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content custom-card border-0">
                      <form action="${pageContext.request.contextPath}/svpromocion" method="POST">
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="id" value="${p.idPromocion()}">

                        <div class="modal-header border-0">
                          <div>
                            <h5 class="modal-title fw-bold title-font">Editar promoción</h5>
                            <p class="text-muted small mb-0">Actualiza los datos de esta promoción.</p>
                          </div>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>

                        <div class="modal-body p-4">
                          <div class="row g-3">
                            <div class="col-12">
                              <label class="form-label fw-semibold">Nombre de la promoción</label>
                              <input type="text" name="nombre" class="form-control" value="${p.nombre()}" required>
                            </div>

                            <div class="col-md-4">
                              <label class="form-label fw-semibold">Descuento (%)</label>
                              <input type="number" step="0.01" name="porcentajeDescuento" class="form-control" value="${p.porcentajeDescuento()}" required>
                            </div>

                            <div class="col-md-4">
                              <label class="form-label fw-semibold">Color de Fondo</label>
                              <select name="colorFondo" class="form-select">
                                <option value="linear-gradient(135deg, #475569, #1e293b)" ${p.colorFondo() == 'linear-gradient(135deg, #475569, #1e293b)' ? 'selected' : ''}>Oscuro</option>
                                <option value="linear-gradient(135deg, #ef4444, #991b1b)" ${p.colorFondo() == 'linear-gradient(135deg, #ef4444, #991b1b)' ? 'selected' : ''}>Rojo Promoción</option>
                                <option value="linear-gradient(135deg, #3b82f6, #1d4ed8)" ${p.colorFondo() == 'linear-gradient(135deg, #3b82f6, #1d4ed8)' ? 'selected' : ''}>Azul Oferta</option>
                                <option value="linear-gradient(135deg, #10b981, #047857)" ${p.colorFondo() == 'linear-gradient(135deg, #10b981, #047857)' ? 'selected' : ''}>Verde Especial</option>
                                <option value="linear-gradient(135deg, #f59e0b, #b45309)" ${p.colorFondo() == 'linear-gradient(135deg, #f59e0b, #b45309)' ? 'selected' : ''}>Naranja Flash</option>
                              </select>
                            </div>

                            <div class="col-md-4">
                              <label class="form-label fw-semibold">Aplicación (Sede)</label>
                              <select name="sede" class="form-select">
                                <option value="0" ${p.sede() == 0 ? 'selected' : ''}>Todas las sedes</option>
                                <c:if test="${not empty sedes}">
                                  <c:forEach var="s" items="${sedes}">
                                    <option value="${s.id}" ${p.sede() == s.id ? 'selected' : ''}>
                                    ${s.nombre}
                                    </option>
                                  </c:forEach>
                                </c:if>
                              </select>
                            </div>

                            <div class="col-md-6">
                              <label class="form-label fw-semibold">Fecha de inicio</label>
                              <input type="date" name="fechaInicio" class="form-control" value="${p.fechaInicio()}" required>
                            </div>

                            <div class="col-md-6">
                              <label class="form-label fw-semibold">Fecha de finalización</label>
                              <input type="date" name="fechaFin" class="form-control" value="${p.fechaFin()}" required>
                            </div>

                            <div class="col-12">
                              <label class="form-label fw-semibold">Descripción</label>
                              <textarea name="descripcion" class="form-control" rows="4" required>${p.descripcion()}</textarea>
                            </div>

                            <div class="col-12">
                              <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="promocionActiva" id="promocionActiva_${p.idPromocion()}" ${nomEstado == 'activa' ? 'checked' : ''}>
                                <label class="form-check-label fw-semibold" for="promocionActiva_${p.idPromocion()}">Activar promoción</label>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="modal-footer border-0">
                          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                          <button type="submit" class="btn btn-primary-custom">
                            <i class="bi bi-check-lg me-1"></i> Guardar cambios
                          </button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>

                <!-- MODAL DE CONFIRMACIÓN DE ELIMINACIÓN -->
                <div class="modal fade" id="modalEliminarPromocion_${p.idPromocion()}" tabindex="-1" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content custom-card border-0">
                      <div class="modal-header border-0 pb-0">
                        <h5 class="modal-title fw-bold title-font text-danger">Confirmar Eliminación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                      </div>

                      <div class="modal-body p-4 text-center">
                        <i class="bi bi-exclamation-triangle-fill text-danger mb-3" style="font-size: 3rem;"></i>
                        <h5 class="mb-2">¿Eliminar promoción?</h5>
                        <p class="text-muted mb-0">Estás a punto de eliminar la promoción <strong>${p.nombre()}</strong>. Esta acción no se puede deshacer.</p>
                      </div>

                      <div class="modal-footer border-0 pt-0 justify-content-center">
                        <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
                        <form action="${pageContext.request.contextPath}/svpromocion" method="POST" class="m-0 p-0">
                          <input type="hidden" name="accion" value="eliminar">
                          <input type="hidden" name="id" value="${p.idPromocion()}">
                          <button type="submit" class="btn btn-danger fw-bold" style="background-color: #ef4444; border-color: #ef4444;">
                            <i class="bi bi-trash"></i> Sí, eliminar
                          </button>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>

              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="col-12 text-center text-muted py-5">
                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                No hay promociones registradas.
              </div>
            </c:otherwise>
          </c:choose>

        </div>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVA PROMOCIÓN -->
  <div class="modal fade" id="modalNuevaPromocion" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <form action="${pageContext.request.contextPath}/svpromocion" method="POST">
          <input type="hidden" name="accion" value="crear">

          <div class="modal-header border-0">
            <div>
              <h5 class="modal-title fw-bold title-font">Nueva promoción</h5>
              <p class="text-muted small mb-0">Registra una nueva promoción para los clientes.</p>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-12">
                <label class="form-label fw-semibold">Nombre de la promoción</label>
                <input type="text" name="nombre" class="form-control" placeholder="Ej. Black Friday" required>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Descuento (%)</label>
                <input type="number" step="0.01" name="porcentajeDescuento" class="form-control" placeholder="Ej. 20.5" required>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Color de Fondo</label>
                <select name="colorFondo" class="form-select">
                  <option value="linear-gradient(135deg, #475569, #1e293b)" selected>Oscuro (Por defecto)</option>
                  <option value="linear-gradient(135deg, #ef4444, #991b1b)">Rojo Promoción</option>
                  <option value="linear-gradient(135deg, #3b82f6, #1d4ed8)">Azul Oferta</option>
                  <option value="linear-gradient(135deg, #10b981, #047857)">Verde Especial</option>
                  <option value="linear-gradient(135deg, #f59e0b, #b45309)">Naranja Flash</option>
                </select>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Aplicación (Sede)</label>
                <select name="sede" class="form-select">
                  <option value="0" selected>Todas las sedes</option>
                  <c:if test="${not empty sedes}">
                    <c:forEach var="s" items="${sedes}">
                      <option value="${s.id}">${s.nombre}</option>
                    </c:forEach>
                  </c:if>
                </select>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Fecha de inicio</label>
                <input type="date" name="fechaInicio" class="form-control" required>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Fecha de finalización</label>
                <input type="date" name="fechaFin" class="form-control" required>
              </div>

              <div class="col-12">
                <label class="form-label fw-semibold">Descripción</label>
                <textarea name="descripcion" class="form-control" rows="4" placeholder="Describe las condiciones..." required></textarea>
              </div>

              <div class="col-12">
                <div class="form-check form-switch">
                  <input class="form-check-input" type="checkbox" name="promocionActiva" id="promocionActivaNueva" checked>
                  <label class="form-check-label fw-semibold" for="promocionActivaNueva">Activar promoción inmediatamente</label>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer border-0">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom">
              <i class="bi bi-check-lg me-1"></i> Crear promoción
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>