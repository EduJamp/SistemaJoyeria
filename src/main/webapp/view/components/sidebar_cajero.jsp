<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="custom-sidebar" id="sidebar" >

    <!-- PERFIL -->
    <div class="user-profile-card d-flex align-items-center gap-3 mb-3">
        <div class="avatar">
            <i class="bi bi-person-fill"></i>
        </div>
        <div class="user-info overflow-hidden">
            <h6 class="mb-0 text-truncate fw-bold" style="color: var(--text-color);">Usuario</h6>
            <small class="d-block text-truncate" style="color: var(--text-color); opacity: 0.75;">@user.cajero</small>
            <span class="badge badge-role mt-1">CAJERO</span>
        </div>
    </div>

    <!-- SEDE CONECTADA -->
    <div class="sede-card mb-4 d-flex align-items-center gap-2">

        <i class="bi bi-geo-alt-fill text-primary-custom"></i>

        <div class="overflow-hidden">

            <small class="d-block fw-bold text-truncate" style="font-size: 0.7rem;" >

                SEDE CONECTADA

            </small>


            <span class="text-truncate d-block" style="font-size: 0.85rem;" >

                        Sede Central - Centro de Lima

                    </span>

        </div>

        <span class="active-dot ms-auto"> </span>

    </div>

    <!-- MENÚ -->
    <ul class="sidebar-menu list-unstyled">

        <!-- DASHBOARD -->
        <li class="menu-item">

            <a href="#" class="menu-link view-link active" data-view="dashboard">

                <i class="bi bi-house-door"></i>

                <span> Dashboard </span>

            </a>

        </li>

        <!-- MAESTRAS -->
        <li class="menu-header mt-3">

            MAESTRAS

        </li>

        <!-- CONTEO DE PRODUCTOS (KARDEX) -->
        <li class="menu-item">

            <a href="${pageContext.request.contextPath}/svinventario" class="menu-link view-link" data-view="conteo-productos">

                <i class="bi bi-file-earmark-spreadsheet"></i>

                <span> Kardex </span>

            </a>

        </li>

        <!-- CAJA -->
        <li class="menu-item">

            <a href="#menuCaja" data-bs-toggle="collapse" class="menu-link has-arrow text-nowrap" aria-expanded="false" >

                <i class="bi bi-calculator"></i>

                <span>
                        Caja
                    </span>

            </a>

            <div class="collapse" id="menuCaja" >

                <ul class="list-unstyled submenu">

                    <!-- APERTURA DE CAJA -->
                    <li>

                        <a href="${pageContext.request.contextPath}/svcaja?view=apertura-caja" class="submenu-link view-link" data-view="apertura" >

                            Apertura de Caja

                        </a>

                    </li>

                    <!-- POS -->
                    <li>

                        <a href="${pageContext.request.contextPath}/svcaja?view=punto-venta" class="submenu-link view-link" data-view="pos" >

                            Punto de Venta

                        </a>

                    </li>

                    <!-- CIERRE DE CAJA -->
                    <li>

                        <a href="${pageContext.request.contextPath}/svcaja?view=cierre-caja" class="submenu-link view-link" data-view="cierre-caja" >

                            Cierre de Caja

                        </a>

                    </li>

                </ul>

            </div>

        </li>

        <!-- CLIENTES -->
        <li class="menu-item">

            <a href="${pageContext.request.contextPath}/svcliente" class="menu-link view-link" data-view="clientes_view">

                <i class="bi bi-house-door"></i>

                <span> Clientes </span>

            </a>

        </li>

        <!-- PROMOCIONES -->
        <li class="menu-item">

            <a href="${pageContext.request.contextPath}/svpromocion" class="menu-link view-link" data-view="promociones">

                <i class="bi bi-house-door"></i>

                <span> Promociones </span>

            </a>

        </li>
    </ul>

</aside>