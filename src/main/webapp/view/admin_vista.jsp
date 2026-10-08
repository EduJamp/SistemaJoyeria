<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="16kb" autoFlush="true" %>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Producto" %>
<%@ page import="com.liamyimport.model.Empleado" %>
<%@ page import="com.liamyimport.model.Usuario" %>
<%
    String vistaActiva = (String) request.getAttribute("vistaActiva");
    boolean esDashboard = (vistaActiva == null || vistaActiva.isEmpty());
    boolean esProductos = "productos".equals(vistaActiva);
    boolean esCategorias = "categorias".equals(vistaActiva);
    boolean esAuditoria = "auditoria-inventario".equals(vistaActiva);
    boolean esSedes = "sedes".equals(vistaActiva);
    boolean esPromocion = "promociones".equals(request.getAttribute("vistaActiva"));
    boolean esUsuarios = "usuarios".equals(request.getAttribute("vistaActiva"));
    boolean esEmpleados = "empleados".equals(request.getAttribute("vistaActiva"));
%>
<!DOCTYPE html>
<html lang="es" xmlns:jsp="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Liamy Import | Admin</title>

    <script>
        (function () {

            try {

                const savedTheme =
                    localStorage.getItem("liamy-theme");

                const prefersDark =
                    window.matchMedia(
                        "(prefers-color-scheme: dark)"
                    ).matches;

                const theme =
                    savedTheme ||
                    (prefersDark ? "dark" : "light");


                if (theme === "dark") {

                    document.documentElement
                        .setAttribute(
                            "data-theme",
                            "dark"
                        );
                }

            } catch (error) {

                console.error(
                    "Error al cargar tema:",
                    error
                );
            }

        })();
    </script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet" >

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" >

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css" >

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_vista.css" >

    <script
            src="https://cdn.jsdelivr.net/npm/chart.js">
    </script>

</head>


<body>

<!-- NAVBAR -->
<jsp:include page="/view/components/navbar_admin.jsp" />

