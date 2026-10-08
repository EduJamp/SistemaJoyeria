<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Producto" %>
<%@ page import="com.liamyimport.util.csv.ProductoRepository" %>
<%
String vistaActivaProd = (String) request.getAttribute("vistaActiva");
boolean esProductosProd = "productos".equals(vistaActivaProd);
%>
<section id="view-productos" class="view-section <%= esProductosProd ? "active" : "" %>">

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

    <!-- FILTROS -->
    <div class="custom-card card border-0 mb-4 p-3">
        <div class="row g-3 align-items-end">
            <div class="col-md-5">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">BUSCAR</label>
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Nombre o código de barras...">
                    <button type="button" class="btn btn-primary-custom">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </div>

            <div class="col-md-3">
                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CATEGORÍA</label>
                <select class="form-select">
                    <option value="">Todas</option>
                    <option>Aretes</option>
                    <option>Cadenas</option>
                    <option>Anillos</option>
                    <option>Pulseras</option>
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
            <%
            List<Producto> lista = (List<Producto>) request.getAttribute("productos");
                if (lista != null) {
                for(Producto p : lista) {
                %>
                <tr>
                    <td>
                        <div class="d-flex align-items-center justify-content-center" style="width:44px; height:44px; background:var(--bg-primary); border-radius:10px;">
                            <i class="bi bi-gem text-muted"></i>
                        </div>
                    </td>
                    <td class="fw-semibold"><%= p.getNombre() %></td>
                    <td><%= p.getCodigoBarras() %></td>
                    <td>
                        <span class="badge bg-pink-light text-primary-custom">
                            Cat <%= p.getCategoria() != null ? p.getCategoria().getId() : "-" %>
                        </span>
                    </td>
                    <td class="text-end fw-bold">S/ <%= String.format("%.2f", p.getPrecioUnidad()) %></td>
                    <td class="text-end text-muted">S/ <%= String.format("%.2f", p.getPrecioX12()) %></td>
                    <td class="text-center fw-bold"><%= p.getCantidad() %></td>
                    <td>
                        <span class="badge" style="background-color: #22c55e;">
                            <%= p.getEstado() %>
                        </span>
                    </td>
                    <td class="text-end">
                        <button type="button" class="btn btn-link text-primary-custom p-0 me-2" data-bs-toggle="modal" data-bs-target="#modalEditar_<%= p.getCodigoBarras() %>">
                            <i class="bi bi-pencil-square fs-5"></i>
                        </button>
                        <form action="svproducto" method="POST" style="display: inline; margin: 0; padding: 0;">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="codigoBarras" value="<%= p.getCodigoBarras() %>">
                            <button type="submit" class="btn btn-link text-danger p-0">
                                <i class="bi bi-trash fs-5"></i>
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                }
                }
                %>
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

                <form action="<%= request.getContextPath() %>/svproducto" method="POST">
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
                                        <select name="idCategoria" class="form-select" required>
                                            <option value="1">Aretes</option>
                                            <option value="2">Cadenas</option>
                                            <option value="3">Anillos</option>
                                            <option value="4">Pulseras</option>
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
                                <input type="number" name="precioX3" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                            <div class="col-6 col-md">
                                <small class="text-muted d-block mb-1" style="font-size:0.65rem;">X6</small>
                                <input type="number" name="precioX6" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                            <div class="col-6 col-md">
                                <small class="text-muted d-block mb-1" style="font-size:0.65rem;">X12</small>
                                <input type="number" name="precioX12" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                            <div class="col-6 col-md">
                                <small class="text-muted d-block mb-1" style="font-size:0.65rem;">PAQUETE</small>
                                <input type="number" name="precioPaquete" step="0.01" min="0" class="form-control" placeholder="0.00" required>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CANTIDAD (STOCK)</label>
                                <input type="number" name="cantidad" min="0" class="form-control" placeholder="0" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
                                <select name="estado" class="form-select" required>
                                    <option value="activo">Activo</option>
                                    <option value="desactivo">Inactivo</option>
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

    <!-- MODALES DE EDICIÓN -->
    <%
    List<Producto> listaModales = (List<Producto>) request.getAttribute("productos");
    if (listaModales != null && !listaModales.isEmpty()) {
    for (Producto p : listaModales) {
    int catId = p.getCategoria() != null ? p.getCategoria().getId() : 1;
    String estadoActual = p.getEstado() != null ? p.getEstado().name() : "activo";
    %>
    <div class="modal fade" id="modalEditar_<%= p.getCodigoBarras() %>" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content custom-card border-0">
                <div class="modal-header border-0 pb-0">
                    <div>
                        <h5 class="modal-title fw-bold title-font">Editar producto</h5>
                        <small class="text-muted">Modifica la información del producto</small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>

                <form action="svproducto" method="POST">
                    <input type="hidden" name="accion" value="actualizar">
                    <input type="hidden" name="codigoBarras" value="<%= p.getCodigoBarras() %>">

                    <div class="modal-body p-4">
                        <div class="row g-4">
                            <div class="col-md-4">
                                <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CÓDIGO DE BARRAS</label>
                                <input type="text" class="form-control" value="<%= p.getCodigoBarras() %>" disabled>
                            </div>

                            <div class="col-md-8">
                                <div class="row g-3">
                                    <div class="col-md-8">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">NOMBRE</label>
                                        <input type="text" name="nombre" class="form-control" value="<%= p.getNombre() %>" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CATEGORÍA</label>
                                        <select name="idCategoria" class="form-select" required>
                                            <option value="1" <%= catId == 1 ? "selected" : "" %>>Aretes</option>
                                            <option value="2" <%= catId == 2 ? "selected" : "" %>>Cadenas</option>
                                            <option value="3" <%= catId == 3 ? "selected" : "" %>>Anillos</option>
                                            <option value="4" <%= catId == 4 ? "selected" : "" %>>Pulseras</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">DESCRIPCIÓN</label>
                                        <textarea name="descripcion" class="form-control" rows="2"><%= p.getDescripcion() != null ? p.getDescripcion() : "" %></textarea>
                                    </div>
                                </div>

                                <hr style="border-color: var(--border-color);">

                                <label class="form-label text-muted fw-bold mb-2" style="font-size: 0.75rem;">PRECIOS POR VOLUMEN</label>
                                <div class="row g-2 mb-3">
                                    <div class="col-6 col-md">
                                        <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">UNIDAD</small>
                                        <input type="number" name="precioUnidad" step="0.01" min="0" class="form-control" value="<%= p.getPrecioUnidad() %>" required>
                                    </div>
                                    <div class="col-6 col-md">
                                        <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">X3</small>
                                        <input type="number" name="precioX3" step="0.01" min="0" class="form-control" value="<%= p.getPrecioX3() %>" required>
                                    </div>
                                    <div class="col-6 col-md">
                                        <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">X6</small>
                                        <input type="number" name="precioX6" step="0.01" min="0" class="form-control" value="<%= p.getPrecioX6() %>" required>
                                    </div>
                                    <div class="col-6 col-md">
                                        <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">X12</small>
                                        <input type="number" name="precioX12" step="0.01" min="0" class="form-control" value="<%= p.getPrecioX12() %>" required>
                                    </div>
                                    <div class="col-6 col-md">
                                        <small class="text-muted d-block mb-1" style="font-size: 0.65rem;">PAQUETE</small>
                                        <input type="number" name="precioPaquete" step="0.01" min="0" class="form-control" value="<%= p.getPrecioPaquete() %>" required>
                                    </div>
                                </div>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">CANTIDAD (STOCK)</label>
                                        <input type="number" name="cantidad" class="form-control" min="0" value="<%= p.getCantidad() %>" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">ESTADO</label>
                                        <select name="estado" class="form-select" required>
                                            <option value="activo" <%= estadoActual.equalsIgnoreCase("activo") ? "selected" : "" %>>Activo</option>
                                            <option value="desactivo" <%= estadoActual.equalsIgnoreCase("desactivo") ? "selected" : "" %>>Desactivado</option>
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
    <%
    }
    }
    %>

</section>