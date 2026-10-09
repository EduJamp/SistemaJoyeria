<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<section id="view-sedes" class="view-section ${vistaActiva == 'sedes' ? 'active' : ''}">

  <div class="mb-4">
    <h3 class="fw-bold title-font mb-1">
      Sedes
    </h3>
    <p class="text-muted">
      Administración de las sedes de Liamy Import.
    </p>
  </div>

  <div class="custom-card card border-0">
    <div class="card-body p-4">

      <!-- CABECERA: Barra de Búsqueda convertida en Formulario -->
      <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">

        <form action="${pageContext.request.contextPath}/svsede" method="GET" class="input-group search-wrapper" style="max-width: 400px;">
          <!-- value="${param.criterio}" mantiene el texto escrito después de buscar -->
          <input type="text" name="criterio" class="form-control" placeholder="Buscar sedes..." value="${param.criterio}">
          <button type="submit" class="btn btn-primary-custom px-3">
            <i class="bi bi-search"></i>
          </button>
        </form>

        <button type="button" class="btn btn-primary-custom fw-semibold" data-bs-toggle="modal" data-bs-target="#nuevaSedeModal">
          <i class="bi bi-plus-lg me-1"></i>
          Nuevo
        </button>
      </div>

      <!-- TABLA -->
      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle text-nowrap mb-0">
          <thead>
          <tr>
            <th>Principal</th>
            <th>Nombre <i class="bi bi-arrow-down-up ms-1 text-muted"></i></th>
            <th>Dirección <i class="bi bi-arrow-down-up ms-1 text-muted"></i></th>
            <th>Ciudad <i class="bi bi-arrow-down-up ms-1 text-muted"></i></th>
            <th>Teléfono <i class="bi bi-arrow-down-up ms-1 text-muted"></i></th>
            <th>Estado</th>
            <th class="text-end">Acciones</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${not empty sedesList}">
              <c:forEach var="s" items="${sedesList}">

                <c:set var="nombreEstado" value="${s.estado.name()}" />
                <c:set var="isActivo" value="${nombreEstado == 'ACTIVO' or nombreEstado == 'activo' or nombreEstado == 'Activo'}" />
                <c:set var="colorBadge" value="${isActivo ? '#22c55e' : '#ef4444'}" />

                <tr>
                  <td>
                    <c:choose>
                      <c:when test="${s.esPrincipal}">
                        <span class="badge bg-pink-light text-primary-custom">Sí</span>
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted">No</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="fw-semibold">${s.nombre}</td>
                  <td class="text-muted">${s.direccion}</td>
                  <td>${s.ciudad}</td>
                  <td>${empty s.telefono ? '-' : s.telefono}</td>
                  <td>
                  <span class="badge" style="background-color: ${colorBadge};">
                    ${nombreEstado}
                  </span>
                  </td>
                  <td class="text-end">
                    <!-- Botón Editar abre modal dinámico -->
                    <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Editar" data-bs-toggle="modal" data-bs-target="#modalEditarSede_${s.id}">
                      <i class="bi bi-pencil-square fs-5"></i>
                    </button>

                    <!-- NUEVO Botón Eliminar: Abre el Modal de confirmación en lugar del alert -->
                    <button type="button" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar" data-bs-toggle="modal" data-bs-target="#modalEliminarSede_${s.id}">
                      <i class="bi bi-trash fs-5"></i>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="7" class="text-center py-5">
                  <div class="d-flex flex-column align-items-center justify-content-center text-muted">
                    <i class="bi bi-inbox fs-1 mb-2"></i>
                    <h6 class="fw-semibold mb-0">No hay registros disponibles</h6>
                    <small>No se encontraron datos para mostrar en esta tabla.</small>
                  </div>
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>

    </div>
  </div>

  <!-- MODAL: NUEVA SEDE (Se mantiene igual) -->
  <div class="modal fade" id="nuevaSedeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content custom-card border-0">
        <form action="${pageContext.request.contextPath}/svsede" method="POST">
          <input type="hidden" name="accion" value="crear">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold title-font">Nueva Sede</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="mb-3">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
              <input type="text" name="nombre" class="form-control" placeholder="Ej: Sede Norte" required>
            </div>
            <div class="mb-3">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
              <input type="text" name="direccion" class="form-control" placeholder="Ej: Av. Los Pinos 123" required>
            </div>
            <div class="mb-3">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CIUDAD</label>
              <input type="text" name="ciudad" class="form-control" placeholder="Ej: Chimbote" required>
            </div>
            <div class="mb-3">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
              <input type="text" name="telefono" class="form-control" placeholder="Ej: 987654321">
            </div>
            <div class="mb-3 form-check">
              <input type="checkbox" name="esPrincipal" value="true" class="form-check-input" id="checkPrincipal">
              <label class="form-check-label fw-semibold" for="checkPrincipal" style="font-size: 0.85rem;">¿Es sede principal?</label>
            </div>
            <div class="mb-0">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
              <select name="estado" class="form-select" required>
                <option value="Activo">Activo</option>
                <option value="Inactivo">Inactivo</option>
              </select>
            </div>
          </div>

          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">
              <i class="bi bi-check2-circle"></i> Guardar sede
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DINÁMICOS: EDICIÓN Y ELIMINACIÓN -->
  <c:if test="${not empty sedesList}">
    <c:forEach var="s" items="${sedesList}">

      <c:set var="nombreEstadoEdit" value="${s.estado.name()}" />
      <c:set var="isActivoEdit" value="${nombreEstadoEdit == 'ACTIVO' or nombreEstadoEdit == 'activo' or nombreEstadoEdit == 'Activo'}" />

      <!-- MODAL EDITAR SEDE -->
      <div class="modal fade" id="modalEditarSede_${s.id}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0">
            <form action="${pageContext.request.contextPath}/svsede" method="POST">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="id" value="${s.id}">
              <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold title-font">Editar Sede</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>

              <div class="modal-body p-4">
                <div class="mb-3">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                  <input type="text" name="nombre" class="form-control" value="${s.nombre}" required>
                </div>
                <div class="mb-3">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
                  <input type="text" name="direccion" class="form-control" value="${s.direccion}" required>
                </div>
                <div class="mb-3">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CIUDAD</label>
                  <input type="text" name="ciudad" class="form-control" value="${s.ciudad}" required>
                </div>
                <div class="mb-3">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
                  <input type="text" name="telefono" class="form-control" value="${s.telefono}">
                </div>
                <div class="mb-3 form-check">
                  <input type="checkbox" name="esPrincipal" value="true" class="form-check-input" id="checkPrincipal_${s.id}" ${s.esPrincipal ? 'checked' : ''}>
                  <label class="form-check-label fw-semibold" for="checkPrincipal_${s.id}" style="font-size: 0.85rem;">¿Es sede principal?</label>
                </div>
                <div class="mb-0">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
                  <select name="estado" class="form-select" required>
                    <option value="Activo" ${isActivoEdit ? 'selected' : ''}>Activo</option>
                    <option value="Inactivo" ${not isActivoEdit ? 'selected' : ''}>Inactivo</option>
                  </select>
                </div>
              </div>

              <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary-custom fw-bold">
                  <i class="bi bi-check2-circle"></i> Guardar cambios
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- NUEVO MODAL: CONFIRMAR ELIMINACIÓN -->
      <div class="modal fade" id="modalEliminarSede_${s.id}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0 text-center">

            <div class="modal-header border-0 pb-0 justify-content-end">
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4 pt-2">
              <i class="bi bi-exclamation-circle text-danger mb-3" style="font-size: 3.5rem;"></i>
              <h4 class="fw-bold mb-2 text-white">¿Eliminar sede?</h4>
              <p class="text-muted mb-0">Estás a punto de eliminar <strong>${s.nombre}</strong>. Esta acción es permanente y no se puede deshacer.</p>
            </div>

            <div class="modal-footer border-0 pt-0 justify-content-center gap-2 pb-4">
              <button type="button" class="btn btn-outline-secondary fw-semibold px-4" data-bs-dismiss="modal">Cancelar</button>

              <!-- Formulario encapsulado dentro del botón del modal -->
              <form action="${pageContext.request.contextPath}/svsede" method="POST" class="m-0 p-0">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="id" value="${s.id}">
                <button type="submit" class="btn btn-danger fw-bold px-4" style="background-color: #ef4444; border-color: #ef4444;">
                  <i class="bi bi-trash"></i> Sí, eliminar
                </button>
              </form>
            </div>

          </div>
        </div>
      </div>

    </c:forEach>
  </c:if>

</section>