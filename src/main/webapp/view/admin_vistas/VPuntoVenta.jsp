<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% boolean esPOS = "punto-venta".equals(request.getAttribute("vistaActiva")); %>

<section id="view-pos" class="view-section <%= esPOS ? "active" : "" %>">

<!-- ENCABEZADO -->
<div class="d-flex flex-column flex-xl-row justify-content-between align-items-xl-center gap-3 mb-4">

  <div>
    <div class="d-flex align-items-center gap-2 mb-1">
      <h2 class="title-font fw-bold mb-0">Punto de Venta</h2>

      <span class="badge bg-danger-subtle text-danger rounded-pill px-3">
            Administrador
        </span>
    </div>

    <p class="text-muted mb-0">
      Supervisa las operaciones de caja, ventas, pagos y comprobantes de la sede.
    </p>
  </div>

  <div class="d-flex flex-wrap gap-2">

    <button type="button"
            class="btn btn-outline-secondary"
            data-bs-toggle="modal"
            data-bs-target="#modalHistorialCaja">

      <i class="bi bi-clock-history me-2"></i>
      Historial

    </button>

    <button type="button"
            class="btn btn-outline-secondary"
            data-bs-toggle="modal"
            data-bs-target="#modalReporteCaja">

      <i class="bi bi-bar-chart-line me-2"></i>
      Reporte

    </button>

    <button type="button"
            class="btn btn-primary-custom"
            data-bs-toggle="modal"
            data-bs-target="#modalBuscarVentaAdmin">

      <i class="bi bi-search me-2"></i>
      Buscar venta

    </button>

  </div>

</div>

<!-- INDICADORES GENERALES -->
<div class="row g-3 mb-4">

  <!-- VENTAS -->
  <div class="col-12 col-sm-6 col-xl-3">

    <div class="custom-card h-100 p-3">

      <div class="d-flex justify-content-between align-items-start">

        <div>

                <span class="text-muted small">
                    Ventas de hoy
                </span>

          <h3 class="fw-bold mt-2 mb-0">
            S/ 8,426.80
          </h3>

        </div>

        <div class="rounded-3 p-2 bg-primary-subtle text-primary">
          <i class="bi bi-cash-stack fs-5"></i>
        </div>

      </div>

      <small class="text-success d-block mt-2">
        <i class="bi bi-arrow-up-short"></i>
        14.8% respecto a ayer
      </small>

    </div>

  </div>

  <div class="col-12 col-sm-6 col-xl-3">

    <div class="custom-card h-100 p-3">

      <div class="d-flex justify-content-between align-items-start">

        <div>

                <span class="text-muted small">
                    Operaciones
                </span>

          <h3 class="fw-bold mt-2 mb-0">
            57
          </h3>

        </div>

        <div class="rounded-3 p-2 bg-success-subtle text-success">
          <i class="bi bi-receipt fs-5"></i>
        </div>

      </div>

      <small class="text-muted d-block mt-2">
        Ventas procesadas hoy
      </small>

    </div>

  </div>

  <!-- PENDIENTES -->
  <div class="col-12 col-sm-6 col-xl-3">

    <div class="custom-card h-100 p-3">

      <div class="d-flex justify-content-between align-items-start">

        <div>

                <span class="text-muted small">
                    Pendientes de cobro
                </span>

          <h3 class="fw-bold mt-2 mb-0">
            08
          </h3>

        </div>

        <div class="rounded-3 p-2 bg-warning-subtle text-warning">
          <i class="bi bi-hourglass-split fs-5"></i>
        </div>

      </div>

      <small class="text-warning d-block mt-2">
        Requieren atención
      </small>

    </div>

  </div>

  <!-- DEVOLUCIONES -->
  <div class="col-12 col-sm-6 col-xl-3">

    <div class="custom-card h-100 p-3">

      <div class="d-flex justify-content-between align-items-start">

        <div>

                <span class="text-muted small">
                    Devoluciones / anulaciones
                </span>

          <h3 class="fw-bold mt-2 mb-0">
            03
          </h3>

        </div>

        <div class="rounded-3 p-2 bg-danger-subtle text-danger">
          <i class="bi bi-arrow-counterclockwise fs-5"></i>
        </div>

      </div>

      <small class="text-muted d-block mt-2">
        Durante la jornada
      </small>

    </div>

  </div>

</div>