<!-- CONTENEDOR PRINCIPAL -->
<div class="main-wrapper">

    <!-- SIDEBAR -->
    <jsp:include page="/view/components/sidebar_admin.jsp" />

    <!-- CONTENIDO PRINCIPAL -->
    <main class="content-area" id="mainContent" >

        <!-- VISTA DASHBOARD -->
        <section id="view-dashboard" class="view-section <%= esDashboard ? "active" : "" %>">

            <!-- HEADER -->
            <div class="custom-card card border-0 mb-4 position-relative overflow-hidden" style="background: var(--gradient-primary);" >

                <div style="position:absolute; top:-40px; right:-30px; width:160px; height:160px; border-radius:50%; background:rgba(255,255,255,0.08);"></div>
                <div style="position:absolute; bottom:-60px; right:80px; width:120px; height:120px; border-radius:50%; background:rgba(255,255,255,0.06);"></div>

                <div class="card-body p-4 position-relative d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">

                    <div>

                        <h3 class="fw-bold title-font mb-1" style="color:#ffffff;">
                            Reporte de Rendimiento de Ventas
                        </h3>

                        <p class="mb-0" style="color:rgba(255,255,255,0.85);">
                            Visión consolidada del negocio en todas tus sedes.
                        </p>

                    </div>

                    <div class="d-flex gap-4">

                        <div class="text-md-end">
                            <small class="d-block fw-bold" style="color:rgba(255,255,255,0.7); font-size:0.7rem; letter-spacing:0.5px;">
                                SEDES ACTIVAS
                            </small>
                            <span class="fw-bold fs-4" style="color:#ffffff;">3</span>
                        </div>

                        <div class="text-md-end">
                            <small class="d-block fw-bold" style="color:rgba(255,255,255,0.7); font-size:0.7rem; letter-spacing:0.5px;">
                                VENDEDORES ACTIVOS
                            </small>
                            <span class="fw-bold fs-4" style="color:#ffffff;">6</span>
                        </div>

                    </div>

                </div>

            </div>

            <!-- ACCESOS RÁPIDOS -->
            <div class="row g-3 mb-4">

                <div class="col-6 col-md-4 col-lg-2">
                    <a href="#" class="menu-link view-link d-flex flex-column align-items-center text-center gap-2 h-100" data-view="detalle-ventas" style="border:1px solid var(--border-color); padding:16px 8px;">
                        <i class="bi bi-bar-chart-line fs-3 text-primary-custom"></i>
                        <span class="fw-semibold" style="font-size:0.85rem;">Detalle de Ventas</span>
                    </a>
                </div>

                <div class="col-6 col-md-4 col-lg-2">
                    <a href="#" class="menu-link view-link d-flex flex-column align-items-center text-center gap-2 h-100" data-view="productos" style="border:1px solid var(--border-color); padding:16px 8px;">
                        <i class="bi bi-bag fs-3 text-primary-custom"></i>
                        <span class="fw-semibold" style="font-size:0.85rem;">Productos</span>
                    </a>
                </div>

                <div class="col-6 col-md-4 col-lg-2">
                    <a href="#" class="menu-link view-link d-flex flex-column align-items-center text-center gap-2 h-100" data-view="auditoria-inventario" style="border:1px solid var(--border-color); padding:16px 8px;">
                        <i class="bi bi-clipboard-check fs-3 text-primary-custom"></i>
                        <span class="fw-semibold" style="font-size:0.85rem;">Auditoria de Inventario</span>
                    </a>
                </div>

                <div class="col-6 col-md-4 col-lg-2">
                    <a href="#" class="menu-link view-link d-flex flex-column align-items-center text-center gap-2 h-100" data-view="clientes" style="border:1px solid var(--border-color); padding:16px 8px;">
                        <i class="bi bi-people fs-3 text-primary-custom"></i>
                        <span class="fw-semibold" style="font-size:0.85rem;">Clientes</span>
                    </a>
                </div>

                <div class="col-6 col-md-4 col-lg-2">
                    <a href="#" class="menu-link view-link d-flex flex-column align-items-center text-center gap-2 h-100" data-view="promociones" style="border:1px solid var(--border-color); padding:16px 8px;">
                        <i class="bi bi-megaphone fs-3 text-primary-custom"></i>
                        <span class="fw-semibold" style="font-size:0.85rem;">Promociones</span>
                    </a>
                </div>

                <div class="col-6 col-md-4 col-lg-2">
                    <a href="#" class="menu-link view-link d-flex flex-column align-items-center text-center gap-2 h-100" data-view="pos" style="border:1px solid var(--border-color); padding:16px 8px;">
                        <i class="bi bi-credit-card-2-front fs-3 text-primary-custom"></i>
                        <span class="fw-semibold" style="font-size:0.85rem;">Punto de Venta</span>
                    </a>
                </div>

            </div>

            <!-- KPIs -->
            <div class="row g-4 mb-4">

                <div class="col-sm-6 col-lg-3">
                    <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
                        <div class="card-body p-4">
                            <div class="kpi-decor bg-pink-light"></div>
                            <small class="text-muted fw-bold mb-2 d-block">TOTAL RECAUDADO</small>
                            <h2 class="fw-bold mb-1 title-font">S/ 1,842,580.00</h2>
                            <span class="text-success fw-semibold" style="font-size: 0.85rem;">
                        <i class="bi bi-arrow-up-right"></i>
                        15% vs año anterior
                    </span>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3">
                    <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
                        <div class="card-body p-4">
                            <div class="kpi-decor bg-gray-light"></div>
                            <small class="text-muted fw-bold mb-2 d-block">TICKET PROMEDIO</small>
                            <h2 class="fw-bold mb-1 title-font">S/ 512.40</h2>
                            <span class="text-muted fw-semibold" style="font-size: 0.85rem;">
                        <i class="bi bi-building"></i>
                        Consolidado nacional
                    </span>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3">
                    <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
                        <div class="card-body p-4">
                            <div class="kpi-decor bg-pink-light"></div>
                            <small class="text-muted fw-bold mb-2 d-block">COMPROBANTE LÍDER</small>
                            <h2 class="fw-bold mb-1 title-font">Factura</h2>
                            <span class="text-primary-custom fw-semibold" style="font-size: 0.85rem;">
                        <i class="bi bi-record-circle"></i>
                        58% de ingresos
                    </span>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3">
                    <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">
                        <div class="card-body p-4">
                            <div class="kpi-decor bg-gray-light"></div>
                            <small class="text-muted fw-bold mb-2 d-block">CLIENTES NUEVOS</small>
                            <h2 class="fw-bold mb-1 title-font">38</h2>
                            <span class="text-success fw-semibold" style="font-size: 0.85rem;">
                        <i class="bi bi-person-plus"></i>
                        Este mes
                    </span>
                        </div>
                    </div>
                </div>

            </div>

            <!-- EVOLUCIÓN DE VENTAS + MÉTODOS DE PAGO -->
            <div class="row g-4 mb-4">

                <div class="col-lg-8">
                    <div class="custom-card card border-0 h-100">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4 title-font">Evolución Anual de Ventas</h5>
                            <div style="position: relative; height: 300px; width: 100%;">
                                <canvas id="salesChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="custom-card card border-0 h-100">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4 title-font">Métodos de Pago</h5>
                            <div style="position: relative; height: 220px; width: 100%; display: flex; justify-content: center;">
                                <canvas id="paymentChart"></canvas>
                            </div>

                            <div class="chart-legend">
                                <div class="chart-legend-item">
                                    <span class="legend-dot" style="background-color:#ff477e;"></span>
                                    Tarjeta <strong class="ms-1">45%</strong>
                                </div>
                                <div class="chart-legend-item">
                                    <span class="legend-dot" style="background-color:#a68a00;"></span>
                                    Efectivo <strong class="ms-1">30%</strong>
                                </div>
                                <div class="chart-legend-item">
                                    <span class="legend-dot" style="background-color:#4b5563;"></span>
                                    Yape <strong class="ms-1">15%</strong>
                                </div>
                                <div class="chart-legend-item">
                                    <span class="legend-dot" style="background-color:#f6b8d0;"></span>
                                    Plin <strong class="ms-1">10%</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- VENTAS POR SEDE + TOP VENDEDORES -->
            <div class="row g-4 mb-4">

                <!-- VENTAS POR SEDE -->
                <div class="col-lg-6">
                    <div class="custom-card card border-0 h-100">
                        <div class="card-body p-4">

                            <h5 class="fw-bold mb-4 title-font">Ventas por sede</h5>

                            <div class="mb-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="fw-semibold">Sede Central</span>
                                    <span class="fw-bold">S/ 980,400.00</span>
                                </div>
                                <div class="progress" style="height: 8px; border-radius: 20px; background-color: var(--border-color);">
                                    <div class="progress-bar" style="width: 53%; background-color: var(--primary-custom); border-radius: 20px;"></div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="fw-semibold">Miraflores</span>
                                    <span class="fw-bold">S/ 542,180.00</span>
                                </div>
                                <div class="progress" style="height: 8px; border-radius: 20px; background-color: var(--border-color);">
                                    <div class="progress-bar" style="width: 29%; background-color: var(--primary-custom); border-radius: 20px;"></div>
                                </div>
                            </div>

                            <div>
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="fw-semibold">San Isidro</span>
                                    <span class="fw-bold">S/ 320,000.00</span>
                                </div>
                                <div class="progress" style="height: 8px; border-radius: 20px; background-color: var(--border-color);">
                                    <div class="progress-bar" style="width: 18%; background-color: var(--primary-custom); border-radius: 20px;"></div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- TOP VENDEDORES -->
                <div class="col-lg-6">
                    <div class="custom-card card border-0 h-100">
                        <div class="card-body p-4">

                            <h5 class="fw-bold mb-4 title-font">Top vendedores del mes</h5>

                            <div class="d-flex align-items-center gap-3 mb-3">
                                <span class="d-flex align-items-center justify-content-center fw-bold" style="width:32px; height:32px; min-width:32px; border-radius:50%; background: var(--gradient-primary); color:#fff; font-size:0.85rem;">1</span>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block">Luciana R.</span>
                                    <small class="text-muted">Sede Central</small>
                                </div>
                                <span class="fw-bold text-primary-custom">S/ 12,480.00</span>
                            </div>

                            <div class="d-flex align-items-center gap-3 mb-3">
                                <span class="d-flex align-items-center justify-content-center fw-bold" style="width:32px; height:32px; min-width:32px; border-radius:50%; background: var(--border-color); color: var(--text-heading); font-size:0.85rem;">2</span>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block">Diego M.</span>
                                    <small class="text-muted">Sede Central</small>
                                </div>
                                <span class="fw-bold text-primary-custom">S/ 9,940.00</span>
                            </div>

                            <div class="d-flex align-items-center gap-3">
                                <span class="d-flex align-items-center justify-content-center fw-bold" style="width:32px; height:32px; min-width:32px; border-radius:50%; background: var(--border-color); color: var(--text-heading); font-size:0.85rem;">3</span>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block">Mariana S.</span>
                                    <small class="text-muted">Miraflores</small>
                                </div>
                                <span class="fw-bold text-primary-custom">S/ 7,210.00</span>
                            </div>

                        </div>
                    </div>
                </div>

            </div>

            <!-- TOP PRODUCTOS + ALERTAS -->
            <div class="row g-4 mb-4">

                <!-- TOP PRODUCTOS -->
                <div class="col-lg-6">
                    <div class="custom-card card border-0 h-100">
                        <div class="card-body p-4">

                            <h5 class="fw-bold mb-4 title-font">Productos más vendidos</h5>

                            <div class="d-flex align-items-center gap-3 mb-3">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:10px; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-gem text-primary-custom"></i>
                        </span>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block">Aretes de Plata 950 Gota</span>
                                    <small class="text-muted">142 unidades vendidas</small>
                                </div>
                                <span class="fw-bold">S/ 6,390.00</span>
                            </div>

                            <div class="d-flex align-items-center gap-3 mb-3">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:10px; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-link-45deg text-primary-custom"></i>
                        </span>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block">Cadena de Acero Cubana</span>
                                    <small class="text-muted">98 unidades vendidas</small>
                                </div>
                                <span class="fw-bold">S/ 7,830.20</span>
                            </div>

                            <div class="d-flex align-items-center gap-3">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:10px; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-gem text-primary-custom"></i>
                        </span>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block">Anillo con Circonia Solitario</span>
                                    <small class="text-muted">76 unidades vendidas</small>
                                </div>
                                <span class="fw-bold">S/ 4,940.00</span>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- ALERTAS Y PENDIENTES -->
                <div class="col-lg-6">
                    <div class="custom-card card border-0 h-100">
                        <div class="card-body p-4">

                            <h5 class="fw-bold mb-4 title-font">Requiere tu atención</h5>

                            <div class="d-flex align-items-start gap-3 mb-3 p-3" style="background: rgba(239,68,68,0.06); border-radius: 12px;">
                                <i class="bi bi-exclamation-triangle-fill" style="color:#ef4444;"></i>
                                <div>
                                    <span class="fw-semibold d-block">2 productos sin stock</span>
                                    <small class="text-muted">Pulsera de Cuero, Gorra Classic</small>
                                </div>
                            </div>

                            <div class="d-flex align-items-start gap-3 mb-3 p-3" style="background: rgba(234,179,8,0.08); border-radius: 12px;">
                                <i class="bi bi-clock-history" style="color:#eab308;"></i>
                                <div>
                                    <span class="fw-semibold d-block">1 caja abierta hace más de 10h</span>
                                    <small class="text-muted">Sede Miraflores &middot; Diego M.</small>
                                </div>
                            </div>

                            <div class="d-flex align-items-start gap-3" style="background: rgba(255,71,126,0.06); border-radius: 12px; padding: 12px;">
                                <i class="bi bi-clipboard-x" style="color: var(--primary-custom);"></i>
                                <div>
                                    <span class="fw-semibold d-block">3 diferencias de conteo sin revisar</span>
                                    <small class="text-muted">Pérdida estimada: S/ 128.00</small>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>

            <!-- TABLA DE TRANSACCIONES -->
            <div class="custom-card card border-0 mb-4">

                <div class="card-body p-4">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold title-font mb-0">Detalle de Transacciones</h5>
                        <button type="button" class="btn btn-outline-secondary btn-sm fw-semibold">
                            <i class="bi bi-download"></i>
                            Exportar CSV
                        </button>
                    </div>

                    <div class="table-responsive">

                        <table class="table custom-table table-hover align-middle text-nowrap mb-0">

                            <thead>
                            <tr>
                                <th>FECHA Y HORA</th>
                                <th>SEDE</th>
                                <th>COMPROBANTE</th>
                                <th>CLIENTE</th>
                                <th>VENDEDOR</th>
                                <th>TOTAL</th>
                                <th class="text-end">ACCIÓN</th>
                            </tr>
                            </thead>

                            <tbody>

                            <tr>
                                <td>12/10/2023 14:25</td>
                                <td>Miraflores</td>
                                <td class="text-primary-custom fw-bold">B001-000452</td>
                                <td>Alessandra Valdivia</td>
                                <td>Luciana R.</td>
                                <td class="fw-bold">S/ 1,250.00</td>
                                <td class="text-end">
                                    <button type="button" class="btn btn-link text-primary-custom p-0" title="Ver detalle">
                                        <i class="bi bi-eye fs-5"></i>
                                    </button>
                                </td>
                            </tr>

                            <tr>
                                <td>12/10/2023 15:40</td>
                                <td>Sede Central</td>
                                <td class="text-primary-custom fw-bold">B002-000128</td>
                                <td>Mauricio Pazos</td>
                                <td>Diego M.</td>
                                <td class="fw-bold">S/ 480.00</td>
                                <td class="text-end">
                                    <button type="button" class="btn btn-link text-primary-custom p-0" title="Ver detalle">
                                        <i class="bi bi-eye fs-5"></i>
                                    </button>
                                </td>
                            </tr>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </section>

        <!-- VISTA PRODUCTOS -->
        <jsp:include page="/view/admin_vistas/VProductos.jsp" />

        <!-- VISTA CATEGORÍAS -->
        <jsp:include page="/view/admin_vistas/VCategoria.jsp" />

        <!-- AUDITORIA DE INVENTARIO -->
        <jsp:include page="/view/admin_vistas/VAuditoriaInventario.jsp" />

        <!-- VISTA SEDES -->
        <jsp:include page="/view/admin_vistas/VSede.jsp" />

        <!-- VISTA EMPLEADO -->
        <jsp:include page="/view/admin_vistas/VEmpleado.jsp" />

        <!-- VISTA NUEVA VENTA -->
        <jsp:include page="/view/admin_vistas/VNuevaVenta.jsp" />

        <!-- VISTA MIS VENTA -->
        <jsp:include page="/view/admin_vistas/VMisVentas.jsp" />

        <!-- VISTA DETALLE DE VENTA -->
        <jsp:include page="/view/admin_vistas/VDetalleVentas.jsp" />

        <!-- VISTA APERTURA DE CAJA -->
        <jsp:include page="/view/admin_vistas/VAperturaCaja.jsp" />

        <!-- VISTA PUNTO DE VENTA -->
        <jsp:include page="/view/admin_vistas/VPuntoVenta.jsp" />

        <!-- VISTA CIERRE DE CAJA -->
        <jsp:include page="/view/admin_vistas/VCierreCaja.jsp" />

        <!-- VISTA CLIENTE -->
        <jsp:include page="/view/admin_vistas/VCliente.jsp" />

        <!-- VISTA PROMOCION -->
        <jsp:include page="/view/admin_vistas/VPromocion.jsp" />

        <!-- VISTA USUARIO -->
        <jsp:include page="/view/admin_vistas/VUsuario.jsp" />

    </main>

