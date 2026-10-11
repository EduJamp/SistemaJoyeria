<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="custom-sidebar" id="sidebar">

  <!-- PERFIL -->
  <div class="user-profile-card d-flex align-items-center gap-3 mb-3">
    <div class="avatar">
      <i class="bi bi-person-fill"></i>
    </div>
    <div class="user-info overflow-hidden">
      <h6 class="mb-0 text-truncate fw-bold">Usuario</h6>
      <small class="text-muted d-block text-truncate">@user.admin</small>
      <span class="badge badge-role mt-1">ADMIN</span>
    </div>
  </div>

  <!-- SEDE CONECTADA -->
  <div class="sede-card mb-4 d-flex align-items-center gap-2">
    <i class="bi bi-geo-alt-fill text-primary-custom"></i>
    <div class="overflow-hidden">
      <small class="d-block fw-bold text-truncate" style="font-size: 0.7rem;">SEDE CONECTADA</small>
      <span class="text-truncate d-block" style="font-size: 0.85rem;">Sede Central - Centro de Lima</span>
    </div>
    <span class="active-dot ms-auto"></span>
  </div>

  <!-- MENÚ -->
  <ul class="sidebar-menu list-unstyled">

    <!-- DASHBOARD -->
    <li class="menu-item">
      <a href="#" class="menu-link view-link active" data-view="dashboard">
        <i class="bi bi-house-door"></i>
        <span>Dashboard</span>
      </a>
    </li>

    <!-- MAESTRAS -->
    <li class="menu-header mt-3">MAESTRAS</li>

    <!-- INVENTARIO -->
    <li class="menu-item">
      <a href="#menuInventario" data-bs-toggle="collapse" class="menu-link has-arrow text-nowrap" aria-expanded="false">
        <i class="bi bi-box-seam"></i>
        <span>Inventario</span>
      </a>
      <div class="collapse" id="menuInventario">
        <ul class="list-unstyled submenu">
          <li>
            <a href="${pageContext.request.contextPath}/svproducto" class="submenu-link view-link" data-view="productos">Productos</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svcategoria" class="submenu-link view-link" data-view="categorias">Categorías</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svmetodopago" class="submenu-link view-link" data-view="metodospago">Metodos de Pago</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svauditoriainventario" class="submenu-link view-link" data-view="auditoria-inventario">Auditoria de Inventario</a>
          </li>
        </ul>
      </div>
    </li>

    <!-- ASIGNACIONES -->
    <li class="menu-item">
      <a href="#menuAsignaciones" data-bs-toggle="collapse" class="menu-link has-arrow text-nowrap" aria-expanded="false">
        <i class="bi bi-diagram-3"></i>
        <span>Asignaciones</span>
      </a>
      <div class="collapse" id="menuAsignaciones">
        <ul class="list-unstyled submenu">
          <li>
            <a href="${pageContext.request.contextPath}/svsede" class="submenu-link view-link" data-view="sedes">Sedes</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svempleado" class="submenu-link view-link" data-view="empleados">Empleados</a>
          </li>
        </ul>
      </div>
    </li>

    <!-- VENTAS -->
    <li class="menu-item">
      <a href="#menuVentas" data-bs-toggle="collapse" class="menu-link has-arrow text-nowrap" aria-expanded="false">
        <i class="bi bi-bag-check"></i>
        <span>Ventas</span>
      </a>
      <div class="collapse" id="menuVentas">
        <ul class="list-unstyled submenu">
          <li>
            <a href="${pageContext.request.contextPath}/svventa?view=nueva-venta" class="submenu-link view-link" data-view="nueva-venta">Nueva Venta</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svventa?view=mis-ventas" class="submenu-link view-link" data-view="mis-ventas">Mis Ventas</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svventa?view=detalle-ventas" class="submenu-link view-link" data-view="detalle-ventas">Detalle de Ventas</a>
          </li>
        </ul>
      </div>
    </li>

    <!-- CAJA -->
    <li class="menu-item">
      <a href="#menuCaja" data-bs-toggle="collapse" class="menu-link has-arrow text-nowrap" aria-expanded="false">
        <i class="bi bi-calculator"></i>
        <span>Caja</span>
      </a>
      <div class="collapse" id="menuCaja">
        <ul class="list-unstyled submenu">
          <li>
            <a href="${pageContext.request.contextPath}/svcaja?view=apertura-caja" class="submenu-link view-link" data-view="apertura">Apertura de Caja</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svcaja?view=punto-venta" class="submenu-link view-link" data-view="pos">Punto de Venta</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svcaja?view=cierre-caja" class="submenu-link view-link" data-view="cierre-caja">Cierre de Caja</a>
          </li>
        </ul>
      </div>
    </li>

    <!-- OTROS -->
    <li class="menu-item">
      <a href="#menuGestion" data-bs-toggle="collapse" class="menu-link has-arrow text-nowrap" aria-expanded="false">
        <i class="bi bi-sliders"></i>
        <span>Gestion</span>
      </a>
      <div class="collapse" id="menuGestion">
        <ul class="list-unstyled submenu">
          <li>
            <a href="${pageContext.request.contextPath}/svcliente" class="submenu-link view-link" data-view="clientes">Clientes</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/svpromocion" class="submenu-link view-link" data-view="promociones">Promociones</a>
          </li>
        </ul>
      </div>
    </li>

    <!-- SEGURIDAD -->
    <li class="menu-header mt-3">SEGURIDAD</li>

    <!-- USUARIOS -->
    <li class="menu-item">
      <a href="${pageContext.request.contextPath}/svusuario" class="menu-link view-link" data-view="usuarios">
        <i class="bi bi-people"></i>
        <span>Usuarios</span>
      </a>
    </li>

  </ul>
</aside>