<!-- ESTADO DE CAJAS -->
<div class="custom-card mb-4">

  <div class="p-4 border-bottom">

    <div class="d-flex flex-column flex-md-row justify-content-between gap-3">

      <div>

        <h5 class="title-font fw-bold mb-1">
          Estado de cajas
        </h5>

        <p class="text-muted small mb-0">
          Supervisa las cajas y operaciones realizadas por los cajeros.
        </p>

      </div>

      <div class="d-flex align-items-center gap-2">

            <span class="badge bg-success-subtle text-success px-3 py-2">
                <i class="bi bi-circle-fill me-1" style="font-size:7px;"></i>
                3 abiertas
            </span>

        <span class="badge bg-secondary-subtle text-secondary px-3 py-2">
                1 cerrada
            </span>

      </div>

    </div>

  </div>

  <div class="p-4">

    <div class="row g-3">

      <!-- CAJA 01 -->
      <div class="col-12 col-lg-6 col-xl-3">

        <div class="border rounded-3 p-3 h-100">

          <div class="d-flex justify-content-between">

            <div class="d-flex gap-2">

              <div class="rounded-3 bg-success-subtle text-success d-flex align-items-center justify-content-center"
                   style="width:42px;height:42px;">

                <i class="bi bi-shop"></i>

              </div>

              <div>

                <div class="fw-bold">
                  Caja 01
                </div>

                <small class="text-muted">
                  Ana Torres
                </small>

              </div>

            </div>

            <span class="badge bg-success-subtle text-success">
                        Abierta
                    </span>

          </div>


          <div class="border-top mt-3 pt-3">

            <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted">
                            Inicio
                        </span>

              <span class="small">
                            08:02 AM
                        </span>
            </div>

            <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted">
                            Operaciones
                        </span>

              <span class="small fw-semibold">
                            21
                        </span>
            </div>

            <div class="d-flex justify-content-between">
                        <span class="small text-muted">
                            Recaudado
                        </span>

              <strong>
                S/ 3,240.50
              </strong>
            </div>

          </div>


          <button type="button"
                  class="btn btn-sm btn-outline-secondary w-100 mt-3"
                  data-bs-toggle="modal"
                  data-bs-target="#modalDetalleCaja">

            Ver caja

          </button>

        </div>

      </div>

      <!-- CAJA 02 -->
      <div class="col-12 col-lg-6 col-xl-3">

        <div class="border rounded-3 p-3 h-100">

          <div class="d-flex justify-content-between">

            <div class="d-flex gap-2">

              <div class="rounded-3 bg-success-subtle text-success d-flex align-items-center justify-content-center"
                   style="width:42px;height:42px;">

                <i class="bi bi-shop"></i>

              </div>

              <div>

                <div class="fw-bold">
                  Caja 02
                </div>

                <small class="text-muted">
                  Luis Ramírez
                </small>

              </div>

            </div>

            <span class="badge bg-success-subtle text-success">
                        Abierta
                    </span>

          </div>


          <div class="border-top mt-3 pt-3">

            <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted">
                            Inicio
                        </span>

              <span class="small">
                            08:15 AM
                        </span>
            </div>

            <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted">
                            Operaciones
                        </span>

              <span class="small fw-semibold">
                            18
                        </span>
            </div>

            <div class="d-flex justify-content-between">
                        <span class="small text-muted">
                            Recaudado
                        </span>

              <strong>
                S/ 2,814.30
              </strong>
            </div>

          </div>

          <button type="button"
                  class="btn btn-sm btn-outline-secondary w-100 mt-3"
                  data-bs-toggle="modal"
                  data-bs-target="#modalDetalleCaja">

            Ver caja

          </button>

        </div>

      </div>

      <!-- CAJA 03 -->
      <div class="col-12 col-lg-6 col-xl-3">

        <div class="border rounded-3 p-3 h-100">

          <div class="d-flex justify-content-between">

            <div class="d-flex gap-2">

              <div class="rounded-3 bg-success-subtle text-success d-flex align-items-center justify-content-center"
                   style="width:42px;height:42px;">

                <i class="bi bi-shop"></i>

              </div>

              <div>

                <div class="fw-bold">
                  Caja 03
                </div>

                <small class="text-muted">
                  Carla Mendoza
                </small>

              </div>

            </div>

            <span class="badge bg-success-subtle text-success">
                        Abierta
                    </span>

          </div>


          <div class="border-top mt-3 pt-3">

            <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted">
                            Inicio
                        </span>

              <span class="small">
                            08:30 AM
                        </span>
            </div>

            <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted">
                            Operaciones
                        </span>

              <span class="small fw-semibold">
                            18
                        </span>
            </div>

            <div class="d-flex justify-content-between">
                        <span class="small text-muted">
                            Recaudado
                        </span>

              <strong>
                S/ 2,372.00
              </strong>
            </div>

          </div>


          <button type="button"
                  class="btn btn-sm btn-outline-secondary w-100 mt-3"
                  data-bs-toggle="modal"
                  data-bs-target="#modalDetalleCaja">

            Ver caja

          </button>

        </div>

      </div>

      <!-- CAJA 04 -->
      <div class="col-12 col-lg-6 col-xl-3">

        <div class="border rounded-3 p-3 h-100">

          <div class="d-flex justify-content-between">

            <div class="d-flex gap-2">

              <div class="rounded-3 bg-secondary-subtle text-secondary d-flex align-items-center justify-content-center"
                   style="width:42px;height:42px;">

                <i class="bi bi-shop"></i>

              </div>

              <div>

                <div class="fw-bold">
                  Caja 04
                </div>

                <small class="text-muted">
                  Sin asignar
                </small>

              </div>

            </div>

            <span class="badge bg-secondary-subtle text-secondary">
                        Cerrada
                    </span>

          </div>

          <div class="border-top mt-3 pt-3">

            <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted">
                            Último cierre
                        </span>

              <span class="small">
                            Ayer 22:04
                        </span>
            </div>

            <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted">
                            Operaciones
                        </span>

              <span class="small fw-semibold">
                            32
                        </span>
            </div>

            <div class="d-flex justify-content-between">
                        <span class="small text-muted">
                            Total cierre
                        </span>

              <strong>
                S/ 4,180.90
              </strong>
            </div>

          </div>


          <button type="button"
                  class="btn btn-sm btn-primary-custom w-100 mt-3"
                  data-bs-toggle="modal"
                  data-bs-target="#modalAbrirCaja">

            <i class="bi bi-unlock me-1"></i>
            Gestionar caja

          </button>

        </div>

      </div>

    </div>

  </div>