</div>

<!-- BOOTSTRAP JAVASCRIPT -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
</script>

<!-- JAVASCRIPT PROPIO -->
<script
        src="${pageContext.request.contextPath}/javascript/admin_vista.js">
</script>

<!-- INICIALIZACIÓN DE GRÁFICOS (Chart.js) -->
<script>
    document.addEventListener("DOMContentLoaded", function () {

        if (typeof Chart === "undefined") {
            return;
        }

        const salesCanvas = document.getElementById("salesChart");

        if (salesCanvas) {
            new Chart(salesCanvas, {
                type: "line",
                data: {
                    labels: ["ENE", "FEB", "MAR", "ABR", "MAY", "JUN", "JUL", "AGO", "SEP", "OCT", "NOV", "DIC"],
                    datasets: [{
                        label: "Ingresos",
                        data: [95000, 108000, 102000, 118000, 125000, 132000, 140000, 138000, 150000, 158000, 165000, 172000],
                        borderColor: "#ff477e",
                        backgroundColor: "rgba(255, 71, 126, 0.12)",
                        borderWidth: 3,
                        fill: true,
                        tension: 0.35,
                        pointRadius: 3,
                        pointBackgroundColor: "#ff477e",
                        pointBorderColor: "#ffffff",
                        pointBorderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            callbacks: {
                                label: (context) => "S/ " + context.parsed.y.toLocaleString()
                            }
                        }
                    },
                    scales: {
                        x: { grid: { display: false } },
                        y: {
                            beginAtZero: true,
                            grid: { color: "rgba(148, 163, 184, 0.15)" },
                            ticks: { callback: (value) => "S/ " + value.toLocaleString() }
                        }
                    }
                }
            });
        } // CORRECCIÓN 1: Faltaba esta llave de cierre.

        const paymentCanvas = document.getElementById("paymentChart");

        if (paymentCanvas) {
            new Chart(paymentCanvas, {
                type: "doughnut",
                data: {
                    labels: ["Tarjeta", "Efectivo", "Yape", "Plin"],
                    datasets: [{
                        data: [45, 30, 15, 10],
                        backgroundColor: ["#ff477e", "#a68a00", "#4b5563", "#f6b8d0"],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: "65%",
                    plugins: {
                        legend: { display: false }
                    }
                }
            });
        }

        // Clientes (ADMIN): alta de nuevo cliente
        const btnGuardarCliente = document.getElementById('btnGuardarCliente');

        if (btnGuardarCliente) {
            const clientesBody = document.getElementById('clientesBody');
            const kpiTotalClientes = document.getElementById('kpiTotalClientes');
            const kpiClientesActivos = document.getElementById('kpiClientesActivos');
            const nuevoClienteModalEl = document.getElementById('nuevoClienteModal');
            const nuevoClienteModal = bootstrap.Modal.getOrCreateInstance(nuevoClienteModalEl);

            const getIniciales = (nombre) => {
                const partes = nombre.trim().split(' ').filter(Boolean);
                const iniciales = partes.slice(0, 2).map((p) => p.charAt(0).toUpperCase());
                return iniciales.join('') || '??';
            };

            btnGuardarCliente.addEventListener('click', () => {

                const tipoDocumento = document.getElementById('ncTipoDocumento').value;
                const numeroDocumento = document.getElementById('ncNumeroDocumento').value.trim();
                const nombre = document.getElementById('ncNombre').value.trim();
                const telefono = document.getElementById('ncTelefono').value.trim();
                const correo = document.getElementById('ncCorreo').value.trim();
                const sede = document.getElementById('ncSede').value;

                // CORRECCIÓN 2: Declarar la variable 'vendedor'.
                // Si tienes un input para el vendedor en tu HTML, usa la siguiente línea en su lugar:
                // const vendedor = document.getElementById('ncVendedor').value;
                const vendedor = "Sin asignar";

                if (!numeroDocumento || !nombre || !telefono) {
                    alert('Completa al menos documento, nombre y teléfono.');
                    return;
                }

                const hoy = new Date();
                const fechaHoy = String(hoy.getDate()).padStart(2, '0') + '/' +
                    String(hoy.getMonth() + 1).padStart(2, '0') + '/' +
                    hoy.getFullYear();

                const fila = document.createElement('tr');

                fila.innerHTML =
                    '<td><div class="d-flex align-items-center gap-2">' +
                    '<span class="avatar" style="width:32px; height:32px; min-width:32px; font-size:0.8rem;">' + getIniciales(nombre) + '</span>' +
                    '<span class="fw-semibold">' + nombre + '</span></div></td>' +
                    '<td>' + tipoDocumento + ' ' + numeroDocumento + '</td>' +
                    '<td>' + (telefono || '—') + '</td>' +
                    '<td>' + (correo || '—') + '</td>' +
                    '<td>' + sede + '</td>' +
                    '<td>' + vendedor + '</td>' +
                    '<td class="text-center fw-bold">0</td>' +
                    '<td class="fw-bold text-primary-custom">S/ 0.00</td>' +
                    '<td>' + fechaHoy + '</td>' +
                    '<td><span class="badge" style="background-color:#22c55e;">Activo</span></td>' +
                    '<td class="text-end">' +
                    '<button type="button" class="btn btn-link text-primary-custom p-0 me-2" title="Ver detalle" onclick="alert(\'Este cliente aún no tiene un modal de detalle propio: crea uno con este mismo ID cuando lo guardes en tu backend.\')">' +
                    '<i class="bi bi-eye fs-5"></i></button>' +
                    '<button type="button" class="btn btn-link text-muted p-0" title="Editar" onclick="alert(\'Conecta esto a un formulario de edición precargado con los datos del cliente.\')">' +
                    '<i class="bi bi-pencil fs-5"></i></button>' +
                    '</td>';

                clientesBody.appendChild(fila);

                kpiTotalClientes.textContent = Number(kpiTotalClientes.textContent) + 1;
                kpiClientesActivos.textContent = Number(kpiClientesActivos.textContent) + 1;

                nuevoClienteModal.hide();

                // Reset del formulario
                document.getElementById('ncNumeroDocumento').value = '';
                document.getElementById('ncNombre').value = '';
                document.getElementById('ncTelefono').value = '';
                document.getElementById('ncCorreo').value = '';

                // Nota: Aquí tenías 'ncDireccion', pero no lo estabas capturando arriba.
                // Si existe en tu HTML, asegúrate de añadirlo arriba si lo necesitas.
                const direccionInput = document.getElementById('ncDireccion');
                if(direccionInput) direccionInput.value = '';
            });
        }

    });
    document.addEventListener("click", function (event) {
        // Verificamos si el clic fue en el botón o dentro del botón con la clase 'btn-toggle-pass'
        const btn = event.target.closest(".btn-toggle-pass");
        if (!btn) return;

        // Obtenemos el ID del input que debe cambiar mediante el atributo data-target
        const targetId = btn.getAttribute("data-target");
        const passwordInput = document.getElementById(targetId);

        if (passwordInput) {
            const icon = btn.querySelector("i");

            // Alternamos entre type="password" y type="text"
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                // Cambiamos el icono de ojo abierto a ojo tachado (Bootstrap Icons)
                if (icon) {
                    icon.classList.remove("bi-eye");
                    icon.classList.add("bi-eye-slash");
                }
            } else {
                passwordInput.type = "password";
                // Regresamos el icono a ojo normal
                if (icon) {
                    icon.classList.remove("bi-eye-slash");
                    icon.classList.add("bi-eye");
                }
            }
        }
    });
</script>

</body>

</html>
