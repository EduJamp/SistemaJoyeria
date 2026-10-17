<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.liamyimport.model.dto.EmpleadoDTO" %>
<%@ page import="com.liamyimport.model.dto.UsuarioDTO" %>

<!-- CÁLCULO DE KPIS CON JSTL -->
<c:set var="totalUsers" value="${fn:length(usuarios)}" />
<c:set var="totalAdmins" value="0" />
<c:set var="totalVendedores" value="0" />
<c:set var="totalCajeros" value="0" />

<c:if test="${not empty usuarios}">
  <c:forEach var="u" items="${usuarios}">
    <c:if test="${not empty u.rol}">
      <c:set var="rolStr" value="${fn:toUpperCase(u.rol)}" />
      <c:choose>
        <c:when test="${fn:contains(rolStr, 'ADMIN')}">
          <c:set var="totalAdmins" value="${totalAdmins + 1}" />
        </c:when>
        <c:when test="${fn:contains(rolStr, 'VENDEDOR')}">
          <c:set var="totalVendedores" value="${totalVendedores + 1}" />
        </c:when>
        <c:when test="${fn:contains(rolStr, 'CAJERO')}">
          <c:set var="totalCajeros" value="${totalCajeros + 1}" />
        </c:when>
      </c:choose>
    </c:if>
  </c:forEach>
</c:if>