</div>

<!-- PEDIDOS + ACTIVIDAD -->
<div class="row g-4">

  <!-- PEDIDOS -->
  <div class="col-12 col-xl-8">

    <div class="custom-card h-100">

      <div class="p-4 border-bottom">

        <div class="d-flex flex-column flex-md-row justify-content-between gap-3">

          <div>

            <h5 class="title-font fw-bold mb-1">
              Operaciones de venta
            </h5>

            <p class="text-muted small mb-0">
              Consulta y supervisa pedidos pendientes y ventas procesadas.
            </p>

          </div>


          <div class="input-group" style="max-width:280px;">

                    <span class="input-group-text bg-transparent border-end-0">
                        <i class="bi bi-search"></i>
                    </span>

            <input type="text"
                   class="form-control border-start-0"
                   placeholder="Buscar venta...">

          </div>

        </div>


        <div class="d-flex flex-wrap gap-2 mt-3">

          <button class="btn btn-sm btn-primary-custom">
            Todas
            <span class="badge bg-white text-primary ms-1">
                        57
                    </span>
          </button>

          <button class="btn btn-sm btn-outline-secondary">
            Pendientes
            <span class="badge bg-light text-dark ms-1">
                        8
                    </span>
          </button>

          <button class="btn btn-sm btn-outline-secondary">
            Pagadas
            <span class="badge bg-light text-dark ms-1">
                        46
                    </span>
          </button>

          <button class="btn btn-sm btn-outline-secondary">
            Anuladas
            <span class="badge bg-light text-dark ms-1">
                        3
                    </span>
          </button>

        </div>

      </div>

      <!-- OPERACIÓN 1 -->
      <div class="p-4 border-bottom">

        <div class="d-flex gap-3">

          <div class="rounded-3 bg-warning-subtle text-warning d-flex align-items-center justify-content-center flex-shrink-0"
               style="width:46px;height:46px;">

            <i class="bi bi-receipt fs-5"></i>

          </div>

          <div class="flex-grow-1">

            <div class="d-flex flex-column flex-md-row justify-content-between gap-2">

              <div>

                <div class="d-flex align-items-center gap-2">

                  <h6 class="fw-bold mb-0">
                    #PED-00481
                  </h6>

                  <span class="badge bg-warning-subtle text-warning">
                                    Pendiente
                                </span>

                </div>

                <small class="text-muted">
                  Carlos Mendoza · Vendedor: Diego Pérez
                </small>

              </div>

              <div class="text-md-end">

                <strong class="fs-5">
                  S/ 2,244.50
                </strong>

                <div class="small text-muted">
                  5 productos
                </div>

              </div>

            </div>

            <div class="d-flex flex-wrap gap-2 mt-3">

                        <span class="badge bg-light text-dark border">
                            Caja pendiente
                        </span>

              <span class="badge bg-success-subtle text-success">
                            Promoción disponible
                        </span>

            </div>

            <div class="d-flex flex-wrap justify-content-end gap-2 mt-3">

              <button type="button"
                      class="btn btn-sm btn-outline-secondary"
                      data-bs-toggle="modal"
                      data-bs-target="#modalDetalleVentaAdmin">

                <i class="bi bi-eye me-1"></i>
                Ver detalle

              </button>

              <button type="button"
                      class="btn btn-sm btn-primary-custom">

                <i class="bi bi-cash-coin me-1"></i>
                Gestionar cobro

              </button>

            </div>

          </div>

        </div>

      </div>

      <!-- OPERACIÓN 2 -->
      <div class="p-4 border-bottom">

        <div class="d-flex gap-3">

          <div class="rounded-3 bg-success-subtle text-success d-flex align-items-center justify-content-center flex-shrink-0"
               style="width:46px;height:46px;">

            <i class="bi bi-check-circle fs-5"></i>

          </div>

          <div class="flex-grow-1">

            <div class="d-flex flex-column flex-md-row justify-content-between gap-2">

              <div>

                <div class="d-flex align-items-center gap-2">

                  <h6 class="fw-bold mb-0">
                    #VTA-01092
                  </h6>

                  <span class="badge bg-success-subtle text-success">
                                    Pagada
                                </span>

                </div>

                <small class="text-muted">
                  María Torres · Caja 02 · Luis Ramírez
                </small>

              </div>

              <div class="text-md-end">

                <strong class="fs-5">
                  S/ 428.00
                </strong>

                <div class="small text-muted">
                  Boleta · Yape
                </div>

              </div>

            </div>

            <div class="d-flex justify-content-end gap-2 mt-3">

              <button type="button"
                      class="btn btn-sm btn-outline-secondary"
                      data-bs-toggle="modal"
                      data-bs-target="#modalDetalleVentaAdmin">

                <i class="bi bi-eye me-1"></i>
                Ver detalle

              </button>

              <button type="button"
                      class="btn btn-sm btn-outline-danger">

                <i class="bi bi-arrow-counterclockwise me-1"></i>
                Anular

              </button>

            </div>

          </div>

        </div>

      </div>

      <!-- OPERACIÓN 3 -->
      <div class="p-4">

        <div class="d-flex gap-3">

          <div class="rounded-3 bg-success-subtle text-success d-flex align-items-center justify-content-center flex-shrink-0"
               style="width:46px;height:46px;">

            <i class="bi bi-check-circle fs-5"></i>

          </div>

          <div class="flex-grow-1">

            <div class="d-flex flex-column flex-md-row justify-content-between gap-2">

              <div>

                <div class="d-flex align-items-center gap-2">

                  <h6 class="fw-bold mb-0">
                    #VTA-01091
                  </h6>

                  <span class="badge bg-success-subtle text-success">
                                    Pagada
                                </span>

                </div>

                <small class="text-muted">
                  José Ramírez · Caja 01 · Ana Torres
                </small>

              </div>

              <div class="text-md-end">

                <strong class="fs-5">
                  S/ 780.90
                </strong>

                <div class="small text-muted">
                  Factura · Tarjeta + Efectivo
                </div>

              </div>

            </div>

            <div class="d-flex justify-content-end gap-2 mt-3">

              <button type="button"
                      class="btn btn-sm btn-outline-secondary"
                      data-bs-toggle="modal"
                      data-bs-target="#modalDetalleVentaAdmin">

                <i class="bi bi-eye me-1"></i>
                Ver detalle

              </button>

              <button type="button"
                      class="btn btn-sm btn-outline-danger">

                <i class="bi bi-arrow-counterclockwise me-1"></i>
                Anular

              </button>

            </div>

          </div>

        </div>

      </div>

      <div class="p-3 border-top text-center">

        <button class="btn btn-sm btn-outline-secondary">
          Ver todas las operaciones
          <i class="bi bi-chevron-right ms-1"></i>
        </button>

      </div>

    </div>

  </div>

  <!-- RESUMEN ADMIN -->
  <div class="col-12 col-xl-4">

    <div class="custom-card h-100">

      <div class="p-4 border-bottom">

        <h5 class="title-font fw-bold mb-1">
          Resumen de pagos
        </h5>

        <p class="text-muted small mb-0">
          Distribución de los métodos utilizados hoy.
        </p>

      </div>

      <div class="p-4">

        <!-- EFECTIVO -->
        <div class="d-flex justify-content-between align-items-center mb-3">

          <div class="d-flex align-items-center gap-2">

            <div class="rounded-3 bg-success-subtle text-success p-2">
              <i class="bi bi-cash"></i>
            </div>

            <div>
              <div class="fw-semibold">
                Efectivo
              </div>

              <small class="text-muted">
                21 operaciones
              </small>
            </div>

          </div>

          <strong>
            S/ 2,840.50
          </strong>

        </div>

        <!-- TARJETA -->
        <div class="d-flex justify-content-between align-items-center mb-3">

          <div class="d-flex align-items-center gap-2">

            <div class="rounded-3 bg-primary-subtle text-primary p-2">
              <i class="bi bi-credit-card"></i>
            </div>

            <div>
              <div class="fw-semibold">
                Tarjeta
              </div>

              <small class="text-muted">
                13 operaciones
              </small>
            </div>

          </div>

          <strong>
            S/ 2,145.00
          </strong>

        </div>

        <!-- YAPE -->
        <div class="d-flex justify-content-between align-items-center mb-3">

          <div class="d-flex align-items-center gap-2">

            <div class="rounded-3 bg-purple-subtle p-2">
              <i class="bi bi-phone"></i>
            </div>

            <div>
              <div class="fw-semibold">
                Yape
              </div>

              <small class="text-muted">
                11 operaciones
              </small>
            </div>

          </div>

          <strong>
            S/ 1,624.80
          </strong>

        </div>

        <!-- PLIN -->
        <div class="d-flex justify-content-between align-items-center mb-3">

          <div class="d-flex align-items-center gap-2">

            <div class="rounded-3 bg-info-subtle text-info p-2">
              <i class="bi bi-phone-fill"></i>
            </div>

            <div>
              <div class="fw-semibold">
                Plin
              </div>

              <small class="text-muted">
                6 operaciones
              </small>
            </div>

          </div>

          <strong>
            S/ 780.50
          </strong>

        </div>

        <!-- TRANSACCIÓN -->
        <div class="d-flex justify-content-between align-items-center mb-3">

          <div class="d-flex align-items-center gap-2">

            <div class="rounded-3 bg-warning-subtle text-warning p-2">
              <i class="bi bi-arrow-left-right"></i>
            </div>

            <div>
              <div class="fw-semibold">
                Transacción
              </div>

              <small class="text-muted">
                4 operaciones
              </small>
            </div>

          </div>

          <strong>
            S/ 736.00
          </strong>

        </div>

        <!-- SIP -->
        <div class="d-flex justify-content-between align-items-center">

          <div class="d-flex align-items-center gap-2">

            <div class="rounded-3 bg-secondary-subtle text-secondary p-2">
              <i class="bi bi-wallet2"></i>
            </div>

            <div>
              <div class="fw-semibold">
                SIP
              </div>

              <small class="text-muted">
                2 operaciones
              </small>
            </div>

          </div>

          <strong>
            S/ 300.00
          </strong>

        </div>

      </div>

      <div class="p-4 border-top">

        <div class="d-flex justify-content-between">

                <span class="fw-semibold">
                    Total recaudado
                </span>

          <strong class="text-primary fs-5">
            S/ 8,426.80
          </strong>

        </div>

      </div>

    </div>

  </div>

