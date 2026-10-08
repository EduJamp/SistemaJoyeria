<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.liamyimport.model.Caja" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
boolean esApertura = "apertura-caja".equals(request.getAttribute("vistaActiva"));
Caja cajaActual = (Caja) request.getAttribute("cajaActual");

boolean cajaAbierta = (cajaActual != null && "ABIERTA".equalsIgnoreCase(cajaActual.getEstado()));

String fechaHoyStr = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date());
%>

<section id="view-apertura" class="view-section <%= esApertura ? "active" : "" %>">

<div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">

  <div>
    <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">
      Apertura de Caja
    </h3>

    <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">
      Registra el monto inicial con el que abres la caja del turno.
    </p>
  </div>

  <!-- Badge de estado dinámico -->
  <span id="estadoCaja" class="badge text-white fw-bold" style="background-color: <%= cajaAbierta ? "#22c55e" : "#ef4444" %>;">
  <%= cajaAbierta ? "CAJA ABIERTA" : "CAJA CERRADA" %>
  </span>

</div>

<div class="row g-4">

  <div class="col-lg-7">

    <div class="custom-card card border-0">

      <div class="card-body p-4">

        <h5 class="fw-bold mb-4 title-font" style="color: var(--text-color);">
          Datos de apertura
        </h5>

        <!-- Formulario conectado con SvCaja (Acción: aperturar) -->
        <form action="<%= request.getContextPath() %>/svcaja" method="POST">
          <input type="hidden" name="accion" value="aperturar">

          <div class="row g-3">

            <div class="col-md-6">
              <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                SEDE
              </label>
              <select id="aperturaSede" name="sede" class="form-select" <%= cajaAbierta ? "disabled" : "" %> required>
              <option value="Sede Central" <%= (cajaAbierta && "Sede Central".equals(cajaActual.getSede())) ? "selected" : "" %>>Sede Central</option>
              <option value="Miraflores" <%= (cajaAbierta && "Miraflores".equals(cajaActual.getSede())) ? "selected" : "" %>>Miraflores</option>
              <option value="San Isidro" <%= (cajaAbierta && "San Isidro".equals(cajaActual.getSede())) ? "selected" : "" %>>San Isidro</option>
              </select>
            </div>

            <div class="col-md-6">
              <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                RESPONSABLE
              </label>
              <input type="text" id="aperturaResponsable" name="responsable" class="form-control"
                     value="<%= cajaAbierta ? cajaActual.getResponsable() : "Edu Jampier Caceres Ruiz" %>"
              <%= cajaAbierta ? "readonly" : "" %> required style="background-color: var(--card-bg); color: var(--text-color); border-color: var(--border-color);">
            </div>

            <div class="col-md-6">
              <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                MONTO INICIAL (S/)
              </label>
              <input type="number" id="aperturaMonto" name="montoInicial" class="form-control" min="0" step="0.01" placeholder="0.00"
                     value="<%= cajaAbierta ? cajaActual.getMontoInicial() : "" %>"
              <%= cajaAbierta ? "readonly" : "" %> required style="background-color: var(--card-bg); color: var(--text-color); border-color: var(--border-color);">
            </div>

            <div class="col-md-6">
              <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                FECHA Y HORA
              </label>
              <input type="text" id="aperturaFecha" class="form-control"
                     value="<%= cajaAbierta ? cajaActual.getFechaApertura() : fechaHoyStr %>" disabled style="background-color: var(--card-bg); color: var(--text-color); border-color: var(--border-color);">
            </div>

            <div class="col-12">
              <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                OBSERVACIONES (OPCIONAL)
              </label>
              <textarea id="aperturaObservaciones" name="observaciones" class="form-control" rows="3" placeholder="Ej: billetes revisados, caja completa..." <%= cajaAbierta ? "readonly" : "" %> style="background-color: var(--card-bg); color: var(--text-color); border-color: var(--border-color);"><%= cajaAbierta && cajaActual.getObservacionesApertura() != null ? cajaActual.getObservacionesApertura() : "" %></textarea>
            </div>

          </div>

          <% if (!cajaAbierta) { %>
          <button type="submit" id="btnAperturarCaja" class="btn btn-primary-custom fw-bold mt-4">
            <i class="bi bi-unlock-fill"></i>
            Aperturar caja
          </button>
          <% } else { %>
          <div class="alert alert-warning mt-4 mb-0 fw-semibold" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> La caja ya se encuentra abierta. Puedes dirigirte al Punto de Venta para operar.
          </div>
          <% } %>

        </form>

      </div>

    </div>

  </div>

  <div class="col-lg-5">

    <div class="custom-card card border-0 h-100">

      <div class="card-body p-4">

        <h5 class="fw-bold mb-3 title-font" style="color: var(--text-color);">
          Antes de empezar
        </h5>

        <ul style="font-size: 0.9rem; padding-left: 18px; color: var(--text-color); opacity: 0.8;">
          <li class="mb-2">Cuenta el efectivo físico disponible en caja.</li>
          <li class="mb-2">Verifica que el monto coincida con el cierre anterior.</li>
          <li class="mb-2">Registra cualquier diferencia en observaciones.</li>
          <li>Una vez aperturada, podrás usar el Punto de Venta.</li>
        </ul>

      </div>

    </div>

  </div>

</div>

</section>