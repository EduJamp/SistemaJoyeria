<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Categoria" %>
<%
String vistaActivaCat = (String) request.getAttribute("vistaActiva");
boolean esCategorias = "categorias".equals(vistaActivaCat);
%>
<section id="view-categorias" class="view-section <%= esCategorias ? "active" : "" %>">

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
  <div class="input-group" style="max-width: 400px;">
    <input type="text" id="categoriaBuscador" class="form-control" placeholder="Buscar categorías...">
    <button type="button" class="btn btn-primary-custom">
      <i class="bi bi-search"></i>
    </button>
  </div>
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
        <%
        List<Categoria> listaCategorias = (List<Categoria>) request.getAttribute("categorias");
          if (listaCategorias != null && !listaCategorias.isEmpty()) {
          for (Categoria cat : listaCategorias) {
          %>
          <tr>
            <td class="text-muted"><%= cat.getId() %></td>
            <td class="fw-semibold"><%= cat.getNombre() %></td>
            <td class="text-muted"><%= cat.getDescripcion() != null ? cat.getDescripcion() : "Sin descripción" %></td>
            <td class="text-center fw-bold">0</td>
            <td class="text-end">
              <button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Editar">
                <i class="bi bi-pencil-square fs-5"></i>
              </button>
              <button type="button" class="btn btn-link text-danger p-0 border-0 bg-transparent" title="Eliminar">
                <i class="bi bi-trash fs-5"></i>
              </button>
            </td>
          </tr>
          <%
          }
          } else {
          %>
          <tr>
            <td colspan="5" class="text-center text-muted py-3">No hay categorías registradas.</td>
          </tr>
          <%
          }
          %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- MODAL: NUEVA CATEGORÍA -->
<div class="modal fade" id="nuevaCategoriaModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content custom-card border-0">
      <form action="<%= request.getContextPath() %>/svcategoria" method="POST">
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

</section>