</div>

<!-- MODAL DETALLE DE VENTA -->
<div class="modal fade"
     id="modalDetalleVentaAdmin"
     tabindex="-1"
     aria-hidden="true">

  <div class="modal-dialog modal-xl modal-dialog-centered">

    <div class="modal-content">

      <div class="modal-header">

        <div>

          <div class="d-flex align-items-center gap-2">

            <h5 class="modal-title title-font fw-bold mb-0">
              Detalle de venta
            </h5>

            <span class="badge bg-success-subtle text-success">
                        Pagada
                    </span>

          </div>

          <small class="text-muted">
            #VTA-01092 · 10/09/2026 16:42
          </small>

        </div>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="modal">
        </button>

      </div>

      <div class="modal-body">

        <div class="row g-4">

          <!-- INFORMACIÓN -->
          <div class="col-12 col-lg-4">

            <div class="border rounded-3 p-3">

              <h6 class="fw-bold mb-3">
                Información de operación
              </h6>

              <div class="mb-3">

                <small class="text-muted d-block">
                  Cliente
                </small>

                <strong>
                  María Torres
                </strong>

              </div>

              <div class="mb-3">

                <small class="text-muted d-block">
                  Cajero
                </small>

                <strong>
                  Luis Ramírez
                </strong>

              </div>

              <div class="mb-3">

                <small class="text-muted d-block">
                  Vendedor
                </small>

                <strong>
                  Diego Pérez
                </strong>

              </div>

              <div class="mb-3">

                <small class="text-muted d-block">
                  Caja
                </small>

                <strong>
                  Caja 02
                </strong>

              </div>

              <div>

                <small class="text-muted d-block">
                  Comprobante
                </small>

                <strong>
                  Boleta
                </strong>

              </div>

            </div>

          </div>

          <!-- PRODUCTOS -->
          <div class="col-12 col-lg-8">

            <div class="border rounded-3 overflow-hidden">

              <div class="p-3 border-bottom">

                <h6 class="fw-bold mb-0">
                  Productos vendidos
                </h6>

              </div>

              <div class="table-responsive">

                <table class="table align-middle mb-0">

                  <thead>
                  <tr>
                    <th>Producto</th>
                    <th class="text-center">Cantidad</th>
                    <th class="text-end">P. unitario</th>
                    <th class="text-end">Subtotal</th>
                  </tr>
                  </thead>

                  <tbody>

                  <tr>

                    <td>
                      <div class="fw-semibold">
                        Mouse Logitech M185
                      </div>

                      <small class="text-muted">
                        LOG-M185
                      </small>
                    </td>

                    <td class="text-center">
                      2
                    </td>

                    <td class="text-end">
                      S/ 45.00
                    </td>

                    <td class="text-end fw-semibold">
                      S/ 90.00
                    </td>

                  </tr>

                  <tr>

                    <td>
                      <div class="fw-semibold">
                        Teclado Redragon Kumara
                      </div>

                      <small class="text-muted">
                        RED-K552
                      </small>
                    </td>

                    <td class="text-center">
                      1
                    </td>

                    <td class="text-end">
                      S/ 120.00
                    </td>

                    <td class="text-end fw-semibold">
                      S/ 120.00
                    </td>

                  </tr>

                  <tr>

                    <td>
                      <div class="fw-semibold">
                        Monitor LG 24"
                      </div>

                      <small class="text-muted">
                        LG24-001
                      </small>
                    </td>

                    <td class="text-center">
                      1
                    </td>

                    <td class="text-end">
                      S/ 250.00
                    </td>

                    <td class="text-end fw-semibold">
                      S/ 250.00
                    </td>

                  </tr>

                  </tbody>

                </table>

              </div>

            </div>

            <div class="border rounded-3 p-3 mt-3">

              <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">
                                Subtotal
                            </span>

                <span>
                                S/ 460.00
                            </span>
              </div>

              <div class="d-flex justify-content-between mb-2">

                            <span class="text-muted">
                                Promoción
                            </span>

                <span class="text-success">
                                - S/ 32.00
                            </span>

              </div>

              <div class="d-flex justify-content-between pt-2 border-top">

                <strong>
                  Total
                </strong>

                <strong class="fs-5 text-primary">
                  S/ 428.00
                </strong>

              </div>

            </div>

          </div>

        </div>

      </div>

      <div class="modal-footer">

        <button type="button"
                class="btn btn-outline-secondary"
                data-bs-dismiss="modal">

          Cerrar

        </button>

        <button type="button"
                class="btn btn-outline-danger">

          <i class="bi bi-arrow-counterclockwise me-1"></i>
          Anular venta

        </button>

        <button type="button"
                class="btn btn-primary-custom">

          <i class="bi bi-printer me-1"></i>
          Imprimir comprobante

        </button>

      </div>

    </div>

  </div>

