<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.liamyimport.model.Producto" %>
<%@ page import="com.liamyimport.util.csv.ProductoRepository" %>

<%
  String vistaActiva = (String) request.getAttribute("vistaActiva");
  boolean esVDashboard = (vistaActiva == null || vistaActiva.isEmpty());
  boolean esProductos = "productos".equals(vistaActiva);
  boolean esClientes = "clientes".equals(request.getAttribute("vistaActiva"));
  boolean esPromociones = "promociones".equals(request.getAttribute("vistaActiva"));
%>

<!DOCTYPE html>
<html lang="es" xmlns:jsp="http://www.w3.org/1999/XSL/Transform">
<head>
  <meta charset="UTF-8">

  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>Liamy Import | Vendedor</title>

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

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cajero_vista.css" >

  <script
          src="https://cdn.jsdelivr.net/npm/chart.js">
  </script>

  <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.5/dist/JsBarcode.all.min.js"></script>

</head>

<body>

<!--NAVBAR -->
<jsp:include page="/view/components/navbar_vendedor.jsp" />

<!-- CONTENEDOR PRINCIPAL -->
<div class="main-wrapper">

  <!-- SIDEBAR -->
  <jsp:include page="/view/components/sidebar_vendedor.jsp" />

  <!-- CONTENIDO PRINCIPAL -->
  <main class="content-area" id="mainContent" >

    <!-- VISTA DASHBOARD -->
    <section id="view-dashboard" class="view-section <%= esVDashboard ? "active" : "" %>">

    <!-- HEADER DE BIENVENIDA -->
    <div class="custom-card card border-0 mb-4 position-relative overflow-hidden" style="background: var(--gradient-primary);" >

      <!-- Decoración -->
      <div style="position:absolute; top:-40px; right:-30px; width:160px; height:160px; border-radius:50%; background:rgba(255,255,255,0.08);"></div>
      <div style="position:absolute; bottom:-60px; right:80px; width:120px; height:120px; border-radius:50%; background:rgba(255,255,255,0.06);"></div>

      <div class="card-body p-4 position-relative d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">

        <div>

          <h3 class="fw-bold title-font mb-1" style="color:#ffffff;">
            Hola, Usuario
          </h3>

          <p class="mb-0" style="color:rgba(255,255,255,0.85);">
            Aquí tienes el resumen de tu desempeño en ventas.
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

    <!-- KPIs -->
    <div class="row g-4 mb-4">

      <div class="col-sm-6 col-lg-3">

        <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">

          <div class="card-body p-4">

            <div class="kpi-decor bg-pink-light"></div>

            <small class="fw-bold mb-2 d-block" style="color: var(--text-color); opacity: 0.7;">
              VENTAS DE HOY
            </small>

            <h2 class="fw-bold mb-1 title-font" style="color: var(--text-color);">
              S/ 469.40
            </h2>

            <span class="text-success fw-semibold" style="font-size: 0.85rem;">
                    <i class="bi bi-arrow-up-right"></i>
                    8 ventas registradas
                </span>

          </div>

        </div>

      </div>

      <div class="col-sm-6 col-lg-3">

        <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">

          <div class="card-body p-4">

            <div class="kpi-decor bg-gray-light"></div>

            <small class="fw-bold mb-2 d-block" style="color: var(--text-color); opacity: 0.7;">
              VENTAS DEL MES
            </small>

            <h2 class="fw-bold mb-1 title-font" style="color: var(--text-color);">
              S/ 8,540.00
            </h2>

            <span class="fw-semibold" style="font-size: 0.85rem; color: var(--text-color); opacity: 0.7;">
                    <i class="bi bi-calendar3"></i>
                    Setiembre 2026
                </span>

          </div>

        </div>

      </div>

      <div class="col-sm-6 col-lg-3">

        <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">

          <div class="card-body p-4">

            <div class="kpi-decor bg-pink-light"></div>

            <small class="fw-bold mb-2 d-block" style="color: var(--text-color); opacity: 0.7;">
              TICKET PROMEDIO
            </small>

            <h2 class="fw-bold mb-1 title-font" style="color: var(--text-color);">
              S/ 58.70
            </h2>

            <span class="fw-semibold" style="font-size: 0.85rem; color: var(--text-color); opacity: 0.7;">
                    <i class="bi bi-receipt"></i>
                    Por comprobante
                </span>

          </div>

        </div>

      </div>

      <div class="col-sm-6 col-lg-3">

        <div class="custom-card card border-0 kpi-card position-relative overflow-hidden h-100">

          <div class="card-body p-4">

            <div class="kpi-decor bg-gray-light"></div>

            <small class="fw-bold mb-2 d-block" style="color: var(--text-color); opacity: 0.7;">
              RANKING EN TU SEDE
            </small>

            <h2 class="fw-bold mb-1 title-font" style="color: var(--text-color);">
              #2
            </h2>

            <span class="text-primary-custom fw-semibold" style="font-size: 0.85rem;">
                    <i class="bi bi-trophy"></i>
                    de 6 vendedores
                </span>

          </div>

        </div>

      </div>

    </div>

    <!-- META DEL MES + GRÁFICO -->
    <div class="row g-4 mb-4">

      <!-- META MENSUAL -->
      <div class="col-lg-4">

        <div class="custom-card card border-0 h-100">

          <div class="card-body p-4 d-flex flex-column">

            <h5 class="fw-bold mb-1 title-font" style="color: var(--text-color);">
              Meta del mes
            </h5>

            <p class="mb-4" style="font-size: 0.85rem; color: var(--text-color); opacity: 0.75;">
              Vas por buen camino, ¡sigue así!
            </p>

            <div class="d-flex justify-content-between align-items-end mb-2">

                    <span class="fw-bold fs-4 title-font" style="color: var(--text-color);">
                        S/ 8,540
                    </span>

              <span class="fw-semibold" style="color: var(--text-color); opacity: 0.75;">
                        de S/ 12,000
                    </span>

            </div>

            <div class="progress mb-2" style="height: 10px; border-radius: 20px; background-color: var(--border-color);">
              <div
                      class="progress-bar"
                      role="progressbar"
                      style="width: 71%; background-color: var(--primary-custom); border-radius: 20px;"
                      aria-valuenow="71"
                      aria-valuemin="0"
                      aria-valuemax="100"
              ></div>
            </div>

            <span style="font-size: 0.8rem; color: var(--text-color); opacity: 0.75;">
                    71% completado &middot; faltan S/ 3,460 para tu meta
                </span>

            <hr style="border-color: var(--border-color);">

            <div class="mt-auto">

              <small class="d-block mb-1" style="color: var(--text-color); opacity: 0.75;">
                Días restantes del mes
              </small>

              <span class="fw-bold fs-5" style="color: var(--text-color);">
                        21 días
                    </span>

            </div>

          </div>

        </div>

      </div>

      <!-- GRÁFICO ÚLTIMOS 7 DÍAS -->
      <div class="col-lg-8">

        <div class="custom-card card border-0 h-100">

          <div class="card-body p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">

              <h5 class="fw-bold mb-0 title-font" style="color: var(--text-color);">
                Mis ventas &middot; últimos 7 días
              </h5>

              <span class="badge bg-pink-light text-primary-custom fw-semibold">
                        S/ 1,890.00 en la semana
            </span>

            </div>

            <div style="position: relative; height: 260px; width: 100%;">

              <canvas id="ventasSemanaChart"></canvas>

            </div>

          </div>

        </div>

      </div>

    </div>

    <!-- TOP PRODUCTOS + ACCESOS RÁPIDOS -->
    <div class="row g-4 mb-4">

      <!-- TOP PRODUCTOS -->
      <div class="col-lg-6">

        <div class="custom-card card border-0 h-100">

          <div class="card-body p-4">

            <h5 class="fw-bold mb-4 title-font" style="color: var(--text-color);">
              Tus productos más vendidos
            </h5>

            <div class="d-flex align-items-center gap-3 mb-3">

                <span
                        class="d-flex align-items-center justify-content-center fw-bold"
                        style="width:32px; height:32px; min-width:32px; border-radius:50%; background: var(--gradient-primary); color:#fff; font-size:0.85rem;"
                >1</span>

              <div class="flex-grow-1">
                <span class="fw-semibold d-block" style="color: var(--text-color);">Aretes Xuping</span>
                <small style="color: var(--text-color); opacity: 0.7;">18 unidades vendidas</small>
              </div>

              <span class="fw-bold text-primary-custom">S/ 250</span>

            </div>

            <div class="d-flex align-items-center gap-3 mb-3">

                    <span
                            class="d-flex align-items-center justify-content-center fw-bold"
                            style="width:32px; height:32px; min-width:32px; border-radius:50%; background: var(--border-color); color: var(--text-heading); font-size:0.85rem;"
                    >2</span>

              <div class="flex-grow-1">
                <span class="fw-semibold d-block" style="color: var(--text-color);">Aretes Acero Dama</span>
                <small style="color: var(--text-color); opacity: 0.7;">11 unidades vendidas</small>
              </div>

              <span class="fw-bold text-primary-custom">S/ 90</span>

            </div>

            <div class="d-flex align-items-center gap-3">

                    <span
                            class="d-flex align-items-center justify-content-center fw-bold"
                            style="width:32px; height:32px; min-width:32px; border-radius:50%; background: var(--border-color); color: var(--text-heading); font-size:0.85rem;"
                    >3</span>

              <div class="flex-grow-1">
                <span class="fw-semibold d-block" style="color: var(--text-color);">Cadenas Xuping Hombre</span>
                <small style="color: var(--text-color); opacity: 0.7;">9 unidades vendidas</small>
              </div>

              <span class="fw-bold text-primary-custom">S/ 450</span>

            </div>

          </div>

        </div>

      </div>

      <!-- ACCESOS RÁPIDOS -->
      <div class="col-lg-6">

        <div class="custom-card card border-0 h-100">

          <div class="card-body p-4">

            <h5 class="fw-bold mb-4 title-font" style="color: var(--text-color);">
              Accesos rápidos
            </h5>

            <div class="row g-3">

              <div class="col-6">
                <a href="#" class="menu-link view-link d-flex flex-column align-items-start gap-2 h-100 text-decoration-none" data-view="nueva-venta" style="border:1px solid var(--border-color); padding:16px; color: var(--text-color);">
                  <i class="bi bi-bag-plus fs-3 text-primary-custom"></i>
                  <span class="fw-semibold" style="color: var(--text-color);">Nueva Venta</span>
                </a>
              </div>

              <div class="col-6">
                <a href="#" class="menu-link view-link d-flex flex-column align-items-start gap-2 h-100 text-decoration-none" data-view="mis-ventas" style="border:1px solid var(--border-color); padding:16px; color: var(--text-color);">
                  <i class="bi bi-clock-history fs-3 text-primary-custom"></i>
                  <span class="fw-semibold" style="color: var(--text-color);">Mis Ventas</span>
                </a>
              </div>

              <div class="col-6">
                <a href="#" class="menu-link view-link d-flex flex-column align-items-start gap-2 h-100 text-decoration-none" data-view="productos" style="border:1px solid var(--border-color); padding:16px; color: var(--text-color);">
                  <i class="bi bi-tag fs-3 text-primary-custom"></i>
                  <span class="fw-semibold" style="color: var(--text-color);">Producto</span>
                </a>
              </div>

              <div class="col-6">
                <a href="#" class="menu-link view-link d-flex flex-column align-items-start gap-2 h-100 text-decoration-none" data-view="promociones" style="border:1px solid var(--border-color); padding:16px; color: var(--text-color);">
                  <i class="bi bi-megaphone fs-3 text-primary-custom"></i>
                  <span class="fw-semibold" style="color: var(--text-color);">Promociones</span>
                </a>
              </div>

            </div>

          </div>

        </div>

      </div>

    </div>

    <!-- ÚLTIMAS VENTAS -->
    <div class="custom-card card border-0">

      <div class="card-body p-4">

        <div class="d-flex justify-content-between align-items-center mb-4">

          <h5 class="fw-bold title-font mb-0" style="color: var(--text-color);">
            Tus últimas ventas
          </h5>

          <a href="#" class="menu-link view-link fw-semibold p-0 text-decoration-none" data-view="mis-ventas" style="width:auto; color: var(--primary-custom);">
            Ver todas
            <i class="bi bi-arrow-right ms-1"></i>
          </a>

        </div>

        <div class="table-responsive">

          <table class="table custom-table table-hover align-middle text-nowrap mb-0" style="color: var(--text-color);">

            <thead>
            <tr>
              <th>FECHA Y HORA</th>
              <th>COMPROBANTE</th>
              <th>CLIENTE</th>
              <th>MÉTODO DE PAGO</th>
              <th>TOTAL</th>
              <th>ESTADO</th>
            </tr>
            </thead>

            <tbody>

            <tr>
              <td>09/09/2026 09:12</td>
              <td class="text-primary-custom fw-bold">B001-000512</td>
              <td>Rosa Fernández</td>
              <td>Efectivo</td>
              <td class="fw-bold">S/ 120.00</td>
              <td><span class="badge" style="background-color:#22c55e;">Pagado</span></td>
            </tr>

            <tr>
              <td>09/09/2026 10:45</td>
              <td class="text-primary-custom fw-bold">B001-000513</td>
              <td>Carlos Injante</td>
              <td>Yape</td>
              <td class="fw-bold">S/ 89.90</td>
              <td><span class="badge" style="background-color:#22c55e;">Pagado</span></td>
            </tr>

            <tr>
              <td>08/09/2026 16:40</td>
              <td class="text-primary-custom fw-bold">B001-000509</td>
              <td>Ana Chávez</td>
              <td>Tarjeta</td>
              <td class="fw-bold">S/ 159.90</td>
              <td><span class="badge" style="background-color:#22c55e;">Pagado</span></td>
            </tr>

            <tr>
              <td>08/09/2026 11:05</td>
              <td class="text-primary-custom fw-bold">F002-000089</td>
              <td>Importadora Vega SAC</td>
              <td>Transacción</td>
              <td class="fw-bold">S/ 99.00</td>
              <td><span class="badge" style="background-color:#eab308;">Pendiente</span></td>
            </tr>

            </tbody>

          </table>

        </div>

      </div>

    </div>

    </section>

    <!-- VISTA DE PRODUCTOS -->
    <jsp:include page="/view/vendedor_vistas/VProductoVendedor.jsp" />

    <!-- VISTA NUEVA VENTA -->
    <jsp:include page="/view/vendedor_vistas/VNuevaVentaVendedor.jsp" />

    <!-- VISTA MIS VENTAS -->
    <jsp:include page="/view/vendedor_vistas/VMisVentasVendedor.jsp" />

    <!-- VISTA CLIENTES -->
    <jsp:include page="/view/vendedor_vistas/VClientesVendedor.jsp" />

    <!-- VISTA PROMOCIONES -->
    <jsp:include page="/view/vendedor_vistas/VPromocionVendedor.jsp" />

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
  document.addEventListener("DOMContentLoaded", function () {

    if (typeof Chart === "undefined") {
      return;
    }

// Gráfico: "Mis ventas · últimos 7 días"
    const ventasSemanaCanvas = document.getElementById('ventasSemanaChart');

    if (ventasSemanaCanvas && typeof Chart !== 'undefined') {

      new Chart(ventasSemanaCanvas, {
        type: 'line',
        data: {
          labels: ['Mié 03', 'Jue 04', 'Vie 05', 'Sáb 06', 'Dom 07', 'Lun 08', 'Mar 09'],
          datasets: [{
            label: 'Ventas',
            data: [180, 260, 210, 340, 290, 300, 310],
            borderColor: '#ff477e',
            backgroundColor: 'rgba(255, 71, 126, 0.12)',
            borderWidth: 3,
            fill: true,
            tension: 0.35,
            pointRadius: 4,
            pointBackgroundColor: '#ff477e',
            pointBorderColor: '#ffffff',
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

    if (typeof JsBarcode !== 'undefined') {
      document.querySelectorAll('.barcode').forEach(function (el) {
        // Obtenemos el valor del atributo y nos aseguramos de que exista
        const barcodeValue = el.getAttribute('data-barcode');

        if (barcodeValue) {
          JsBarcode(el, barcodeValue, {
            format: 'CODE128',
            lineColor: '#1e2233',
            width: 2,
            height: 55,
            displayValue: true,
            fontSize: 14,
            margin: 4
          });
        }
      });
    }

  });
</script>

</body>

</html>
