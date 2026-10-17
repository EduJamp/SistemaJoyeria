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
            <h3 class="fw-bold title-font mb-1">Productos</h3>
            <p class="text-muted mb-0">Gestión de productos del inventario.</p>
        </div>

        <button type="button" class="btn btn-primary-custom fw-bold" data-bs-toggle="modal" data-bs-target="#nuevoProductoModal">
            <i class="bi bi-plus-lg"></i>
            Nuevo producto
        </button>
    </div>

    <!-- KPIs RÁPIDOS -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">TOTAL PRODUCTOS</small>
                    <span class="fw-bold fs-5">4</span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">ACTIVOS</small>
                    <span class="fw-bold fs-5" style="color:#22c55e;">3</span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="custom-card card border-0 h-100">
                <div class="card-body p-3">
                    <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">STOCK BAJO</small>
                    <span class="fw-bold fs-5" style="color:#eab308;">1</span>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
                <div class="card-body p-3">
                    <div class="kpi-decor bg-pink-light"></div>
                    <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.65rem;">VALOR EN INVENTARIO</small>
                    <span class="fw-bold fs-5 text-primary-custom">S/ 4,120.60</span>
                </div>
            </div>
        </div>
    </div>

    <!-- FILTROS Y BUSCADOR -->
    <div class="custom-card card border-0 mb-4 p-3">
        <div class="row g-3 align-items-end">
            <div class="col-md-5">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">BUSCAR</label>
                <!-- Formulario GET para enviar el criterio de búsqueda -->
                <form action="${pageContext.request.contextPath}/svproducto" method="GET" class="input-group">
                    <input type="text" name="criterio" class="form-control" placeholder="Nombre o código de barras..." value="${param.criterio}">
                    <button type="submit" class="btn btn-primary-custom">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>

            <div class="col-md-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CATEGORÍA</label>
                <select class="form-select">
                    <option value="">Todas</option>
                    <c:forEach var="cat" items="${categorias}">
                        <option value="${cat.id()}">${cat.nombre()}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
                <select class="form-select">
                    <option value="">Todos</option>
                    <option>Activo</option>
                    <option>Inactivo</option>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">STOCK</label>
                <select class="form-select">
                    <option value="">Todos</option>
                    <option>Con stock</option>
                    <option>Stock bajo</option>
                    <option>Agotado</option>
                </select>
            </div>
        </div>
    </div>

    <!-- TABLA DE PRODUCTOS -->
    <div class="table-responsive">
        <table class="table custom-table table-hover align-middle text-nowrap mb-0">
            <thead>
            <tr>
                <th></th>
                <th>PRODUCTO</th>
                <th>CÓD. BARRAS</th>
                <th>CATEGORÍA</th>
                <th class="text-end">PRECIO UNIDAD</th>
                <th class="text-end">DESDE (MAYOREO)</th>
                <th class="text-center">STOCK</th>
                <th>ESTADO</th>
                <th class="text-end">ACCIONES</th>
            </tr>
            </thead>
            <tbody>
            <!-- Iteración con JSTL -->
            <c:choose>
                <c:when test="${not empty productos}">
                    <c:forEach var="p" items="${productos}">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center justify-content-center" style="width:44px; height:44px; background:var(--bg-primary); border-radius:10px;">
                                    <i class="bi bi-gem text-muted"></i>
                                </div>
                            </td>
                            <td class="fw-semibold">${p.nombre}</td>
                            <td>${p.codigoBarras}</td>
                            <td>
                                <span class="badge bg-pink-light text-primary-custom">
                                    <c:out value="${p.categoria.nombre != null ? p.categoria.nombre : 'Cat ' += p.categoria.id}" />
                                </span>
                            </td>
                            <td class="text-end fw-bold">S/ <fmt:formatNumber value="${p.precioUnidad}" pattern="#,##0.00"/></td>
                            <td class="text-end text-muted">S/ <fmt:formatNumber value="${p.precioX12}" pattern="#,##0.00"/></td>
                            <td class="text-center fw-bold">${p.cantidad}</td>
                            <td>
                                <span class="badge" style="background-color: ${p.estado == 'activo' ? '#22c55e' : '#ef4444'};">
                                    ${p.estado}
                                </span>
                            </td>
                            <td class="text-end">
                                <!-- Botón Editar con ID único para el modal -->
                                <button type="button" class="btn btn-link text-primary-custom p-0 me-2" data-bs-toggle="modal" data-bs-target="#modalEditar_${p.id}">
                                    <i class="bi bi-pencil-square fs-5"></i>
                                </button>

                                <!-- Formulario Eliminar -->
                                <form action="${pageContext.request.contextPath}/svproducto" method="POST" style="display: inline; margin: 0; padding: 0;">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idProducto" value="${p.id}">
                                    <button type="submit" class="btn btn-link text-danger p-0" onclick="return confirm('¿Estás seguro de eliminar este producto?');">
                                        <i class="bi bi-trash fs-5"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="9" class="text-center py-4 text-muted">No se encontraron productos registrados.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <!-- MODAL: NUEVO PRODUCTO -->
    <div class="modal fade" id="nuevoProductoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content custom-card border-0">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold title-font">Nuevo producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>

                <form action="${pageContext.request.contextPath}/svproducto" method="POST">
                    <input type="hidden" name="accion" value="crear">
                    <div class="modal-body p-4">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">IMAGEN</label>
                                <div class="d-flex align-items-center justify-content-center mb-2" style="height: 140px; background-color: var(--bg-primary); border-radius: 12px; border: 1.5px dashed var(--border-color);">
                                    <i class="bi bi-image text-muted" style="font-size: 2rem;"></i>
                                </div>
                                <input type="file" name="imagen" class="form-control" accept="image/*">
                            </div>

                            <div class="col-md-8">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CÓDIGO DE BARRAS</label>
                                        <input type="text" name="codigoBarras" class="form-control" placeholder="7751234560012" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CATEGORÍA</label>
                                        <!-- CATEGORÍAS DINÁMICAS DESDE LA BD -->
                                        <select name="idCategoria" class="form-select" required>
                                            <option value="">Seleccione una categoría...</option>
                                            <c:forEach var="cat" items="${categorias}">
                                                <option value="${cat.id()}">${cat.nombre()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                                        <input type="text" name="nombre" class="form-control" placeholder="Ej: Aretes de Plata 950 Gota" required>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DESCRIPCIÓN</label>
                                        <textarea name="descripcion" class="form-control" rows="2" placeholder="Detalle del producto..."></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr style="border-color: var(--border-color);">

                        <label class="form-label text-muted fw-bold mb-2" style="font-size: 0.75rem;">PRECIOS POR VOLUMEN</label>
                        <div class="row g-3 mb-3">
                            <div class="col-6 col-md">
                                <small class="text-muted d-block mb-1" style="font-size:0.65rem;">UNIDAD</small>
                                <input type="number" name="precioUnidad" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                            <div class="col-6 col-md">
                                <small class="text-muted d-block mb-1" style="font-size:0.65rem;">X3</small>
                                <input type="number" name="precio3" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                            <div class="col-6 col-md">
                                <small class="text-muted d-block mb-1" style="font-size:0.65rem;">X6</small>
                                <input type="number" name="precio6" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                            <div class="col-6 col-md">
                                <small class="text-muted d-block mb-1" style="font-size:0.65rem;">X12</small>
                                <input type="number" name="precio12" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                            <div class="col-6 col-md">
                                <small class="text-muted d-block mb-1" style="font-size:0.65rem;">PAQUETE</small>
                                <input type="number" name="precioPaquete" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CANTIDAD INICIAL (STOCK)</label>
                                <input type="number" name="cantidad" min="0" class="form-control" placeholder="0" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
                                <select name="estado" class="form-select" required>
                                    <option value="activo">Activo</option>
                                    <option value="inactivo">Inactivo</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer border-0 pt-0">
                        <button type="button" class="btn btn-outline-secondary fw-semibold" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary-custom fw-bold">
                            <i class="bi bi-check2-circle"></i>
                            Guardar producto
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- MODALES DE EDICIÓN DINÁMICOS -->
    <c:if test="${not empty productos}">
        <c:forEach var="p" items="${productos}">
            <div class="modal fade" id="modalEditar_${p.id}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content custom-card border-0">
                        <div class="modal-header border-0 pb-0">
                            <div>
                                <h5 class="modal-title fw-bold title-font">Editar producto</h5>
                                <small class="text-muted">Modifica la información del producto</small>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>

                        <form action="${pageContext.request.contextPath}/svproducto" method="POST">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="idProducto" value="${p.id}">

                            <div class="modal-body p-4">
                                <div class="row g-4">
                                    <!-- COLUMNA IZQUIERDA: IMAGEN -->
                                    <div class="col-md-4">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">IMAGEN</label>
                                        <div class="d-flex align-items-center justify-content-center mb-2" style="height: 140px; background-color: var(--bg-primary); border-radius: 12px; border: 1.5px dashed var(--border-color);">
                                            <i class="bi bi-image text-muted" style="font-size: 2rem;"></i>
                                        </div>
                                        <input type="file" name="imagen" class="form-control" accept="image/*">
                                        <c:if test="${not empty p.imagen}">
                                            <small class="text-muted d-block mt-1" style="font-size: 0.65rem;">Actual: ${p.imagen}</small>
                                        </c:if>
                                    </div>

                                    <!-- COLUMNA DERECHA: DATOS DEL PRODUCTO -->
                                    <div class="col-md-8">
                                        <div class="row g-3">
                                            <div class="col-md-4">
                                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CÓDIGO DE BARRAS</label>
                                                <input type="text" name="codigoBarras" class="form-control" value="${p.codigoBarras}">
                                            </div>
                                            <div class="col-md-8">
                                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                                                <input type="text" name="nombre" class="form-control" value="${p.nombre}" required>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CATEGORÍA</label>
                                                <select name="idCategoria" class="form-select" required>
                                                    <c:forEach var="cat" items="${categorias}">
                                                        <option value="${cat.id()}" ${cat.id() == p.categoria.id ? 'selected' : ''}>
                                                        ${cat.nombre()}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-12">
                                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DESCRIPCIÓN</label>
                                                <textarea name="descripcion" class="form-control" rows="2">${p.descripcion}</textarea>
                                            </div>
                                        </div>

                                        <hr style="border-color: var(--border-color);">

                                        <label class="form-label text-muted fw-bold mb-2" style="font-size: 0.75rem;">PRECIOS POR VOLUMEN</label>
                                        <div class="row g-2 mb-3">
                                            <div class="col-6 col-md">
                                                <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">UNIDAD</small>
                                                <input type="number" name="precioUnidad" step="0.01" min="0" class="form-control" value="${p.precioUnidad}" required>
                                            </div>
                                            <div class="col-6 col-md">
                                                <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">X3</small>
                                                <input type="number" name="precio3" step="0.01" min="0" class="form-control" value="${p.precioX3}" required>
                                            </div>
                                            <div class="col-6 col-md">
                                                <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">X6</small>
                                                <input type="number" name="precio6" step="0.01" min="0" class="form-control" value="${p.precioX6}" required>
                                            </div>
                                            <div class="col-6 col-md">
                                                <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">X12</small>
                                                <input type="number" name="precio12" step="0.01" min="0" class="form-control" value="${p.precioX12}" required>
                                            </div>
                                            <div class="col-6 col-md">
                                                <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">PAQUETE</small>
                                                <input type="number" name="precioPaquete" step="0.01" min="0" class="form-control" value="${p.precioPaquete}" required>
                                            </div>
                                        </div>

                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CANTIDAD (STOCK)</label>
                                                <!-- CAMPO HABILITADO PARA EDITAR EL STOCK -->
                                                <input type="number" name="cantidad" class="form-control" value="${p.cantidad}" min="0" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
                                                <select name="estado" class="form-select" required>
                                                    <option value="activo" ${p.estado == 'activo' ? 'selected' : ''}>Activo</option>
                                                    <option value="inactivo" ${p.estado == 'inactivo' ? 'selected' : ''}>Inactivo</option>
                                                </select>
                                            </div>
                                        </div>
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
        </c:forEach>
    </c:if>

</section>