</div>

<!-- MODAL HISTORIAL DE CAJA -->
<div class="modal fade"
     id="modalHistorialCaja"
     tabindex="-1"
     aria-hidden="true">

  <div class="modal-dialog modal-xl modal-dialog-centered">

    <div class="modal-content">

      <div class="modal-header">

        <div>

          <h5 class="modal-title title-font fw-bold">
            Historial de cajas
          </h5>

          <small class="text-muted">
            Consulta aperturas, cierres y movimientos de caja.
          </small>

        </div>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="modal">
        </button>

      </div>

      <div class="modal-body">

        <div class="row g-3 mb-3">

          <div class="col-12 col-md-4">

            <label class="form-label small fw-semibold">
              Fecha inicial
            </label>

            <input type="date"
                   class="form-control"
                   value="2026-09-01">

          </div>

          <div class="col-12 col-md-4">

            <label class="form-label small fw-semibold">
              Fecha final
            </label>

            <input type="date"
                   class="form-control"
                   value="2026-09-10">

          </div>

          <div class="col-12 col-md-4">

            <label class="form-label small fw-semibold">
              Cajero
            </label>

            <select class="form-select">

              <option>Todos</option>
              <option>Ana Torres</option>
              <option>Luis Ramírez</option>
              <option>Carla Mendoza</option>

            </select>

          </div>

        </div>

        <div class="table-responsive border rounded-3">

          <table class="table align-middle mb-0">

            <thead>

            <tr>
              <th>Fecha</th>
              <th>Caja</th>
              <th>Cajero</th>
              <th>Apertura</th>
              <th>Cierre</th>
              <th class="text-end">Total</th>
              <th>Estado</th>
            </tr>

            </thead>

            <tbody>

            <tr>
              <td>10/09/2026</td>
              <td>Caja 01</td>
              <td>Ana Torres</td>
              <td>08:02</td>
              <td>--</td>
              <td class="text-end">S/ 3,240.50</td>
              <td>
                                <span class="badge bg-success-subtle text-success">
                                    Abierta
                                </span>
              </td>
            </tr>

            <tr>
              <td>10/09/2026</td>
              <td>Caja 02</td>
              <td>Luis Ramírez</td>
              <td>08:15</td>
              <td>--</td>
              <td class="text-end">S/ 2,814.30</td>
              <td>
                                <span class="badge bg-success-subtle text-success">
                                    Abierta
                                </span>
              </td>
            </tr>

            <tr>
              <td>09/09/2026</td>
              <td>Caja 04</td>
              <td>Carla Mendoza</td>
              <td>08:00</td>
              <td>22:04</td>
              <td class="text-end">S/ 4,180.90</td>
              <td>
                                <span class="badge bg-secondary-subtle text-secondary">
                                    Cerrada
                                </span>
              </td>
            </tr>

            </tbody>

          </table>

        </div>

      </div>

    </div>

  </div>

