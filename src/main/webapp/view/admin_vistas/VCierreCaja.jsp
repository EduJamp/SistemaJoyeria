<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% boolean esCierre = "cierre-caja".equals(request.getAttribute("vistaActiva")); %>

<section id="view-cierre-caja" class="view-section <%= esCierre ? "active" : "" %>">
<div class="mb-4">
  <h3 class="fw-bold title-font mb-1">Cierre de Caja</h3>
  <p class="text-muted">Cuadra el efectivo físico contra lo registrado en el sistema.</p>
</div>

<form action="<%= request.getContextPath() %>/svcaja" method="POST">
  <input type="hidden" name="accion" value="cerrar">
  <div class="row g-4">
    <div class="col-lg-7">
      <div class="custom-card card border-0">
        <div class="card-body p-4">
          <h5 class="fw-bold mb-4 title-font">Cuadre de caja</h5>
          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <small class="text-muted d-block fw-bold" style="font-size: 0.7rem;">MONTO DE APERTURA</small>
              <span class="fw-bold fs-5">S/ 500.00</span>
            </div>
            <div class="col-md-6">
              <small class="text-muted d-block fw-bold" style="font-size: 0.7rem;">VENTAS DEL TURNO</small>
              <span class="fw-bold fs-5">S/ 1,500.50</span>
            </div>
            <div class="col-md-6">
              <small class="text-muted d-block fw-bold" style="font-size: 0.7rem;">TOTAL ESPERADO EN CAJA</small>
              <span class="fw-bold fs-5 text-primary-custom">S/ 2,000.50</span>
            </div>
          </div>
          <hr style="border-color: var(--border-color);">

          <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">EFECTIVO CONTADO FÍSICAMENTE (S/)</label>
          <input type="number" name="montoFisico" class="form-control mb-3" min="0" step="0.01" placeholder="0.00" required>

          <label class="form-label text-muted fw-bold" style="font-size: 0.75rem;">OBSERVACIONES (OPCIONAL)</label>
          <textarea name="observacionesCierre" class="form-control mb-4" rows="3" placeholder="Ej: faltante por vuelto mal dado..."></textarea>

          <button type="submit" class="btn btn-primary-custom fw-bold">
            <i class="bi bi-lock-fill"></i> Cerrar caja
          </button>
        </div>
      </div>
    </div>
    <div class="col-lg-5">
      <div class="custom-card card border-0 h-100">
        <div class="card-body p-4">
          <h5 class="fw-bold mb-3 title-font">Recomendaciones</h5>
          <ul class="text-muted" style="font-size: 0.9rem; padding-left: 18px;">
            <li class="mb-2">Cuenta el efectivo dos veces antes de registrar el monto.</li>
            <li class="mb-2">Si hay diferencia, anótala en observaciones con el motivo.</li>
            <li>Al cerrar, la caja quedará bloqueada hasta la próxima apertura.</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</form>
</section>