<section id="view-usuarios" class="view-section ${vistaActiva == 'usuarios' ? 'active' : ''}">

  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1">Usuarios</h3>
      <p class="text-muted mb-0">Administración de usuarios del sistema.</p>
    </div>
    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoUsuarioModal">
      <i class="bi bi-plus-lg"></i> Nuevo usuario
    </button>
  </div>

  <!-- KPIs RÁPIDOS -->
  <div class="row g-3 mb-4">
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL USUARIOS</small>
          <span class="fw-bold fs-5">${totalUsers}</span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">ADMINISTRADORES</small>
          <span class="fw-bold fs-5">${totalAdmins}</span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">VENDEDORES</small>
          <span class="fw-bold fs-5">${totalVendedores}</span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">CAJEROS</small>
          <span class="fw-bold fs-5">${totalCajeros}</span>
        </div>
      </div>
    </div>
  </div>

  <!-- FILTROS -->
  <div class="custom-card card border-0 mb-4 p-3">
    <form action="${pageContext.request.contextPath}/svusuario" method="GET" class="row g-3 align-items-end">
      <div class="col-md-8">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">BUSCAR</label>
        <div class="input-group">
          <input type="text" name="criterio" class="form-control" placeholder="Usuario o nombre del empleado..." value="${param.criterio}">
          <button type="submit" class="btn btn-primary-custom"><i class="bi bi-search"></i></button>
        </div>
      </div>
      <div class="col-md-4">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ROL</label>
        <select class="form-select">
          <option value="">Todos</option>
          <option>Administrador</option>
          <option>Vendedor</option>
          <option>Cajero</option>
        </select>
      </div>
    </form>
  </div>

  <!-- TABLA DE USUARIOS -->
  <div class="custom-card card border-0">
    <div class="card-body p-4">
      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle mb-0">
          <thead>
          <tr>
            <th>USUARIO</th>
            <th>EMPLEADO ASOCIADO</th>
            <th>ROL</th>
            <th class="text-end">ACCIONES</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${not empty usuarios}">
              <c:forEach var="u" items="${usuarios}">
                <!-- Generación segura de iniciales y nombre de empleado con EL -->
                <c:set var="username" value="${u.nombreUsuario}" />
                <c:set var="iniciales" value="${fn:length(username) >= 2 ? fn:toUpperCase(fn:substring(username, 0, 2)) : 'US'}" />

                <c:set var="nombreEmpleado" value="Sin empleado asociado" />
                <c:if test="${not empty u.empleado}">
                  <c:set var="nombreEmpleado" value="${u.empleado.nombre} ${u.empleado.apellido}" />
                </c:if>

                <c:set var="badgeBg" value="#4b5563" />
                <c:set var="rolName" value="SIN ROL" />
                <c:if test="${not empty u.rol}">
                  <c:set var="rolName" value="${u.rol}" />
                  <c:if test="${fn:contains(fn:toUpperCase(rolName), 'ADMIN')}">
                    <c:set var="badgeBg" value="var(--primary-custom)" />
                  </c:if>
                  <c:if test="${fn:contains(fn:toUpperCase(rolName), 'CAJERO')}">
                    <c:set var="badgeBg" value="#eab308" />
                  </c:if>
                </c:if>

                <c:set var="modalId" value="${fn:replace(fn:replace(username, '.', '_'), '@', '_')}" />

                <tr>
                  <td>
                    <div class="d-flex align-items-center gap-2">
                      <span class="avatar" style="width:32px; height:32px; min-width:32px; font-size:0.8rem;">${iniciales}</span>
                      <span class="fw-semibold">${username}</span>
                    </div>
                  </td>
                  <td>${nombreEmpleado}</td>
                  <td>
                    <span class="badge" style="background-color: ${badgeBg};">${rolName}</span>
                  </td>
                  <td class="text-end">
                    <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Editar" data-bs-toggle="modal" data-bs-target="#editarUsuarioModal_${modalId}">
                      <i class="bi bi-pencil-square fs-5"></i>
                    </button>
                    <button type="button" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar" data-bs-toggle="modal" data-bs-target="#eliminarUsuarioModal_${modalId}">
                      <i class="bi bi-trash fs-5"></i>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="4" class="text-center text-muted py-4">No hay usuarios registrados todavía o no coinciden con la búsqueda.</td>
              </tr>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVO USUARIO -->
  <div class="modal fade" id="nuevoUsuarioModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content custom-card border-0">
        <form action="${pageContext.request.contextPath}/svusuario" method="POST">
          <input type="hidden" name="accion" value="crear">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold title-font">Nuevo usuario</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body p-4">
            <div class="mb-3">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">EMPLEADO ASOCIADO</label>
              <!-- Selector actualizado usando EmpleadoDTO -->
              <select name="idEmpleado" class="form-select" required>
                <option value="" selected disabled>Selecciona un empleado...</option>
                <c:choose>
                  <c:when test="${not empty empleados}">
                    <c:forEach var="emp" items="${empleados}">
                      <option value="${emp.idEmpleado}">${emp.nombre} ${emp.apellido} (Doc: ${emp.numeroDocumento})</option>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <option value="" disabled>No hay empleados registrados</option>
                  </c:otherwise>
                </c:choose>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE DE USUARIO</label>
              <input type="text" name="nombreUsuario" class="form-control" placeholder="Ej: rosa.f" required>
            </div>
            <div class="mb-3">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ROL</label>
              <select name="rol" class="form-select" required>
                <option value="" selected disabled>Selecciona un rol...</option>
                <option value="ADMINISTRADOR">Administrador</option>
                <option value="VENDEDOR">Vendedor</option>
                <option value="CAJERO">Cajero</option>
              </select>
            </div>
            <div class="mb-0">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CONTRASEÑA</label>
              <div class="input-group">
                <input type="password" id="nuNuevaPassword" name="password" class="form-control" placeholder="Mínimo 8 caracteres" required minlength="8">
                <button type="button" class="btn btn-outline-secondary btn-toggle-pass" data-target="nuNuevaPassword" title="Mostrar/ocultar">
                  <i class="bi bi-eye"></i>
                </button>
              </div>
            </div>
          </div>
          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">
              <i class="bi bi-check2-circle"></i> Crear usuario
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DE EDICIÓN Y ELIMINACIÓN -->
  <c:if test="${not empty usuarios}">
    <c:forEach var="u" items="${usuarios}">
      <c:set var="modalId" value="${fn:replace(fn:replace(u.nombreUsuario, '.', '_'), '@', '_')}" />
      <c:set var="rolActual" value="${not empty u.rol ? u.rol : 'VENDEDOR'}" />
      <c:set var="docEmpleadoActual" value="${not empty u.empleado ? u.empleado.idEmpleado : 0}" />
      <c:set var="passwordActual" value="${not empty u.password ? u.password : ''}" />

      <!-- MODAL: EDITAR USUARIO -->
      <div class="modal fade" id="editarUsuarioModal_${modalId}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0">
            <form action="${pageContext.request.contextPath}/svusuario" method="POST">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="idUsuario" value="${u.idUsuario}">

              <div class="modal-header border-0 pb-0">
                <div>
                  <h5 class="modal-title fw-bold title-font">Editar usuario</h5>
                  <small class="text-muted">Modifica los datos de: ${u.nombreUsuario}</small>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>

              <div class="modal-body p-4">
                <div class="mb-3">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">EMPLEADO ASOCIADO</label>
                  <select name="idEmpleado" class="form-select" required>
                    <option value="" disabled>Selecciona un empleado...</option>
                    <c:if test="${not empty empleados}">
                      <c:forEach var="emp" items="${empleados}">
                        <option value="${emp.idEmpleado}" ${emp.idEmpleado == docEmpleadoActual ? 'selected' : ''}>
                        ${emp.nombre} ${emp.apellido} (Doc: ${emp.numeroDocumento})
                        </option>
                      </c:forEach>
                    </c:if>
                  </select>
                </div>

                <div class="mb-3">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE DE USUARIO</label>
                  <input type="text" class="form-control" name="nombreUsuario" value="${u.nombreUsuario}" required>
                </div>

                <div class="mb-4">
                  <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ROL</label>
                  <select name="rol" class="form-select" required>
                    <option value="ADMINISTRADOR" ${fn:contains(rolActual, 'ADMIN') ? 'selected' : ''}>Administrador</option>
                    <option value="VENDEDOR" ${fn:contains(rolActual, 'VENDEDOR') ? 'selected' : ''}>Vendedor</option>
                    <option value="CAJERO" ${fn:contains(rolActual, 'CAJERO') ? 'selected' : ''}>Cajero</option>
                  </select>
                </div>

                <hr style="border-color: var(--border-color);">

                <label class="form-label text-muted fw-bold mb-2" style="font-size: 0.75rem;">CONTRASEÑA</label>
                <div class="input-group">
                  <input type="password" id="euPassword_${modalId}" name="password" class="form-control" value="${passwordActual}" required minlength="8">
                  <button type="button" class="btn btn-outline-secondary btn-toggle-pass" data-target="euPassword_${modalId}" title="Mostrar/ocultar">
                    <i class="bi bi-eye"></i>
                  </button>
                </div>
              </div>

              <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-outline-secondary fw-semibold me-auto" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary-custom fw-bold">
                  <i class="bi bi-check2-circle"></i> Guardar cambios
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- MODAL: CONFIRMAR ELIMINACIÓN -->
      <div class="modal fade" id="eliminarUsuarioModal_${modalId}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0">
            <div class="modal-body text-center p-4">
              <div class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width:60px;height:60px;background:rgba(220,53,69,.1);">
                <i class="bi bi-trash text-danger fs-4"></i>
              </div>
              <h5 class="fw-bold title-font">¿Eliminar usuario?</h5>
              <p class="text-muted mb-4">
                Estás a punto de eliminar al usuario <strong>${u.nombreUsuario}</strong>.
                Esta operación es permanente y no se puede deshacer.
              </p>
              <div class="d-flex justify-content-center gap-2">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <form action="${pageContext.request.contextPath}/svusuario" method="POST" style="margin:0;">
                  <input type="hidden" name="accion" value="eliminar">
                  <input type="hidden" name="idUsuario" value="${u.idUsuario}">
                  <button type="submit" class="btn btn-danger">
                    <i class="bi bi-trash me-1"></i> Eliminar
                  </button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>

    </c:forEach>
  </c:if>
</section>