</div>

<!-- MODAL REPORTE DE CAJA -->
<div class="modal fade"
     id="modalReporteCaja"
     tabindex="-1"
     aria-hidden="true">

  <div class="modal-dialog modal-lg modal-dialog-centered">

    <div class="modal-content">

      <div class="modal-header">

        <div>

          <h5 class="modal-title title-font fw-bold">
            Reporte de caja
          </h5>

          <small class="text-muted">
            Resumen financiero de la jornada.
          </small>

        </div>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="modal">
        </button>

      </div>

      <div class="modal-body">

        <div class="row g-3">

          <div class="col-12 col-md-6">

            <div class="border rounded-3 p-3">

              <small class="text-muted">
                Total ventas
              </small>

              <h4 class="fw-bold mt-2">
                S/ 8,426.80
              </h4>

              <small class="text-success">
                57 operaciones
              </small>

            </div>

          </div>

          <div class="col-12 col-md-6">

            <div class="border rounded-3 p-3">

              <small class="text-muted">
                Promedio por venta
              </small>

              <h4 class="fw-bold mt-2">
                S/ 147.84
              </h4>

              <small class="text-muted">
                Ticket promedio
              </small>

            </div>

          </div>

          <div class="col-12">

            <div class="border rounded-3 p-3">

              <h6 class="fw-bold mb-3">
                Métodos de pago
              </h6>

              <div class="d-flex justify-content-between mb-2">
                <span>Efectivo</span>
                <strong>S/ 2,840.50</strong>
              </div>

              <div class="d-flex justify-content-between mb-2">
                <span>Tarjeta</span>
                <strong>S/ 2,145.00</strong>
              </div>

              <div class="d-flex justify-content-between mb-2">
                <span>Yape</span>
                <strong>S/ 1,624.80</strong>
              </div>

              <div class="d-flex justify-content-between mb-2">
                <span>Plin</span>
                <strong>S/ 780.50</strong>
              </div>

              <div class="d-flex justify-content-between mb-2">
                <span>Transacción</span>
                <strong>S/ 736.00</strong>
              </div>

              <div class="d-flex justify-content-between">
                <span>SIP</span>
                <strong>S/ 300.00</strong>
              </div>

            </div>

          </div>

        </div>

      </div>

      <div class="modal-footer">

        <button type="button"
                class="btn btn-outline-secondary"
                data-bs-dismiss="modal">
          Cerrar
        </button>

        <button type="button"
                class="btn btn-primary-custom">
          <i class="bi bi-download me-1"></i>
          Exportar reporte
        </button>

      </div>

    </div>

  </div>

