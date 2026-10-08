<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar custom-navbar fixed-top">

    <div class="container-fluid px-3">

        <!-- BOTÓN SIDEBAR -->
        <button type="button" class="btn btn-link nav-icon me-2 me-md-3" id="sidebarToggle" title="Mostrar/Ocultar menú" >

            <i class="bi bi-list fs-4"></i>

        </button>

        <!-- LOGO -->
        <a href="#" class="navbar-brand d-flex align-items-center gap-2" >

            <img src="${pageContext.request.contextPath}/assets/img/LogoLiamyImport.webp" alt="Liamy Import" class="navbar-logo" >

            <span class="fw-bold brand-text">
                Liamy Import
            </span>

        </a>

        <!-- ACCIONES NAVBAR -->
        <div class="ms-auto d-flex align-items-center gap-2 gap-md-3" >

            <button
                    type="button" class="btn btn-link nav-icon" id="themeToggle" title="Cambiar tema">

                <i class="bi bi-sun-fill icon-sun fs-5"></i>

                <i class="bi bi-moon-stars-fill icon-moon fs-5 d-none"></i>

            </button>

            <!-- NOTIFICACIONES -->
            <button type="button" class="btn btn-link nav-icon" title="Notificaciones">

                <i class="bi bi-bell fs-5"></i>

            </button>

            <!-- USUARIO -->
            <button type="button" class="btn btn-link nav-icon d-none d-sm-block" title="Perfil">

                <i class="bi bi-person fs-5"></i>

            </button>

            <!-- CERRAR SESIÓN -->
            <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/svlogout'" class="btn btn-link nav-icon text-danger" title="Cerrar sesión">

                <i class="bi bi-box-arrow-right fs-5"></i>

            </button>

        </div>

    </div>

</nav>
