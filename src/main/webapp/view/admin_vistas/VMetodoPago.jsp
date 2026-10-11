<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="esMetodosPago" value="${vistaActiva == 'metodospago'}" />

<section id="view-metodospago" class="view-section ${esMetodosPago ? 'active' : ''}">

  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1">Métodos de Pago</h3>
      <p class="text-muted mb-0">Gestión de formas de pago aceptadas en el negocio.</p>
    </div>

    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoMetodoModal">
      <i class="bi bi-plus-lg"></i>
      Nuevo método
    </button>
  </div>

  <!-- KPIs RÁPIDOS -->
  <div class="row g-3 mb-4">
    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">MÉTODOS REGISTRADOS</small>
          <span class="fw-bold fs-5 text-primary-custom"><c:out value="${not empty metodos ? metodos.size() : 0}"/></span>
        </div>
      </div>
    </div>

    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">MÉTODOS ACTIVOS</small>
          <span class="fw-bold fs-5" style="color:#22c55e;">Todos</span>
        </div>
      </div>
    </div>
  </div>

  <!-- BUSCADOR -->
  <div class="custom-card card border-0 mb-4 p-3">
    <form action="${pageContext.request.contextPath}/svmetodopago" method="GET" class="input-group" style="max-width: 400px;">
      <input type="text" name="criterio" id="metodoBuscador" class="form-control" placeholder="Buscar método de pago..." value="${param.criterio}">
      <button type="submit" class="btn btn-primary-custom">
        <i class="bi bi-search"></i>
      </button>
    </form>
  </div>

  <!-- TABLA DE MÉTODOS DE PAGO -->
  <div class="custom-card card border-0">
    <div class="card-body p-4">
      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle mb-0">
          <thead>
          <tr>
            <th>ID</th>
            <th>MÉTODO DE PAGO</th>
            <th class="text-center">ESTADO</th>
            <th class="text-end">ACCIONES</th>
          </tr>
          </thead>
          <tbody>

          <c:choose>
            <c:when test="${not empty metodos}">
              <c:forEach var="mp" items="${metodos}">

                <c:set var="isActivo" value="${mp.estado().name() == 'activo' or mp.estado().name() == 'ACTIVO'}" />

                <tr>
                  <!-- Usando id_metodo_pago() según tu record -->
                  <td class="text-muted fw-semibold">#${mp.id_metodo_pago()}</td>
                  <!-- CORREGIDO: Se quitó text-dark y se agregó style="color: var(--text-color);" -->
                  <td class="fw-bold" style="color: var(--text-color);">
                    <i class="bi bi-credit-card-2-front me-2 text-primary-custom"></i>
                    ${mp.nombre()}
                  </td>
                  <td class="text-center">
                    <span class="badge border ${isActivo ? 'bg-success bg-opacity-10 text-success border-success' : 'bg-danger bg-opacity-10 text-danger border-danger'}">
                      ${fn:toUpperCase(mp.estado().name())}
                    </span>
                  </td>
                  <td class="text-end">
                    <!-- Botón Editar -->
                    <button type="button" class="btn btn-link text-primary-custom p-0 me-3" title="Editar" data-bs-toggle="modal" data-bs-target="#modalEditarMetodo_${mp.id_metodo_pago()}">
                      <i class="bi bi-pencil-square fs-5"></i>
                    </button>
                    <!-- Botón Eliminar -->
                    <button type="button" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar" data-bs-toggle="modal" data-bs-target="#modalEliminarMetodo_${mp.id_metodo_pago()}">
                      <i class="bi bi-trash fs-5"></i>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="4" class="text-center text-muted py-4">
                  <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                  No hay métodos de pago registrados.
                </td>
              </tr>
            </c:otherwise>
          </c:choose>

          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVO MÉTODO -->
  <div class="modal fade" id="nuevoMetodoModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content custom-card border-0">
        <form action="${pageContext.request.contextPath}/svmetodopago" method="POST">
          <input type="hidden" name="accion" value="crear">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold title-font">Nuevo Método de Pago</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="mb-3">
              <label for="nmNombre" class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE DEL MÉTODO</label>
              <input type="text" id="nmNombre" name="nombre" class="form-control" placeholder="Ej: Tarjeta de Crédito, Yape..." required>
            </div>
            <div class="mb-0">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
              <select name="estado" class="form-select">
                <option value="ACTIVO" selected>Activo</option>
                <option value="INACTIVO">Inactivo</option>
              </select>
            </div>
          </div>

          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">
              <i class="bi bi-check2-circle"></i> Guardar método
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DINÁMICOS DE EDICIÓN Y ELIMINACIÓN -->
  <c:if test="${not empty metodos}">
    <c:forEach var="mp" items="${metodos}">

      <c:set var="isActivo" value="${mp.estado().name() == 'activo' or mp.estado().name() == 'ACTIVO'}" />

      <!-- MODAL: EDITAR MÉTODO -->
      <div class="modal fade" id="modalEditarMetodo_${mp.id_metodo_pago()}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0">
            <form action="${pageContext.request.contextPath}/svmetodopago" method="POST">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="id" value="${mp.id_metodo_pago()}">
              <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold title-font">Editar Método de Pago</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>

              <div class="modal-body p-4">
                <div class="mb-3">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE DEL MÉTODO</label>
                  <input type="text" name="nombre" class="form-control" value="${mp.nombre()}" required>
                </div>
                <div class="mb-0">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
                  <select name="estado" class="form-select">
                    <option value="ACTIVO" ${isActivo ? 'selected' : ''}>Activo</option>
                    <option value="INACTIVO" ${!isActivo ? 'selected' : ''}>Inactivo</option>
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

      <!-- MODAL: ELIMINAR MÉTODO -->
      <div class="modal fade" id="modalEliminarMetodo_${mp.id_metodo_pago()}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0">
            <div class="modal-header border-0 pb-0">
              <h5 class="modal-title fw-bold title-font text-danger">Confirmar Eliminación</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4 text-center">
              <i class="bi bi-exclamation-triangle-fill text-danger mb-3" style="font-size: 3rem;"></i>
              <h5 class="mb-2">¿Eliminar método de pago?</h5>
              <p class="text-muted mb-0">Estás a punto de eliminar el método <strong>${mp.nombre()}</strong>. Esta acción no se puede deshacer.</p>
            </div>

            <div class="modal-footer border-0 pt-0 justify-content-center">
              <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
              <form action="${pageContext.request.contextPath}/svmetodopago" method="POST" class="m-0 p-0">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="id" value="${mp.id_metodo_pago()}">
                <button type="submit" class="btn btn-danger fw-bold" style="background-color: #ef4444; border-color: #ef4444;">
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