</div>

<!-- MODAL DETALLE CAJA -->
<div class="modal fade"
     id="modalDetalleCaja"
     tabindex="-1"
     aria-hidden="true">

  <div class="modal-dialog modal-lg modal-dialog-centered">

    <div class="modal-content">

      <div class="modal-header">

        <div>

          <div class="d-flex align-items-center gap-2">

            <h5 class="modal-title title-font fw-bold mb-0">
              Caja 01
            </h5>

            <span class="badge bg-success-subtle text-success">
                        Abierta
                    </span>

          </div>

          <small class="text-muted">
            Cajero: Ana Torres
          </small>

        </div>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="modal">
        </button>

      </div>

      <div class="modal-body">

        <div class="row g-3 mb-4">

          <div class="col-12 col-md-4">

            <div class="border rounded-3 p-3">

              <small class="text-muted">
                Fondo inicial
              </small>

              <h5 class="fw-bold mt-2 mb-0">
                S/ 500.00
              </h5>

            </div>

          </div>

          <div class="col-12 col-md-4">

            <div class="border rounded-3 p-3">

              <small class="text-muted">
                Ventas
              </small>

              <h5 class="fw-bold mt-2 mb-0">
                S/ 3,240.50
              </h5>

            </div>

          </div>

          <div class="col-12 col-md-4">

            <div class="border rounded-3 p-3">

              <small class="text-muted">
                Efectivo esperado
              </small>

              <h5 class="fw-bold mt-2 mb-0">
                S/ 1,680.40
              </h5>

            </div>

          </div>

        </div>

        <div class="border rounded-3 overflow-hidden">

          <div class="p-3 border-bottom">
            <h6 class="fw-bold mb-0">
              Últimas operaciones
            </h6>
          </div>

          <div class="table-responsive">

            <table class="table align-middle mb-0">

              <thead>

              <tr>
                <th>Venta</th>
                <th>Cliente</th>
                <th>Método</th>
                <th class="text-end">Monto</th>
              </tr>

              </thead>

              <tbody>

              <tr>
                <td>#VTA-01092</td>
                <td>María Torres</td>
                <td>Yape</td>
                <td class="text-end">S/ 428.00</td>
              </tr>

              <tr>
                <td>#VTA-01091</td>
                <td>José Ramírez</td>
                <td>Tarjeta + efectivo</td>
                <td class="text-end">S/ 780.90</td>
              </tr>

              <tr>
                <td>#VTA-01090</td>
                <td>Andrea Flores</td>
                <td>Efectivo</td>
                <td class="text-end">S/ 210.00</td>
              </tr>

              </tbody>

            </table>

          </div>

        </div>

      </div>

      <div class="modal-footer">

        <button type="button"
                class="btn btn-outline-danger">

          <i class="bi bi-lock me-1"></i>
          Cerrar caja

        </button>

        <button type="button"
                class="btn btn-primary-custom">

          Ver movimientos

        </button>

      </div>

    </div>

  </div>

