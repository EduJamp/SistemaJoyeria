<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String vistaActiva = (String) request.getAttribute("vistaActiva");
    boolean esDashboard = (vistaActiva == null || vistaActiva.isEmpty());
    boolean esConteo = "conteo-productos".equals(request.getAttribute("vistaActiva"));
    boolean esApertura = "apertura-caja".equals(request.getAttribute("vistaActiva"));
    boolean esClientes = "clientes".equals(request.getAttribute("vistaActiva"));
    boolean esPromociones = "promociones".equals(request.getAttribute("vistaActiva"));
%>
<!DOCTYPE html>
<html lang="es" xmlns:jsp="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Liamy Import | Cajero</title>

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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vendedor_vista.css" >

    <script
            src="https://cdn.jsdelivr.net/npm/chart.js">
    </script>

    <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.5/dist/JsBarcode.all.min.js"></script>

</head>

<body>

<!-- NAVBAR -->
<jsp:include page="/view/components/navbar_cajero.jsp" />

<!-- CONTENEDOR PRINCIPAL -->
<div class="main-wrapper">

    <!-- SIDEBAR -->
    <jsp:include page="/view/components/sidebar_cajero.jsp" />

    <!-- CONTENIDO PRINCIPAL -->
    <main class="content-area" id="mainContent" >

        <!-- VISTA DASHBOARD -->
        <section id="view-dashboard" class="view-section <%= esDashboard ? "active" : "" %>">

        <style>
            /* Adaptación automática de textos y tablas para modo oscuro y claro */
            #view-dashboard .text-muted {
                color: var(--text-color) !important;
                opacity: 0.75;
            }
            #view-dashboard .table {
                color: var(--text-color);
            }
            #view-dashboard .custom-card {
                color: var(--text-color);
            }
        </style>

        <!-- ESTADO DE CAJA -->
        <div class="custom-card card border-0 mb-4 position-relative overflow-hidden" style="background: var(--gradient-primary);" >

            <div style="position:absolute; top:-40px; right:-30px; width:160px; height:160px; border-radius:50%; background:rgba(255,255,255,0.08);"></div>
            <div style="position:absolute; bottom:-60px; right:80px; width:120px; height:120px; border-radius:50%; background:rgba(255,255,255,0.06);"></div>

            <div class="card-body p-4 position-relative d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">

                <div>

                    <div class="d-flex align-items-center gap-2 mb-1">

                        <h3 class="fw-bold title-font mb-0" style="color:#ffffff;">
                            Hola, Diego 👋
                        </h3>

                        <span id="dashCajaEstado" class="badge" style="background-color:#22c55e; color:#fff;">
                CAJA ABIERTA
            </span>

                    </div>

                    <p class="mb-0" style="color:rgba(255,255,255,0.85);">
                        Turno iniciado a las 08:00 &middot; Sede Central
                    </p>

                </div>

                <div class="text-md-end">

                    <small class="d-block fw-bold" style="color:rgba(255,255,255,0.7); font-size:0.7rem; letter-spacing:0.5px;">
                        HOY
                    </small>

                    <span class="fw-bold fs-5" style="color:#ffffff;">
            Martes, 09 de septiembre
        </span>

                </div>

            </div>

        </div>

        <!-- KPIs DE CAJA -->
        <div class="row g-4 mb-4">

            <div class="col-sm-6 col-lg-3">

                <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">

                    <div class="card-body p-4">

                        <div class="kpi-decor bg-pink-light"></div>

                        <small class="text-muted fw-bold mb-2 d-block">
                            MONTO DE APERTURA
                        </small>

                        <h2 class="fw-bold mb-1 title-font">
                            S/ 150.00
                        </h2>

                        <span class="text-muted fw-semibold" style="font-size: 0.85rem;">
                <i class="bi bi-clock"></i>
                Aperturada a las 08:00
            </span>

                    </div>

                </div>

            </div>

            <div class="col-sm-6 col-lg-3">

                <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">

                    <div class="card-body p-4">

                        <div class="kpi-decor bg-gray-light"></div>

                        <small class="text-muted fw-bold mb-2 d-block">
                            VENDIDO HOY
                        </small>

                        <h2 class="fw-bold mb-1 title-font">
                            S/ 1,248.90
                        </h2>

                        <span class="text-success fw-semibold" style="font-size: 0.85rem;">
                <i class="bi bi-receipt"></i>
                23 transacciones
            </span>

                    </div>

                </div>

            </div>

            <div class="col-sm-6 col-lg-3">

                <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">

                    <div class="card-body p-4">

                        <div class="kpi-decor bg-pink-light"></div>

                        <small class="text-muted fw-bold mb-2 d-block">
                            EFECTIVO ESPERADO EN CAJA
                        </small>

                        <h2 class="fw-bold mb-1 title-font text-primary-custom">
                            S/ 590.00
                        </h2>

                        <span class="text-muted fw-semibold" style="font-size: 0.85rem;">
                <i class="bi bi-cash-stack"></i>
                Apertura + ventas en efectivo
            </span>

                    </div>

                </div>

            </div>

            <div class="col-sm-6 col-lg-3">

                <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">

                    <div class="card-body p-4">

                        <div class="kpi-decor bg-gray-light"></div>

                        <small class="text-muted fw-bold mb-2 d-block">
                            TICKET PROMEDIO
                        </small>

                        <h2 class="fw-bold mb-1 title-font">
                            S/ 54.30
                        </h2>

                        <span class="text-muted fw-semibold" style="font-size: 0.85rem;">
                <i class="bi bi-graph-up"></i>
                Por comprobante
            </span>

                    </div>

                </div>

            </div>

        </div>

        <!-- DESGLOSE POR MÉTODO DE PAGO + ACCESOS RÁPIDOS -->
        <div class="row g-4 mb-4">

            <!-- MÉTODOS DE PAGO -->
            <div class="col-lg-8">

                <div class="custom-card card border-0 h-100">

                    <div class="card-body p-4">

                        <div class="d-flex justify-content-between align-items-center mb-4">

                            <h5 class="fw-bold mb-0 title-font">
                                Cobros de hoy por método de pago
                            </h5>

                            <span class="badge bg-pink-light text-primary-custom fw-semibold">
                    S/ 1,248.90 en total
                </span>

                        </div>

                        <div class="row g-3">

                            <div class="col-6 col-md-4">
                                <div class="d-flex align-items-center gap-3 p-3" style="border:1px solid var(--border-color); border-radius:12px;">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:50%; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-cash text-primary-custom fs-5"></i>
                        </span>
                                    <div>
                                        <small class="text-muted d-block" style="font-size:0.7rem;">EFECTIVO</small>
                                        <span class="fw-bold">S/ 440.00</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-6 col-md-4">
                                <div class="d-flex align-items-center gap-3 p-3" style="border:1px solid var(--border-color); border-radius:12px;">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:50%; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-credit-card text-primary-custom fs-5"></i>
                        </span>
                                    <div>
                                        <small class="text-muted d-block" style="font-size:0.7rem;">TARJETA</small>
                                        <span class="fw-bold">S/ 389.90</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-6 col-md-4">
                                <div class="d-flex align-items-center gap-3 p-3" style="border:1px solid var(--border-color); border-radius:12px;">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:50%; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-phone text-primary-custom fs-5"></i>
                        </span>
                                    <div>
                                        <small class="text-muted d-block" style="font-size:0.7rem;">YAPE</small>
                                        <span class="fw-bold">S/ 249.00</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-6 col-md-4">
                                <div class="d-flex align-items-center gap-3 p-3" style="border:1px solid var(--border-color); border-radius:12px;">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:50%; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-phone text-primary-custom fs-5"></i>
                        </span>
                                    <div>
                                        <small class="text-muted d-block" style="font-size:0.7rem;">PLIN</small>
                                        <span class="fw-bold">S/ 80.00</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-6 col-md-4">
                                <div class="d-flex align-items-center gap-3 p-3" style="border:1px solid var(--border-color); border-radius:12px;">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:50%; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-bank text-primary-custom fs-5"></i>
                        </span>
                                    <div>
                                        <small class="text-muted d-block" style="font-size:0.7rem;">TRANSACCIÓN</small>
                                        <span class="fw-bold">S/ 60.00</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-6 col-md-4">
                                <div class="d-flex align-items-center gap-3 p-3" style="border:1px solid var(--border-color); border-radius:12px;">
                        <span class="d-flex align-items-center justify-content-center" style="width:38px; height:38px; min-width:38px; border-radius:50%; background: rgba(255,71,126,0.12);">
                            <i class="bi bi-qr-code text-primary-custom fs-5"></i>
                        </span>
                                    <div>
                                        <small class="text-muted d-block" style="font-size:0.7rem;">SIP</small>
                                        <span class="fw-bold">S/ 30.00</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>

            </div>

            <!-- ACCESOS RÁPIDOS -->
            <div class="col-lg-4">

                <div class="custom-card card border-0 h-100">

                    <div class="card-body p-4 d-flex flex-column">

                        <h5 class="fw-bold mb-4 title-font">
                            Accesos rápidos
                        </h5>

                        <a href="#" class="menu-link view-link d-flex align-items-center gap-3 mb-3 text-decoration-none" data-view="pos" style="border:1px solid var(--border-color); padding:14px; color:var(--text-color);">
                            <i class="bi bi-cash-register fs-4 text-primary-custom"></i>
                            <span class="fw-semibold">Ir al Punto de Venta</span>
                            <i class="bi bi-arrow-right ms-auto text-muted"></i>
                        </a>

                        <a href="#" class="menu-link view-link d-flex align-items-center gap-3 mb-3 text-decoration-none" data-view="cierre-caja" style="border:1px solid var(--border-color); padding:14px; color:var(--text-color);">
                            <i class="bi bi-lock fs-4 text-primary-custom"></i>
                            <span class="fw-semibold">Cerrar caja</span>
                            <i class="bi bi-arrow-right ms-auto text-muted"></i>
                        </a>

                        <a href="#" class="menu-link view-link d-flex align-items-center gap-3 text-decoration-none" data-view="apertura" style="border:1px solid var(--border-color); padding:14px; color:var(--text-color);">
                            <i class="bi bi-unlock fs-4 text-primary-custom"></i>
                            <span class="fw-semibold">Ver apertura de caja</span>
                            <i class="bi bi-arrow-right ms-auto text-muted"></i>
                        </a>

                        <div class="mt-auto pt-3">

                            <div class="d-flex align-items-center gap-2 p-3" style="background: rgba(234,179,8,0.08); border-radius: 12px;">
                                <i class="bi bi-exclamation-triangle-fill" style="color:#eab308;"></i>
                                <small style="color: #eab308; font-size:0.8rem;">
                                    Recuerda contar el efectivo antes de cerrar la caja.
                                </small>
                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <!-- VENTAS POR HORA -->
        <div class="custom-card card border-0 mb-4">

            <div class="card-body p-4">

                <h5 class="fw-bold mb-4 title-font">
                    Ritmo de cobros &middot; hoy por hora
                </h5>

                <div style="position: relative; height: 260px; width: 100%;">

                    <canvas id="ventasHoraChart"></canvas>

                </div>

            </div>

        </div>

        <!-- ÚLTIMOS MOVIMIENTOS DE CAJA -->
        <div class="custom-card card border-0">

            <div class="card-body p-4">

                <div class="d-flex justify-content-between align-items-center mb-4">

                    <h5 class="fw-bold title-font mb-0">
                        Últimos movimientos
                    </h5>

                    <a href="#" class="menu-link view-link fw-semibold p-0" data-view="pos" style="width:auto; color: var(--primary-custom);">
                        Ir al POS
                        <i class="bi bi-arrow-right ms-1"></i>
                    </a>

                </div>

                <div class="table-responsive">

                    <table class="table custom-table table-hover align-middle text-nowrap mb-0">

                        <thead>
                        <tr>
                            <th>HORA</th>
                            <th>COMPROBANTE</th>
                            <th>CLIENTE</th>
                            <th>MÉTODO DE PAGO</th>
                            <th>TOTAL</th>
                        </tr>
                        </thead>

                        <tbody>

                        <tr>
                            <td>11:42</td>
                            <td class="text-primary-custom fw-bold">B001-000531</td>
                            <td>Rosa Fernández</td>
                            <td>Efectivo</td>
                            <td class="fw-bold">S/ 45.00</td>
                        </tr>

                        <tr>
                            <td>11:20</td>
                            <td class="text-primary-custom fw-bold">B001-000530</td>
                            <td>Cliente varios</td>
                            <td>Yape</td>
                            <td class="fw-bold">S/ 89.90</td>
                        </tr>

                        <tr>
                            <td>10:58</td>
                            <td class="text-primary-custom fw-bold">B001-000529</td>
                            <td>Carlos Injante</td>
                            <td>Tarjeta</td>
                            <td class="fw-bold">S/ 159.90</td>
                        </tr>

                        <tr>
                            <td>10:15</td>
                            <td class="text-primary-custom fw-bold">B001-000528</td>
                            <td>Ana Chávez</td>
                            <td>Plin</td>
                            <td class="fw-bold">S/ 32.00</td>
                        </tr>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

        </section>

        <!-- VISTA CONTEO DE PRODUCTOS (KARDEX) -->
        <jsp:include page="/view/cajero_vistas/VKardexCajero.jsp" />

        <!-- VISTA DE APERTURA DE CAJA -->
        <jsp:include page="/view/cajero_vistas/VAperturaCaja.jsp" />

        <!-- VISTA PUNTO DE VENTA (POS) -->
        <jsp:include page="/view/cajero_vistas/VPuntoVentaCajero.jsp" />

        <!-- VISTA CIERRE DE CAJA -->
        <jsp:include page="/view/cajero_vistas/VCierreCajaCajero.jsp" />

        <!-- VISTA CLIENTES -->
        <jsp:include page="/view/cajero_vistas/VClientesCajero.jsp" />

        <!-- VISTA PROMOCIONES -->
        <jsp:include page="/view/cajero_vistas/VPromocionesCajero.jsp" />

    </main>

