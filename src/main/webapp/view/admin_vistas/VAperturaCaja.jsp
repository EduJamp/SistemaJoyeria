<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.liamyimport.model.Caja" %>
<%
boolean esApertura = "apertura-caja".equals(request.getAttribute("vistaActiva"));
Caja cajaValidar = (Caja) request.getAttribute("cajaActual");
boolean cajaAbierta = (cajaValidar != null && "ABIERTA".equals(cajaValidar.getEstado()));
%>

<section id="view-apertura" class="view-section <%= esApertura ? "active" : "" %>">
<div class="mb-4 d-flex justify-content-between align-items-start flex-wrap gap-2">
  <div>
    <h3 class="fw-bold title-font mb-1">Apertura de Caja</h3>
    <p class="text-muted mb-0">Registra el monto inicial con el que abres la caja del turno.</p>
  </div>
  <% if(cajaAbierta) { %>
  <span class="badge" style="background-color:#22c55e;">CAJA ABIERTA</span>
  <% } else { %>
  <span class="badge" style="background-color:#ef4444;">CAJA CERRADA</span>
  <% } %>
</div>

<form action="<%= request.getContextPath() %>/svcaja" method="POST">
  <input type="hidden" name="accion" value="aperturar">
  <div class="row g-4">
    <div class="col-lg-7">
      <div class="custom-card card border-0">
        <div class="card-body p-4">
          <h5 class="fw-bold mb-4 title-font">Datos de apertura</h5>
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">SEDE</label>
              <select name="sede" class="form-select" <%= cajaAbierta ? "disabled" : "" %>>
              <option value="Sede Central">Sede Central</option>
              <option value="Miraflores">Miraflores</option>
              <option value="San Isidro">San Isidro</option>
              </select>
            </div>
            <div class="col-md-6">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">RESPONSABLE</label>
              <input type="text" name="responsable" class="form-control" value="Edu Jampier Caceres Ruiz" readonly>
            </div>
            <div class="col-md-6">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">MONTO INICIAL (S/)</label>
              <input type="number" name="montoInicial" class="form-control" min="0" step="0.01" placeholder="0.00" required <%= cajaAbierta ? "disabled" : "" %>>
            </div>
            <div class="col-md-6">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">FECHA Y HORA</label>
              <input type="text" class="form-control" placeholder="Se genera automáticamente" disabled>
            </div>
            <div class="col-12">
              <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">OBSERVACIONES (OPCIONAL)</label>
              <textarea name="observaciones" class="form-control" rows="3" placeholder="Ej: billetes revisados..." <%= cajaAbierta ? "disabled" : "" %>></textarea>
            </div>
          </div>
          <button type="submit" class="btn btn-primary-custom fw-bold mt-4" <%= cajaAbierta ? "disabled" : "" %>>
          <i class="bi bi-unlock-fill"></i> Aperturar caja
          </button>
        </div>
      </div>
    </div>
    <div class="col-lg-5">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-4">
          <h5 class="fw-bold mb-3 title-font">Antes de empezar</h5>
          <ul class="text-muted" style="font-size: 0.9rem; padding-left: 18px;">
            <li class="mb-2">Cuenta el efectivo físico disponible en caja.</li>
            <li class="mb-2">Verifica que el monto coincida con el cierre anterior.</li>
            <li class="mb-2">Registra cualquier diferencia en observaciones.</li>
            <li>Una vez aperturada, podrás usar el Punto de Venta.</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</form>
</section>