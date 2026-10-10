<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="esClientes" value="${vistaActiva == 'clientes'}" />

<section id="view-clientes_view" class="view-section ${esClientes ? 'active' : ''}">

  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">

    <div>
      <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">
        Clientes
      </h3>
      <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">
        Consulta el historial y los datos de contacto de tus clientes.
      </p>
    </div>

    <!-- Botón Nuevo Cliente -->
    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoClienteModal">
      <i class="bi bi-plus-lg"></i> Nuevo cliente
    </button>

  </div>

  <!-- BUSCADOR (Convertido en formulario para que funcione el Servlet) -->
  <div class="custom-card card border-0 mb-4 p-3" style="background-color: var(--card-bg); color: var(--text-color);">
    <form action="${pageContext.request.contextPath}/svcliente" method="GET" class="input-group" style="max-width: 400px;">
      <input type="text" name="criterio" id="clientesBuscador" class="form-control" placeholder="Buscar por nombre, DNI/RUC o teléfono..." value="${param.criterio}" style="background-color: transparent; color: var(--text-color); border-color: var(--border-color);">
      <button type="submit" class="btn btn-primary-custom">
        <i class="bi bi-search"></i>
      </button>
    </form>
  </div>

  <!-- TABLA DE CLIENTES -->
  <div class="custom-card card border-0" style="background-color: var(--card-bg); color: var(--text-color);">

    <div class="card-body p-4">

      <div class="table-responsive">

        <table class="table custom-table table-hover align-middle text-nowrap mb-0" style="color: var(--text-color);">

          <thead>
          <tr style="color: var(--text-color); opacity: 0.8;">
            <th>CLIENTE</th>
            <th>DOC. IDENTIDAD</th>
            <th>TELÉFONO</th>
            <th>TIPO CLIENTE</th>
            <th class="text-center">N° COMPRAS</th>
            <th>TOTAL COMPRADO</th>
            <th class="text-end">ACCIÓN</th>
          </tr>
          </thead>

          <tbody>

          <c:choose>
            <c:when test="${not empty clientes}">
              <c:forEach var="c" items="${clientes}">

                <!-- Generación de Nombre Completo -->
                <c:set var="nombreCompleto" value="${fn:trim(c.nombre.concat(' ').concat(not empty c.apellido ? c.apellido : ''))}" />

                <!-- Lógica de Iniciales replicada en JSTL -->
                <c:set var="iniNom1" value="${not empty c.nombre ? fn:substring(c.nombre, 0, 1) : ''}" />
                <c:set var="iniNom2" value="${fn:length(c.nombre) > 1 ? fn:substring(c.nombre, 1, 2) : ''}" />
                <c:set var="iniApe" value="${not empty c.apellido ? fn:substring(c.apellido, 0, 1) : ''}" />

                <c:choose>
                  <c:when test="${not empty c.nombre and not empty c.apellido}">
                    <c:set var="iniciales" value="${fn:toUpperCase(iniNom1)}${fn:toUpperCase(iniApe)}" />
                  </c:when>
                  <c:when test="${not empty c.nombre and empty c.apellido and fn:length(c.nombre) > 1}">
                    <c:set var="iniciales" value="${fn:toUpperCase(iniNom1)}${fn:toUpperCase(iniNom2)}" />
                  </c:when>
                  <c:when test="${not empty c.nombre}">
                    <c:set var="iniciales" value="${fn:toUpperCase(iniNom1)}" />
                  </c:when>
                  <c:otherwise>
                    <c:set var="iniciales" value="CL" />
                  </c:otherwise>
                </c:choose>

                <tr>
                  <td>
                    <div class="d-flex align-items-center gap-2">
                      <span class="avatar d-flex align-items-center justify-content-center fw-bold" style="width:32px; height:32px; min-width:32px; font-size:0.8rem; background: var(--primary-custom); color:#fff; border-radius:50%;">${iniciales}</span>
                      <span class="fw-semibold" style="color: var(--text-color);">${nombreCompleto}</span>
                    </div>
                  </td>
                  <td style="color: var(--text-color);">
                    ${c.numeroDocumento}
                    <span class="badge bg-secondary ms-1" style="font-size:0.6rem;">${c.tipoDocumento}</span>
                  </td>
                  <td style="color: var(--text-color);">${empty c.telefono or c.telefono == '0' ? '-' : c.telefono}</td>
                  <td>
                    <span class="badge bg-light text-dark border">${not empty c.tipoCliente ? fn:toUpperCase(c.tipoCliente) : 'NATURAL'}</span>
                  </td>

                  <!-- Datos calculados por el DAO -->
                  <td class="text-center fw-bold" style="color: var(--text-color);">${c.numeroCompras}</td>
                  <td class="fw-bold text-primary-custom">
                    <fmt:formatNumber value="${c.totalComprado}" type="currency" currencySymbol="S/ "/>
                  </td>

                  <td class="text-end">
                    <!-- Vinculado dinámicamente con el documento -->
                    <button type="button" class="btn btn-link text-primary-custom p-0" title="Ver detalle" data-bs-toggle="modal" data-bs-target="#clienteModal_${c.numeroDocumento}">
                      <i class="bi bi-eye fs-5"></i>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="7" class="text-center py-4" style="color: var(--text-color); opacity: 0.7;">
                  No hay clientes registrados aún.
                </td>
              </tr>
            </c:otherwise>
          </c:choose>

          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- MODAL: NUEVO CLIENTE (Conectado con el doPost de SvCliente) -->
  <div class="modal fade" id="nuevoClienteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0" style="background-color: var(--card-bg); color: var(--text-color);">
        <form action="${pageContext.request.contextPath}/svcliente" method="POST">
          <input type="hidden" name="accion" value="crear">

          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold title-font" style="color: var(--text-color);">Registrar Cliente</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">TIPO DE CLIENTE</label>
                <select name="tipoCliente" class="form-select" required>
                  <option value="natural" selected>Natural</option>
                  <option value="empresa">Empresa</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">TIPO DE DOCUMENTO</label>
                <select name="tipoDocumento" class="form-select" required>
                  <option value="DNI" selected>DNI</option>
                  <option value="RUC">RUC</option>
                  <option value="CE">Carné de extranjería</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">NÚMERO DE DOCUMENTO</label>
                <input type="number" name="numeroDocumento" class="form-control" required>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">NOMBRE COMPLETO / RAZÓN SOCIAL</label>
                <input type="text" name="nombre" class="form-control" placeholder="Ej: Edu Caceres" required>
              </div>
              <div class="col-md-4">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">TELÉFONO</label>
                <input type="number" name="telefono" class="form-control" required>
              </div>
              <div class="col-md-8">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">CORREO ELECTRÓNICO</label>
                <input type="email" name="correo" class="form-control" required>
              </div>
              <div class="col-md-12">
                <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">DIRECCIÓN</label>
                <input type="text" name="direccion" class="form-control" required>
              </div>
            </div>
          </div>

          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-bold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">Guardar Cliente</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- MODALES DE DETALLE DINÁMICOS -->
  <c:if test="${not empty clientes}">
    <c:forEach var="c" items="${clientes}">

      <!-- Replicamos la lógica de iniciales y nombres para el modal -->
      <c:set var="nombreCompleto" value="${fn:trim(c.nombre.concat(' ').concat(not empty c.apellido ? c.apellido : ''))}" />
      <c:set var="iniNom1" value="${not empty c.nombre ? fn:substring(c.nombre, 0, 1) : ''}" />
      <c:set var="iniNom2" value="${fn:length(c.nombre) > 1 ? fn:substring(c.nombre, 1, 2) : ''}" />
      <c:set var="iniApe" value="${not empty c.apellido ? fn:substring(c.apellido, 0, 1) : ''}" />

      <c:choose>
        <c:when test="${not empty c.nombre and not empty c.apellido}">
          <c:set var="iniciales" value="${fn:toUpperCase(iniNom1)}${fn:toUpperCase(iniApe)}" />
        </c:when>
        <c:when test="${not empty c.nombre and empty c.apellido and fn:length(c.nombre) > 1}">
          <c:set var="iniciales" value="${fn:toUpperCase(iniNom1)}${fn:toUpperCase(iniNom2)}" />
        </c:when>
        <c:when test="${not empty c.nombre}">
          <c:set var="iniciales" value="${fn:toUpperCase(iniNom1)}" />
        </c:when>
        <c:otherwise>
          <c:set var="iniciales" value="CL" />
        </c:otherwise>
      </c:choose>

      <div class="modal fade" id="clienteModal_${c.numeroDocumento}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content custom-card border-0" style="background-color: var(--card-bg); color: var(--text-color);">

            <div class="modal-header border-0 pb-0">
              <h5 class="modal-title fw-bold title-font" style="color: var(--text-color);">Detalle del cliente</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4">

              <div class="d-flex align-items-center gap-3 mb-4">
                <span class="avatar d-flex align-items-center justify-content-center fw-bold" style="width:56px; height:56px; min-width:56px; font-size:1.3rem; background: var(--primary-custom); color:#fff; border-radius:50%;">${iniciales}</span>
                <div>
                  <h4 class="fw-bold title-font mb-0" style="color: var(--text-color);">${nombreCompleto}</h4>
                  <small style="color: var(--text-color); opacity: 0.7;">Tipo: ${not empty c.tipoCliente ? fn:toUpperCase(c.tipoCliente) : 'NATURAL'}</small>
                </div>
              </div>

              <div class="row g-3 mb-4">
                <div class="col-md-3">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">${c.tipoDocumento}</small>
                  <span class="fw-semibold" style="color: var(--text-color);">${c.numeroDocumento}</span>
                </div>

                <div class="col-md-3">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">TELÉFONO</small>
                  <span class="fw-semibold" style="color: var(--text-color);">${empty c.telefono or c.telefono == '0' ? '-' : c.telefono}</span>
                </div>

                <div class="col-md-6">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">CORREO</small>
                  <span class="fw-semibold" style="color: var(--text-color);">${empty c.email ? 'No registrado' : c.email}</span>
                </div>

                <div class="col-md-12">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">DIRECCIÓN</small>
                  <span class="fw-semibold" style="color: var(--text-color);">${empty c.direccion ? '-' : c.direccion}</span>
                </div>
              </div>

              <div class="row g-3 mb-4">
                <div class="col-md-4">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">TOTAL COMPRADO</small>
                  <span class="fw-bold fs-5 text-primary-custom">
                    <fmt:formatNumber value="${c.totalComprado}" type="currency" currencySymbol="S/ "/>
                  </span>
                </div>

                <div class="col-md-4">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">N° DE COMPRAS</small>
                  <span class="fw-bold fs-5" style="color: var(--text-color);">${c.numeroCompras}</span>
                </div>

                <div class="col-md-4">
                  <small class="fw-bold d-block" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">TICKET PROMEDIO</small>
                  <span class="fw-bold fs-5" style="color: var(--text-color);">
                    <fmt:formatNumber value="${c.numeroCompras > 0 ? (c.totalComprado / c.numeroCompras) : 0}" type="currency" currencySymbol="S/ "/>
                  </span>
                </div>
              </div>

              <hr style="border-color: var(--border-color);">

              <h6 class="fw-bold mb-3" style="color: var(--text-color);">Historial de compras (Demostrativo)</h6>

              <div class="table-responsive">
                <table class="table custom-table align-middle mb-0" style="color: var(--text-color);">
                  <thead>
                  <tr style="color: var(--text-color); opacity: 0.8;">
                    <th>FECHA</th>
                    <th>COMPROBANTE</th>
                    <th>TOTAL</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr>
                    <td colspan="3" class="text-center py-3" style="color: var(--text-color); opacity: 0.7;">
                      No hay compras registradas para este cliente.
                    </td>
                  </tr>
                  </tbody>
                </table>
              </div>

            </div>

            <div class="modal-footer border-0 pt-0">
              <button type="button" class="btn btn-primary-custom fw-bold" data-bs-dismiss="modal">
                Cerrar
              </button>
            </div>

          </div>
        </div>
      </div>
    </c:forEach>
  </c:if>

</section>