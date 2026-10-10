<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="esClientes" value="${vistaActiva == 'clientes'}" />
<c:set var="totalClientes" value="${not empty clientes ? fn:length(clientes) : 0}" />

<section id="view-clientes" class="view-section ${esClientes ? 'active' : ''}">

  <div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
    <div>
      <h3 class="fw-bold title-font mb-1">Clientes</h3>
      <p class="text-muted mb-0">Administra la base de clientes del negocio.</p>
    </div>
    <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoClienteModal">
      <i class="bi bi-plus-lg"></i> Nuevo cliente
    </button>
  </div>

  <!-- KPIs RÁPIDOS -->
  <div class="row g-3 mb-4">
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL CLIENTES</small>
          <span id="kpiTotalClientes" class="fw-bold fs-5">${totalClientes}</span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">CLIENTES ACTIVOS</small>
          <!-- Simulamos el mismo total por ahora -->
          <span id="kpiClientesActivos" class="fw-bold fs-5" style="color:#22c55e;">${totalClientes}</span>
        </div>
      </div>
    </div>
    <!-- KPIs fijos/simulados -->
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-3">
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">EMPRESAS (RUC)</small>
          <span class="fw-bold fs-5">0</span>
        </div>
      </div>
    </div>
    <div class="col-6 col-lg-3">
      <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
        <div class="card-body p-3">
          <div class="kpi-decor bg-pink-light"></div>
          <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">FACTURADO TOTAL</small>
          <span class="fw-bold fs-5 text-primary-custom">S/ 8,915.50</span>
        </div>
      </div>
    </div>
  </div>

  <!-- FILTROS -->
  <div class="custom-card card border-0 mb-4 p-3">
    <div class="row g-3 align-items-end">

      <div class="col-md-4">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">BUSCAR</label>

        <!-- CORRECCIÓN: Convertimos el div en un form para enviar el GET al Servlet -->
        <form action="${pageContext.request.contextPath}/svcliente" method="GET" class="input-group">
          <!-- value="${param.criterio}" hace que el texto se quede escrito después de buscar -->
          <input type="text" name="criterio" id="clientesBuscador" class="form-control" placeholder="Nombre, DNI/RUC..." value="${param.criterio}">
          <button type="submit" class="btn btn-primary-custom"><i class="bi bi-search"></i></button>
        </form>

      </div>
      <div class="col-md-3">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE CLIENTE</label>
        <select class="form-select">
          <option value="">Todos</option>
          <option value="natural">Persona natural</option>
          <option value="empresa">Empresa</option>
        </select>
      </div>
      <div class="col-md-3">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SEDE</label>
        <select class="form-select"><option value="">Todas</option><option>Sede Central</option></select>
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
        <select class="form-select"><option value="">Todos</option><option>Activo</option></select>
      </div>
    </div>
  </div>

  <!-- TABLA DE CLIENTES -->
  <div class="custom-card card border-0">
    <div class="card-body p-4">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold title-font mb-0">Listado de clientes</h5>
        <button type="button" class="btn btn-outline-secondary btn-sm fw-semibold">
          <i class="bi bi-download"></i> Exportar CSV
        </button>
      </div>

      <div class="table-responsive">
        <table class="table custom-table table-hover align-middle text-nowrap mb-0" id="tablaClientes">
          <thead>
          <tr>
            <th>CLIENTE</th>
            <th>DOC.</th>
            <th>TELÉFONO</th>
            <th>CORREO</th>
            <th class="text-center">N° COMPRAS</th>
            <th>TOTAL COMPRADO</th>
            <th>ÚLTIMA COMPRA</th>
            <th>ESTADO</th>
            <th class="text-end">ACCIONES</th>
          </tr>
          </thead>
          <tbody id="clientesBody">

          <c:choose>
            <c:when test="${not empty clientes}">
              <!-- BUCLE JSTL PRINCIPAL -->
              <c:forEach var="c" items="${clientes}" varStatus="loop">

                <!-- Lógica de extracción de iniciales y nombres usando EL -->
                <c:set var="iniNom" value="${not empty c.nombre ? fn:substring(c.nombre, 0, 1) : ''}" />
                <c:set var="iniApe" value="${not empty c.apellido ? fn:substring(c.apellido, 0, 1) : ''}" />
                <c:set var="iniciales" value="${fn:toUpperCase(iniNom)}${fn:toUpperCase(iniApe)}" />
                <c:set var="nombreCompleto" value="${c.nombre} ${not empty c.apellido ? c.apellido : ''}" />

                <c:set var="nombreEstado" value="${c.estado.name()}" />
                <c:set var="isActivo" value="${nombreEstado == 'ACTIVO' or nombreEstado == 'activo' or nombreEstado == 'Activo'}" />

                <tr>
                  <td>
                    <div class="d-flex align-items-center gap-2">
                      <span class="avatar" style="width:32px; height:32px; min-width:32px; font-size:0.8rem;">${iniciales}</span>
                      <span class="fw-semibold">${nombreCompleto}</span>
                    </div>
                  </td>
                  <td>${c.tipoDocumento} ${c.numeroDocumento}</td>
                  <td>${empty c.telefono or c.telefono == '0' ? '-' : c.telefono}</td>
                  <td>${empty c.email ? 'Sin correo' : c.email}</td>
                  <td class="text-center fw-bold">${c.numeroCompras}</td>

                  <!-- Formateo de moneda peruana automático -->
                  <td class="fw-bold text-primary-custom">
                    <fmt:formatNumber value="${c.totalComprado}" type="currency" currencySymbol="S/ "/>
                  </td>

                  <td>${not empty c.ultimaCompra ? c.ultimaCompra : '--/--/----'}</td>
                  <td>
                    <span class="badge" style="background-color:${isActivo ? '#22c55e' : '#ef4444'};">
                      ${nombreEstado}
                    </span>
                  </td>
                  <td class="text-end">
                    <!-- Botón Ver Detalles (Vinculado por el loop.index) -->
                    <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Ver detalle" data-bs-toggle="modal" data-bs-target="#clienteModalDetalle_${loop.index}">
                      <i class="bi bi-eye fs-5"></i>
                    </button>
                    <!-- Botón Editar (Vinculado al modal dinámico de edición) -->
                    <button type="button" class="btn btn-link text-muted p-0" title="Editar" data-bs-toggle="modal" data-bs-target="#clienteModalEdit_${loop.index}">
                      <i class="bi bi-pencil fs-5"></i>
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </c:when>

            <c:otherwise>
              <tr>
                <td colspan="9" class="text-center py-5">
                  <div class="d-flex flex-column align-items-center justify-content-center text-muted">
                    <i class="bi bi-inbox fs-1 mb-2"></i>
                    <h6 class="fw-semibold mb-0">No hay clientes registrados</h6>
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

  <!-- MODAL: NUEVO CLIENTE (Alineado a tu Servlet) -->
  <div class="modal fade" id="nuevoClienteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content custom-card border-0">
        <form action="${pageContext.request.contextPath}/svcliente" method="POST">
          <input type="hidden" name="accion" value="crear">

          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold title-font">Nuevo cliente</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>

          <div class="modal-body p-4">
            <div class="row g-3">
              <div class="col-md-4">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE CLIENTE</label>
                <select name="tipoCliente" class="form-select">
                  <option value="natural">Persona natural</option>
                  <option value="empresa">Empresa</option>
                </select>
              </div>
              <div class="col-md-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE DOCUMENTO</label>
                <select name="tipoDocumento" class="form-select">
                  <option value="DNI">DNI</option>
                  <option value="RUC">RUC</option>
                  <option value="CE">Carné de extranjería</option>
                </select>
              </div>
              <div class="col-md-5">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">N° DE DOCUMENTO</label>
                <input type="number" name="numeroDocumento" class="form-control" placeholder="Ej: 45782301" required>
              </div>
              <div class="col-md-12">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRES COMPLETOS / RAZÓN SOCIAL</label>
                <input type="text" name="nombre" class="form-control" placeholder="Ej: Rosa Fernández / Importadora Vega SAC" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
                <input type="number" name="telefono" class="form-control" placeholder="987654321" required>
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CORREO</label>
                <input type="email" name="correo" class="form-control" placeholder="cliente@correo.com" required>
              </div>
              <div class="col-md-12">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
                <input type="text" name="direccion" class="form-control" placeholder="Av. Ejemplo 123, distrito">
              </div>
              <div class="col-md-6">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SEDE</label>
                <!-- Aunque no se guarde en la BD por ahora, mantenemos tu diseño HTML -->
                <select name="sede" class="form-select">
                  <option>Sede Central</option>
                  <option>Miraflores</option>
                  <option>San Isidro</option>
                </select>
              </div>
            </div>
          </div>

          <div class="modal-footer border-0 pt-0">
            <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary-custom fw-bold">
              <i class="bi bi-check2-circle"></i> Guardar cliente
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- GENERACIÓN DINÁMICA DE MODALES DE DETALLE Y EDICIÓN -->
  <c:if test="${not empty clientes}">
    <c:forEach var="c" items="${clientes}" varStatus="loop">

      <c:set var="iniNom" value="${not empty c.nombre ? fn:substring(c.nombre, 0, 1) : ''}" />
      <c:set var="iniApe" value="${not empty c.apellido ? fn:substring(c.apellido, 0, 1) : ''}" />
      <c:set var="iniciales" value="${fn:toUpperCase(iniNom)}${fn:toUpperCase(iniApe)}" />
      <c:set var="nombreCompleto" value="${c.nombre} ${not empty c.apellido ? c.apellido : ''}" />
      <c:set var="nombreEstado" value="${c.estado.name()}" />
      <c:set var="isActivo" value="${nombreEstado == 'ACTIVO' or nombreEstado == 'activo' or nombreEstado == 'Activo'}" />

      <!-- MODAL 1: DETALLE DEL CLIENTE -->
      <div class="modal fade" id="clienteModalDetalle_${loop.index}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content custom-card border-0">
            <div class="modal-header border-0 pb-0">
              <h5 class="modal-title fw-bold title-font">Detalle del cliente</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4">
              <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
                <div class="d-flex align-items-center gap-3">
                  <span class="avatar" style="width:56px; height:56px; min-width:56px; font-size:1.3rem;">${iniciales}</span>
                  <div>
                    <h4 class="fw-bold title-font mb-0">${nombreCompleto}</h4>
                    <small class="text-muted">Cliente registrado recientemente</small>
                  </div>
                </div>
                <span class="badge" style="background-color:${isActivo ? '#22c55e' : '#ef4444'};">${nombreEstado}</span>
              </div>

              <div class="row g-3 mb-3">
                <div class="col-md-3">
                  <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">${c.tipoDocumento}</small>
                  <span class="fw-semibold">${c.numeroDocumento}</span>
                </div>
                <div class="col-md-3">
                  <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">TELÉFONO</small>
                  <span class="fw-semibold">${empty c.telefono or c.telefono == '0' ? '-' : c.telefono}</span>
                </div>
                <div class="col-md-6">
                  <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">CORREO</small>
                  <span class="fw-semibold">${empty c.email ? 'Sin correo' : c.email}</span>
                </div>
              </div>

              <div class="row g-3 mb-4">
                <div class="col-md-6">
                  <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">DIRECCIÓN</small>
                  <span class="fw-semibold">${empty c.direccion ? 'Sin dirección registrada' : c.direccion}</span>
                </div>
                <div class="col-md-3">
                  <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">TIPO</small>
                  <span class="fw-semibold">${c.tipoCliente == 'empresa' ? 'Empresa' : 'Persona natural'}</span>
                </div>
              </div>

              <div class="row g-3 mb-4">
                <div class="col-md-4">
                  <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">TOTAL COMPRADO</small>
                  <span class="fw-bold fs-5 text-primary-custom">
                    <fmt:formatNumber value="${c.totalComprado}" type="currency" currencySymbol="S/ "/>
                  </span>
                </div>
                <div class="col-md-4">
                  <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">N° DE COMPRAS</small>
                  <span class="fw-bold fs-5">${c.numeroCompras}</span>
                </div>
                <div class="col-md-4">
                  <small class="text-muted fw-bold d-block" style="font-size: 0.7rem;">TICKET PROMEDIO</small>
                  <span class="fw-bold fs-5">
                    <fmt:formatNumber value="${c.numeroCompras > 0 ? (c.totalComprado / c.numeroCompras) : 0}" type="currency" currencySymbol="S/ "/>
                  </span>
                </div>
              </div>
            </div>

            <div class="modal-footer border-0 pt-0 d-flex">
              <!-- CORRECCIÓN: Botón "Desactivar" encapsulado en un formulario para conectarlo al método delete del Servlet -->
              <form action="${pageContext.request.contextPath}/svcliente" method="POST" class="me-auto m-0 p-0">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="id" value="${c.id_cliente}">
                <button type="submit" class="btn btn-outline-danger fw-semibold" onclick="return confirm('¿Estás seguro de desactivar/eliminar a este cliente?');">
                  <i class="bi bi-slash-circle"></i> Desactivar cliente
                </button>
              </form>

              <button type="button" class="btn btn-primary-custom fw-bold" data-bs-dismiss="modal">Cerrar</button>
            </div>
          </div>
        </div>
      </div>

      <!-- MODAL 2: EDITAR CLIENTE (Clonado del Nuevo Cliente para que funcione el lápiz) -->
      <div class="modal fade" id="clienteModalEdit_${loop.index}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content custom-card border-0">
            <form action="${pageContext.request.contextPath}/svcliente" method="POST">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="id" value="${c.id_cliente}">

              <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold title-font">Editar cliente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>

              <div class="modal-body p-4">
                <div class="row g-3">
                  <div class="col-md-4">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DE CLIENTE</label>
                    <select name="tipoCliente" class="form-select">
                      <option value="natural" ${c.tipoCliente == 'natural' ? 'selected' : ''}>Persona natural</option>
                      <option value="empresa" ${c.tipoCliente == 'empresa' ? 'selected' : ''}>Empresa</option>
                    </select>
                  </div>
                  <div class="col-md-3">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TIPO DOC.</label>
                    <select name="tipoDocumento" class="form-select">
                      <option value="DNI" ${c.tipoDocumento == 'DNI' ? 'selected' : ''}>DNI</option>
                      <option value="RUC" ${c.tipoDocumento == 'RUC' ? 'selected' : ''}>RUC</option>
                      <option value="CE" ${c.tipoDocumento == 'CE' ? 'selected' : ''}>Carné de extranjería</option>
                    </select>
                  </div>
                  <div class="col-md-5">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">N° DE DOCUMENTO</label>
                    <input type="number" name="numeroDocumento" class="form-control" value="${c.numeroDocumento}" required>
                  </div>
                  <div class="col-md-12">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRES COMPLETOS / RAZÓN SOCIAL</label>
                    <input type="text" name="nombre" class="form-control" value="${nombreCompleto}" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">TELÉFONO</label>
                    <input type="number" name="telefono" class="form-control" value="${c.telefono}" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CORREO</label>
                    <input type="email" name="correo" class="form-control" value="${c.email}" required>
                  </div>
                  <div class="col-md-9">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DIRECCIÓN</label>
                    <input type="text" name="direccion" class="form-control" value="${c.direccion}">
                  </div>
                  <div class="col-md-3">
                    <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
                    <select name="estado" class="form-select">
                      <option value="ACTIVO" ${isActivo ? 'selected' : ''}>Activo</option>
                      <option value="INACTIVO" ${!isActivo ? 'selected' : ''}>Inactivo</option>
                    </select>
                  </div>
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

    </c:forEach>
  </c:if>

</section>