</div>

<!-- BOOTSTRAP JAVASCRIPT -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
</script>

<!-- JAVASCRIPT PROPIO -->
<script
        src="${pageContext.request.contextPath}/javascript/vendedor_vista.js">
</script>

<!-- INICIALIZACIÓN DE GRÁFICOS -->
<script>
// Gráfico: "Ritmo de cobros · hoy por hora" (dashboard cajero)
        const ventasHoraCanvas = document.getElementById('ventasHoraChart');

        if (ventasHoraCanvas && typeof Chart !== 'undefined') {

            new Chart(ventasHoraCanvas, {
                type: 'bar',
                data: {
                    labels: ['08h', '09h', '10h', '11h', '12h', '13h', '14h', '15h', '16h', '17h', '18h'],
                    datasets: [{
                        label: 'Cobrado',
                        data: [45.00, 120.50, 189.90, 284.90, 210.00, 0, 0, 0, 0, 0, 0],
                        backgroundColor: '#ff477e',
                        borderRadius: 6,
                        maxBarThickness: 32
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            callbacks: {
                                label: (context) => 'S/ ' + context.parsed.y.toFixed(2)
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false }
                        },
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(148, 163, 184, 0.15)' },
                            ticks: {
                                callback: (value) => 'S/ ' + value
                            }
                        }
                    }
                }
            });
        }

</script>

</body>

</html>