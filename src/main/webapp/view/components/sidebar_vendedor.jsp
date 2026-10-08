<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="custom-sidebar" id="sidebar" >

    <!-- PERFIL -->
    <div class="user-profile-card d-flex align-items-center gap-3 mb-3">
        <div class="avatar">
            <i class="bi bi-person-fill"></i>
        </div>
        <div class="user-info overflow-hidden">
            <h6 class="mb-0 text-truncate fw-bold" style="color: var(--text-color);">Usuario</h6>
            <small class="d-block text-truncate" style="color: var(--text-color); opacity: 0.75;">@user.vendedor</small>
            <span class="badge badge-role mt-1">VENDEDOR</span>
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

        <!-- PRODUCTOS -->
        <li class="menu-item">

            <a href="${pageContext.request.contextPath}/svproducto" class="menu-link view-link" data-view="productos">

                <i class="bi bi-box-seam"></i>

                <span> Productos </span>

            </a>

        </li>

        <!-- VENTAS -->
        <li class="menu-item">

            <a href="#menuVentas" data-bs-toggle="collapse" class="menu-link has-arrow text-nowrap" aria-expanded="false" >

                <i class="bi bi-bag-check"></i>

                <span> Ventas </span>

            </a>

            <div class="collapse" id="menuVentas" >

                <ul class="list-unstyled submenu">

                    <!-- NUEVA VENTA -->
                    <li>

                        <a href="${pageContext.request.contextPath}/svventa?view=nueva-venta" class="submenu-link view-link" data-view="nueva-venta" >

                            Nueva Venta

                        </a>

                    </li>

                    <!-- HISTORIAL DE VENTAS -->
                    <li>

                        <a href="${pageContext.request.contextPath}/svventa?view=mis-ventas" class="submenu-link view-link" data-view="mis-ventas" >

                            Mis Ventas

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

                <i class="bi bi-megaphone"></i>

                <span> Promociones </span>

            </a>

        </li>
    </ul>

</aside>
