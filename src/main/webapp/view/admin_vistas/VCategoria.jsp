<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="esCategorias" value="${vistaActiva == 'categorias'}" />

<section id="view-categorias" class="view-section ${esCategorias ? 'active' : ''}">

  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1">Categorías</h3>
      <p class="text-muted mb-0">Gestión de categorías de productos.</p>
    </div>

    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevaCategoriaModal">
      <i class="bi bi-plus-lg"></i>
      Nueva categoría
    </button>
  </div>

  <!-- KPIs RÁPIDOS -->
  <div class="row g-3 mb-4">
    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL CATEGORÍAS</small>
          <span class="fw-bold fs-5">4</span>
        </div>
      </div>
    </div>

    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">CON PRODUCTOS</small>
          <span class="fw-bold fs-5" style="color:#22c55e;">3</span>
        </div>
      </div>
    </div>

    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">SIN PRODUCTOS</small>
          <span class="fw-bold fs-5" style="color:#eab308;">1</span>
        </div>
      </div>
    </div>
  </div>

  <!-- BUSCADOR -->
  <div class="custom-card card border-0 mb-4 p-3">
    <form action="${pageContext.request.contextPath}/svcategoria" method="GET" class="input-group" style="max-width: 400px;">
      <input type="text" name="criterio" id="categoriaBuscador" class="form-control" placeholder="Buscar categorías..." value="${param.criterio}">
      <button type="submit" class="btn btn-primary-custom">
        <i class="bi bi-search"></i>
      </button>
    </form>
  </div>

  <!-- TABLA DE CATEGORÍAS -->
  <div class="custom-card card border-0">
    <div class="card-body p-4">
      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle mb-0">
          <thead>
          <tr>
            <th>ID</th>
            <th>NOMBRE</th>
            <th>DESCRIPCIÓN</th>
            <th class="text-center">N° PRODUCTOS</th>
            <th class="text-end">ACCIONES</th>
          </tr>
          </thead>
          <tbody>

          <c:choose>
            <c:when test="${not empty categorias}">
              <c:forEach var="cat" items="${categorias}">
                <tr>
                  <td class="text-muted">${cat.id()}</td>
                  <td class="fw-semibold">${cat.nombre()}</td>
                  <td class="text-muted">${empty cat.descripcion() ? 'Sin descripción' : cat.descripcion()}</td>
                  <td class="text-center fw-bold">0</td>
                  <td class="text-end">
                    <!-- Botón Editar -->
                    <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Editar" data-bs-toggle="modal" data-bs-target="#modalEditarCat_${cat.id()}">
                      <i class="bi bi-pencil-square fs-5"></i>
                    </button>
                    <!-- Botón Eliminar -->
                    <button type="button" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar" data-bs-toggle="modal" data-bs-target="#modalEliminarCat_${cat.id()}">
                      <i class="bi bi-trash fs-5"></i>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="5" class="text-center text-muted py-3">No hay categorías registradas.</td>
              </tr>
            </c:otherwise>
          </c:choose>

          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVA CATEGORÍA -->
  <div class="modal fade" id="nuevaCategoriaModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content custom-card border-0">
        <form action="${pageContext.request.contextPath}/svcategoria" method="POST">
          <input type="hidden" name="accion" value="crear">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold title-font">Nueva categoría</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="mb-3">
              <label for="ncName" class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
              <input type="text" id="ncName" name="nombre" class="form-control" placeholder="Ej: Pulseras" required>
            </div>

            <div class="mb-0">
              <label for="ncDescripcion" class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DESCRIPCIÓN</label>
              <textarea id="ncDescripcion" name="descripcion" class="form-control" rows="3" placeholder="Breve descripción de la categoría..."></textarea>
            </div>
          </div>

          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">
              <i class="bi bi-check2-circle"></i> Guardar categoría
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DINÁMICOS DE EDICIÓN Y ELIMINACIÓN -->
  <c:if test="${not empty categorias}">
    <c:forEach var="cat" items="${categorias}">

      <!-- MODAL: EDITAR CATEGORÍA -->
      <div class="modal fade" id="modalEditarCat_${cat.id()}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0">
            <form action="${pageContext.request.contextPath}/svcategoria" method="POST">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="id" value="${cat.id()}">
              <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold title-font">Editar categoría</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>

              <div class="modal-body p-4">
                <div class="mb-3">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                  <input type="text" name="nombre" class="form-control" value="${cat.nombre()}" required>
                </div>

                <div class="mb-0">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DESCRIPCIÓN</label>
                  <textarea name="descripcion" class="form-control" rows="3">${cat.descripcion()}</textarea>
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

      <!-- MODAL: ELIMINAR CATEGORÍA -->
      <div class="modal fade" id="modalEliminarCat_${cat.id()}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0">
            <div class="modal-header border-0 pb-0">
              <h5 class="modal-title fw-bold title-font text-danger">Confirmar Eliminación</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4 text-center">
              <i class="bi bi-exclamation-triangle-fill text-danger mb-3" style="font-size: 3rem;"></i>
              <h5 class="mb-2">¿Eliminar categoría?</h5>
              <p class="text-muted mb-0">Estás a punto de eliminar la categoría <strong>${cat.nombre()}</strong>. Esta acción no se puede deshacer.</p>
            </div>

            <div class="modal-footer border-0 pt-0 justify-content-center">
              <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
              <form action="${pageContext.request.contextPath}/svcategoria" method="POST" class="m-0 p-0">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="id" value="${cat.id()}">
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