</div>

<!-- MODAL ABRIR / GESTIONAR CAJA -->
<div class="modal fade"
     id="modalAbrirCaja"
     tabindex="-1"
     aria-hidden="true">

  <div class="modal-dialog modal-dialog-centered">

    <div class="modal-content">

      <div class="modal-header">

        <div>

          <h5 class="modal-title title-font fw-bold">
            Gestionar caja
          </h5>

          <small class="text-muted">
            Asigna un cajero y administra el estado de la caja.
          </small>

        </div>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="modal">
        </button>

      </div>

      <div class="modal-body">

        <div class="mb-3">

          <label class="form-label fw-semibold">
            Caja
          </label>

          <select class="form-select">

            <option selected>
              Caja 04
            </option>

            <option>
              Caja 01
            </option>

            <option>
              Caja 02
            </option>

            <option>
              Caja 03
            </option>

          </select>

        </div>

        <div class="mb-3">

          <label class="form-label fw-semibold">
            Cajero responsable
          </label>

          <select class="form-select">

            <option selected>
              Seleccionar cajero
            </option>

            <option>
              Ana Torres
            </option>

            <option>
              Luis Ramírez
            </option>

            <option>
              Carla Mendoza
            </option>

          </select>

        </div>

        <div class="mb-3">

          <label class="form-label fw-semibold">
            Fondo inicial
          </label>

          <div class="input-group">

                    <span class="input-group-text">
                        S/
                    </span>

            <input type="number"
                   class="form-control"
                   value="500.00"
                   step="0.01">

          </div>

        </div>

        <div class="rounded-3 bg-warning-subtle p-3">

          <div class="d-flex gap-2">

            <i class="bi bi-info-circle text-warning fs-5"></i>

            <small>
              La apertura de una caja quedará registrada con el usuario administrador,
              fecha y hora de la operación.
            </small>

          </div>

        </div>

      </div>

      <div class="modal-footer">

        <button type="button"
                class="btn btn-outline-secondary"
                data-bs-dismiss="modal">

          Cancelar

        </button>

        <button type="button"
                class="btn btn-primary-custom">

          <i class="bi bi-unlock me-1"></i>
          Abrir caja

        </button>

      </div>

    </div>

  </div>

</div>

<!-- MODAL BUSCAR VENTA ADMIN -->
<div class="modal fade"
     id="modalBuscarVentaAdmin"
     tabindex="-1"
     aria-hidden="true">

  <div class="modal-dialog modal-lg modal-dialog-centered">

    <div class="modal-content">

      <div class="modal-header">

        <div>

          <h5 class="modal-title title-font fw-bold">
            Buscar venta
          </h5>

          <small class="text-muted">
            El administrador puede consultar cualquier operación de la sede.
          </small>

        </div>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="modal">
        </button>

      </div>

      <div class="modal-body">

        <div class="input-group mb-4">

                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>

          <input type="text"
                 class="form-control"
                 placeholder="N.º de venta, pedido, cliente, DNI o comprobante...">

          <button class="btn btn-primary-custom">
            Buscar
          </button>

        </div>

        <div class="list-group">

          <button type="button"
                  class="list-group-item list-group-item-action">

            <div class="d-flex justify-content-between align-items-center">

              <div>

                <div class="fw-bold">
                  #VTA-01092
                </div>

                <small class="text-muted">
                  María Torres · Caja 02 · Luis Ramírez
                </small>

              </div>

              <div class="text-end">

                <strong>
                  S/ 428.00
                </strong>

                <div>
                                <span class="badge bg-success-subtle text-success">
                                    Pagada
                                </span>
                </div>

              </div>

            </div>

          </button>

          <button type="button"
                  class="list-group-item list-group-item-action">

            <div class="d-flex justify-content-between align-items-center">

              <div>

                <div class="fw-bold">
                  #VTA-01091
                </div>

                <small class="text-muted">
                  José Ramírez · Caja 01 · Ana Torres
                </small>

              </div>

              <div class="text-end">

                <strong>
                  S/ 780.90
                </strong>

                <div>
                                <span class="badge bg-success-subtle text-success">
                                    Pagada
                                </span>
                </div>

              </div>

            </div>

          </button>

        </div>

      </div>

    </div>

  </div>

</div>
</section>