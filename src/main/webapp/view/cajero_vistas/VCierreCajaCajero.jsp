<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.liamyimport.model.Caja" %>

<%
boolean esCierre = "cierre-caja".equals(request.getAttribute("vistaActiva"));
Caja cajaActual = (Caja) request.getAttribute("cajaActual");

// Verificar si hay una caja abierta actualmente
boolean cajaAbierta = (cajaActual != null && "ABIERTA".equalsIgnoreCase(cajaActual.getEstado()));

// Valores de simulación sincronizados con el SvCaja
double montoApertura = cajaAbierta ? cajaActual.getMontoInicial() : 0.0;
double ventasSistema = 1500.50; // Sincronizado con el cálculo de tu SvCaja
double totalEsperado = montoApertura + ventasSistema;
%>

<section id="view-cierre-caja" class="view-section <%= esCierre ? "active" : "" %>">

<div class="mb-4">
    <h3 class="fw-bold title-font mb-1" style="color: var(--text-color);">
        Cierre de Caja
    </h3>
    <p class="mb-0" style="color: var(--text-color); opacity: 0.75;">
        Cuadra el efectivo físico contra lo registrado en el sistema.
    </p>
</div>

<% if (!cajaAbierta) { %>
<!-- ALERTA SI NO HAY CAJA ABIERTA -->
<div class="alert alert-warning mb-4 shadow-sm" role="alert">
    <h4 class="alert-heading fw-bold"><i class="bi bi-exclamation-triangle-fill me-2"></i>No hay una caja abierta</h4>
    <p class="mb-0">Para poder realizar el cuadre y cierre, primero debes aperturar una caja en el módulo correspondiente.</p>
    <hr>
    <a href="<%= request.getContextPath() %>/svcaja?view=apertura-caja" class="btn btn-sm btn-warning fw-bold text-dark">Ir a Apertura de Caja</a>
</div>
<% } %>

<div class="row g-4">

    <div class="col-lg-7">

        <div class="custom-card card border-0" style="background-color: var(--card-bg); color: var(--text-color);">

            <div class="card-body p-4">

                <h5 class="fw-bold mb-4 title-font" style="color: var(--text-color);">
                    Cuadre de caja <%= cajaAbierta ? "(" + cajaActual.getSede() + " - Resp: " + cajaActual.getResponsable() + ")" : "" %>
                </h5>

                <!-- Formulario conectado al SvCaja (Acción: cerrar) -->
                <form action="<%= request.getContextPath() %>/svcaja" method="POST">
                    <input type="hidden" name="accion" value="cerrar">

                    <div class="row g-3 mb-3">

                        <div class="col-md-6">
                            <small class="d-block fw-bold" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">MONTO DE APERTURA</small>
                            <span id="cierreApertura" class="fw-bold fs-5" style="color: var(--text-color);">S/ <%= String.format("%.2f", montoApertura) %></span>
                        </div>

                        <div class="col-md-6">
                            <small class="d-block fw-bold" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">VENTAS DEL TURNO (SISTEMA)</small>
                            <span id="cierreVentasSistema" class="fw-bold fs-5" style="color: var(--text-color);">S/ <%= String.format("%.2f", ventasSistema) %></span>
                        </div>

                        <div class="col-md-6">
                            <small class="d-block fw-bold" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">TOTAL ESPERADO EN CAJA</small>
                            <span id="cierreEsperado" class="fw-bold fs-5 text-primary-custom">S/ <%= String.format("%.2f", totalEsperado) %></span>
                        </div>

                    </div>

                    <hr style="border-color: var(--border-color);">

                    <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                        EFECTIVO CONTADO FÍSICAMENTE (S/)
                    </label>

                    <input type="number" id="cierreContado" name="montoFisico" class="form-control mb-3" min="0" step="0.01" placeholder="0.00"
                           oninput="calcularDiferencia(<%= totalEsperado %>)" <%= !cajaAbierta ? "disabled" : "" %>
                    style="background-color: var(--card-bg); color: var(--text-color); border-color: var(--border-color);" required>

                    <div class="mb-4">
                        <small class="d-block fw-bold" style="font-size: 0.7rem; color: var(--text-color); opacity: 0.7;">DIFERENCIA</small>
                        <span id="cierreDiferencia" class="fw-bold fs-5" style="color: var(--text-color);">S/ 0.00</span>
                    </div>

                    <label class="form-label fw-bold" style="font-size: 0.75rem; color: var(--text-color); opacity: 0.8;">
                        OBSERVACIONES (OPCIONAL)
                    </label>

                    <textarea id="cierreObservaciones" name="observacionesCierre" class="form-control mb-4" rows="3" placeholder="Ej: faltante por vuelto mal dado..." <%= !cajaAbierta ? "disabled" : "" %>
                    style="background-color: var(--card-bg); color: var(--text-color); border-color: var(--border-color);"></textarea>

                    <button type="submit" id="btnCerrarCaja" class="btn btn-primary-custom fw-bold <%= !cajaAbierta ? "disabled" : "" %>">
                    <i class="bi bi-lock-fill"></i>
                    Cerrar caja
                    </button>

                </form>

            </div>

        </div>

    </div>

    <div class="col-lg-5">

        <div class="custom-card card border-0 h-100" style="background-color: var(--card-bg); color: var(--text-color);">

            <div class="card-body p-4">

                <h5 class="fw-bold mb-3 title-font" style="color: var(--text-color);">
                    Recomendaciones
                </h5>

                <ul style="font-size: 0.9rem; padding-left: 18px; color: var(--text-color); opacity: 0.8;">
                    <li class="mb-2">Cuenta el efectivo dos veces antes de registrar el monto.</li>
                    <li class="mb-2">Si hay diferencia, anótala en observaciones con el motivo.</li>
                    <li>Al cerrar, la caja quedará bloqueada hasta la próxima apertura.</li>
                </ul>

            </div>

        </div>

    </div>

</div>

</section>

<!-- calcular la diferencia en tiempo real -->
<script>
    function calcularDiferencia(esperado) {
        const contadoInput = document.getElementById('cierreContado').value;
        const diferenciaSpan = document.getElementById('cierreDiferencia');

        if (contadoInput === '') {
            diferenciaSpan.textContent = 'S/ 0.00';
            diferenciaSpan.style.color = 'var(--text-color)';
            return;
        }

        const contado = parseFloat(contadoInput);
        const diferencia = contado - esperado;

        diferenciaSpan.textContent = 'S/ ' + diferencia.toFixed(2);

        if (diferencia < 0) {
            diferenciaSpan.style.color = '#ef4444'; // Rojo si hay faltante
        } else if (diferencia > 0) {
            diferenciaSpan.style.color = '#22c55e'; // Verde si hay sobrante
        } else {
            diferenciaSpan.style.color = 'var(--text-color)';
        }
    }
</script>