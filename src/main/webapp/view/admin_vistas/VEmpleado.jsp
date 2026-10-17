<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.liamyimport.model.dto.EmpleadoDTO" %>

<!-- CÁLCULO DE KPIs CON JSTL -->
<c:set var="totalEmpleados" value="${fn:length(empleados)}" />
<c:set var="activos" value="0" />
<c:set var="desactivados" value="0" />

<c:if test="${not empty empleados}">
  <c:forEach var="emp" items="${empleados}">
    <c:choose>
      <c:when test="${empty emp.fechaFin}">
        <c:set var="activos" value="${activos + 1}" />
      </c:when>
      <c:otherwise>
        <c:set var="desactivados" value="${desactivados + 1}" />
      </c:otherwise>
    </c:choose>
  </c:forEach>
</c:if>

<section id="view-empleados" class="view-section ${vistaActiva == 'empleados' ? 'active' : ''}">
  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1">Empleados</h3>
      <p class="text-muted mb-0">Administración de colaboradores</p>
    </div>
    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoEmpleadoModal">
      <i class="bi bi-plus-lg"></i> Nuevo empleado
    </button>
  </div>

  <!-- KPIs RÁPIDOS DINÁMICOS -->
  <div class="row g-3 mb-4">
    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL EMPLEADOS</small>
          <span class="fw-bold fs-5">${totalEmpleados}</span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">ACTIVOS</small>
          <span class="fw-bold fs-5" style="color:#22c55e;">${activos}</span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-4">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">DESACTIVADOS</small>
          <span class="fw-bold fs-5" style="color:#eab308;">${desactivados}</span>
        </div>
      </div>
    </div>
  </div>

  <!-- BUSCADOR -->
  <div class="custom-card card border-0 mb-4 p-3">
    <!-- Formulario adaptado para buscar mediante el servlet -->
    <form action="${pageContext.request.contextPath}/svempleado" method="GET" class="input-group" style="max-width: 400px;">
      <input type="text" name="criterio" class="form-control" placeholder="Buscar empleado por nombre o documento..." value="${param.criterio}">
      <button type="submit" class="btn btn-primary-custom">
        <i class="bi bi-search"></i>
      </button>
    </form>
  </div>

  <!-- TABLA DE EMPLEADOS -->
  <div class="custom-card card border-0">
    <div class="card-body p-4">
      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle mb-0 text-nowrap">
          <thead>
          <tr>
            <th>NOMBRE</th>
            <th>APELLIDO</th>
            <th>DOC.</th>
            <th>NÚMERO</th>
            <th>TELÉFONO</th>
            <th>DIRECCIÓN</th>
            <th>F. NACIMIENTO</th>
            <th>SALARIO</th>
            <th>INGRESO</th>
            <th>SALIDA</th>
            <th class="text-end">ACCIONES</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${not empty empleados}">
              <c:forEach var="emp" items="${empleados}">
                <tr>
                  <td class="fw-semibold">${emp.nombre}</td>
                  <td>${emp.apellido}</td>
                  <td><span class="badge bg-secondary">${emp.tipoDocumento}</span></td>
                  <td class="fw-bold text-primary-custom">${emp.numeroDocumento}</td>
                  <td>${emp.telefono}</td>
                  <td class="text-truncate" style="max-width: 150px;" title="${emp.direccion}">
                    ${not empty emp.direccion ? emp.direccion : '-'}
                  </td>
                  <td>${not empty emp.fechaNacimiento ? emp.fechaNacimiento : '-'}</td>
                  <td class="fw-semibold">
                    S/ <fmt:formatNumber value="${emp.salario}" pattern="#,##0.00"/>
                  </td>
                  <td>${not empty emp.fechaInicio ? emp.fechaInicio : '-'}</td>
                  <td>${not empty emp.fechaFin ? emp.fechaFin : '-'}</td>
                  <td class="text-end">
                    <!-- Nótese el uso de emp.idEmpleado para referenciar modales y operaciones -->
                    <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Editar" data-bs-toggle="modal" data-bs-target="#editarEmpleadoModal_${emp.idEmpleado}">
                      <i class="bi bi-pencil-square fs-5"></i>
                    </button>
                    <button type="button" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar" data-bs-toggle="modal" data-bs-target="#eliminarEmpleadoModal_${emp.idEmpleado}">
                      <i class="bi bi-trash fs-5"></i>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="11" class="text-center text-muted py-4">No hay empleados registrados todavía o no coinciden con la búsqueda.</td>
              </tr>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVO EMPLEADO -->
  <div class="modal fade" id="nuevoEmpleadoModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <form action="${pageContext.request.contextPath}/svempleado" method="POST">
          <input type="hidden" name="accion" value="crear">
          <div class="modal-header border-0 pb-0">
            <div>
              <h5 class="modal-title fw-bold title-font">Nuevo empleado</h5>
              <small class="text-muted">Ingresa los datos del nuevo colaborador</small>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                <input type="text" name="nombre" class="form-control" placeholder="Ej: Edu Jampier" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">APELLIDO</label>
                <input type="text" name="apellido" class="form-control" placeholder="Ej: Caceres Ruiz" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE DOCUMENTO</label>
                <select name="tipoDocumento" class="form-select" required>
                  <option value="" selected disabled>Selecciona tipo...</option>
                  <option value="DNI">DNI</option>
                  <option value="RUC">RUC</option>
                  <option value="PASAPORTE">Pasaporte</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NÚMERO DE DOCUMENTO</label>
                <input type="text" name="numeroDocumento" class="form-control" placeholder="Ej: 45782301" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
                <input type="text" name="telefono" class="form-control" placeholder="Ej: 987654321" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE NACIMIENTO</label>
                <input type="date" name="fechaNacimiento" class="form-control" required>
              </div>
              <div class="col-md-12">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
                <input type="text" name="direccion" class="form-control" placeholder="Av. Los Incas 123, Ica" required>
              </div>
              <hr class="my-2" style="border-color: var(--border-color);">
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SALARIO (S/)</label>
                <input type="number" step="0.01" name="salario" class="form-control" placeholder="1500" required>
              </div>
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE INGRESO</label>
                <input type="date" name="fechaInicio" class="form-control" required>
              </div>
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE SALIDA (OPCIONAL)</label>
                <input type="date" name="fechaFin" class="form-control">
              </div>
            </div>
          </div>
          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">
              <i class="bi bi-check2-circle"></i> Guardar empleado
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DE EDICIÓN Y ELIMINACIÓN -->
  <c:if test="${not empty empleados}">
    <c:forEach var="emp" items="${empleados}">

      <!-- MODAL: EDITAR EMPLEADO -->
      <div class="modal fade" id="editarEmpleadoModal_${emp.idEmpleado}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content custom-card border-0">
            <form action="${pageContext.request.contextPath}/svempleado" method="POST">
              <input type="hidden" name="accion" value="actualizar">
              <!-- El servlet espera el ID interno, no el número de documento -->
              <input type="hidden" name="idEmpleado" value="${emp.idEmpleado}">

              <div class="modal-header border-0 pb-0">
                <div>
                  <h5 class="modal-title fw-bold title-font">Editar empleado</h5>
                  <small class="text-muted">Modifica la información de: ${emp.nombre}</small>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>

              <div class="modal-body p-4">
                <div class="row g-3">
                  <div class="col-md-6">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                    <input type="text" name="nombre" class="form-control" value="${emp.nombre}" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">APELLIDO</label>
                    <input type="text" name="apellido" class="form-control" value="${emp.apellido}" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE DOCUMENTO</label>
                    <select name="tipoDocumento" class="form-select" required>
                      <option value="DNI" ${emp.tipoDocumento == 'DNI' ? 'selected' : ''}>DNI</option>
                      <option value="RUC" ${emp.tipoDocumento == 'RUC' ? 'selected' : ''}>RUC</option>
                      <option value="PASAPORTE" ${emp.tipoDocumento == 'PASAPORTE' ? 'selected' : ''}>Pasaporte</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NÚMERO DE DOCUMENTO</label>
                    <input type="text" name="numeroDocumento" class="form-control" value="${emp.numeroDocumento}" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
                    <input type="text" name="telefono" class="form-control" value="${emp.telefono}" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE NACIMIENTO</label>
                    <input type="date" name="fechaNacimiento" class="form-control" value="${emp.fechaNacimiento}">
                  </div>
                  <div class="col-md-12">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
                    <input type="text" name="direccion" class="form-control" value="${emp.direccion}" required>
                  </div>
                  <hr class="my-2" style="border-color: var(--border-color);">
                  <div class="col-md-4">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SALARIO (S/)</label>
                    <input type="number" step="0.01" name="salario" class="form-control" value="${emp.salario}" required>
                  </div>
                  <div class="col-md-4">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE INGRESO</label>
                    <input type="date" name="fechaInicio" class="form-control" value="${emp.fechaInicio}">
                  </div>
                  <div class="col-md-4">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA DE SALIDA (OPCIONAL)</label>
                    <input type="date" name="fechaFin" class="form-control" value="${emp.fechaFin}">
                  </div>
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
      <div class="modal fade" id="eliminarEmpleadoModal_${emp.idEmpleado}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content custom-card border-0">
            <div class="modal-body text-center p-4">
              <div class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width:60px;height:60px;background:rgba(220,53,69,.1);">
                <i class="bi bi-trash text-danger fs-4"></i>
              </div>
              <h5 class="fw-bold title-font">¿Eliminar empleado?</h5>
              <p class="text-muted mb-4">
                Estás a punto de eliminar a <strong>${emp.nombre} ${emp.apellido}</strong> (Doc: ${emp.numeroDocumento}).
                Esta operación es permanente.
              </p>
              <div class="d-flex justify-content-center gap-2">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <form action="${pageContext.request.contextPath}/svempleado" method="POST" style="margin:0;">
                  <input type="hidden" name="accion" value="eliminar">
                  <input type="hidden" name="idEmpleado" value="${emp.idEmpleado}">
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