<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Promocion" %>

<%
boolean esPromociones = "promociones".equals(request.getAttribute("vistaActiva"));
List<Promocion> listaPromociones = (List<Promocion>) request.getAttribute("promociones");
  %>

  <section id="view-promociones" class="view-section <%= esPromociones ? "active" : "" %>">

  <!-- ENCABEZADO ADAPTABLE -->
  <div class="mb-4">
    <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">Promociones Disponibles</h3>
    <p class="mb-0 fs-6" style="color: var(--text-muted);">Conoce las promociones vigentes que puedes ofrecer a tus clientes durante las ventas.</p>
  </div>

  <!-- CONTENEDOR DE PROMOCIONES -->
  <div class="row g-4">

    <%
    if (listaPromociones != null && !listaPromociones.isEmpty()) {
    for (Promocion p : listaPromociones) {

    String tipo = p.getTipo() != null ? p.getTipo().toLowerCase() : "";
    String iconClass = "bi-tag-fill";

    if (tipo.contains("descuento")) iconClass = "bi-percent";
    else if (tipo.contains("combo")) iconClass = "bi-box-seam-fill";
    else if (tipo.contains("frecuente")) iconClass = "bi-star-fill";
    else if (tipo.contains("relámpago") || tipo.contains("oferta")) iconClass = "bi-lightning-charge-fill";
    else if (tipo.contains("promoción") || tipo.contains("2 + 1")) iconClass = "bi-cart-check";
    %>
    <!-- TARJETA DE PROMOCIÓN -->
    <div class="col-12 col-md-6 col-xl-4">
      <div class="card border-0 h-100 overflow-hidden shadow-sm" style="background-color: var(--card-bg); color: var(--text-color);">

        <!-- CABECERA VISUAL -->
        <div class="position-relative p-4"
             style="background: <%= p.getColorFondo() != null ? p.getColorFondo() : "var(--gradient-primary)" %>; min-height: 150px;">

        <div class="d-flex justify-content-between align-items-start">
            <span class="badge bg-white text-dark rounded-pill px-3 py-2 fw-semibold shadow-sm">
                <%= p.getTipo() %>
            </span>

          <div class="bg-white bg-opacity-25 rounded-circle d-flex align-items-center justify-content-center"
               style="width: 48px; height: 48px;">
            <i class="bi <%= iconClass %> text-white fs-4"></i>
          </div>
        </div>

        <div class="position-absolute bottom-0 start-0 p-4 text-white w-100" style="background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);">
          <h4 class="fw-bold title-font mb-1 text-white">
            <%= p.getNombre() %>
          </h4>
          <div class="d-flex justify-content-between align-items-center">
            <small class="text-white opacity-100 fw-semibold">
              Sede: <%= p.getSede() %>
            </small>
            <span class="badge <%= p.getEstado().equalsIgnoreCase("Activa") ? "bg-success" : (p.getEstado().equalsIgnoreCase("Inactiva") ? "bg-danger" : "bg-warning text-dark") %>">
            <%= p.getEstado() %>
            </span>
          </div>
        </div>

      </div>

      <!-- CONTENIDO CON TEXTOS DINÁMICOS -->
      <div class="card-body p-4 d-flex flex-column">

        <!-- Usamos var(--text-color) con un peso equilibrado para que oscurezca en modo claro y aclare en modo oscuro -->
        <p class="mb-4" style="color: var(--text-color); opacity: 0.85; font-size: 0.95rem;">
          <%= p.getDescripcion() %>
        </p>

        <div class="mt-auto">
          <div class="d-flex align-items-center gap-2 mb-2">
            <i class="bi bi-calendar3 text-primary-custom"></i>
            <span class="small fw-semibold" style="color: var(--text-color); opacity: 0.8;">
                  Vigencia: <%= p.getFechaInicio() %> - <%= p.getFechaFin() %>
              </span>
          </div>

          <div class="d-flex align-items-center gap-2">
            <i class="bi bi-info-circle text-primary-custom"></i>
            <span class="small" style="color: var(--text-color); opacity: 0.8;">
                  Aplica restricciones según sede.
              </span>
          </div>
        </div>

      </div>

    </div>
  </div>
  <%
  }
  } else {
  %>
  <div class="col-12 text-center py-5">
    <i class="bi bi-tags text-muted" style="font-size: 3rem;"></i>
    <h5 class="mt-3 fw-bold" style="color: var(--text-color);">No hay promociones activas</h5>
    <p style="color: var(--text-muted);">Por el momento no hay promociones disponibles para mostrar.</p>
  </div>
  <%
  }
  %>

  </div>

  </section>