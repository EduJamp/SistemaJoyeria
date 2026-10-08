<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Liamy Import | Iniciar Sesión</title>

    <script>
        (function () {
            try {
                var savedTheme = localStorage.getItem('liamy-theme');
                var prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                var theme = savedTheme || (prefersDark ? 'dark' : 'light');
                if (theme === 'dark') {
                    document.documentElement.setAttribute('data-theme', 'dark');
                }
            } catch (e) { }
        })();
    </script>

    <!-- Fuentes -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>

<!-- Fondo decorativo -->
<div class="bg-decor" aria-hidden="true">
    <span class="blob blob-1"></span>
    <span class="blob blob-2"></span>
    <span class="blob blob-3"></span>
</div>

<!-- Botón para cambiar tema -->
<button type="button" id="themeToggle" class="theme-toggle" aria-label="Cambiar tema claro u oscuro" title="Cambiar tema">
    <svg class="theme-icon icon-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="12" cy="12" r="5"></circle>
        <line x1="12" y1="1" x2="12" y2="3"></line>
        <line x1="12" y1="21" x2="12" y2="23"></line>
        <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
        <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
        <line x1="1" y1="12" x2="3" y2="12"></line>
        <line x1="21" y1="12" x2="23" y2="12"></line>
        <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
        <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
    </svg>
    <svg class="theme-icon icon-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
    </svg>
</button>

<main class="login-wrapper">
    <div class="login-card">
        <div class="login-card-inner">

            <div class="logo-container">
                <div class="logo-placeholder">
                    <img src="${pageContext.request.contextPath}/assets/img/LogoLiamyImport.webp" alt="Logo LiamyImport" class="logo-img">
                </div>
            </div>

            <h1 class="login-title">Bienvenido a Liamy Import!</h1>
            <p class="login-subtitle">Inicia sesión para continuar</p>

            <form class="login-form" id="loginForm" action="${pageContext.request.contextPath}/svlogin" method="POST">
                <div class="form-group">
                    <label for="usuario">Usuario</label>
                    <div class="input-wrapper">
                        <input type="text" id="usuario" name="usuario" placeholder="Ingrese usuario" autocomplete="username" required autofocus>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper has-icon">
                        <input type="password" id="password" name="password" placeholder="Contraseña" autocomplete="current-password" required>
                        <button type="button" class="toggle-password" id="togglePassword" aria-label="Mostrar contraseña">
                            <svg class="eye-icon eye-open" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                            <svg class="eye-icon eye-closed" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M17.94 17.94A10.94 10.94 0 0 1 12 20c-7 0-11-8-11-8a21.62 21.62 0 0 1 5.06-6.06M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a21.6 21.6 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                                <line x1="1" y1="1" x2="23" y2="23"></line>
                            </svg>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-login" id="btnLogin">
                    <span class="btn-text">Iniciar Sesion</span>
                </button>
            </form>
        </div>
    </div>
</main>

<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content custom-modal">
            <div class="modal-header border-0">
                <h5 class="modal-title text-danger fw-bold" id="errorModalLabel">Error de Autenticación</h5>
                <button type="button" class="btn-close custom-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pb-4">
                <span id="errorMessageText">
                    ${not empty mensajeError ? mensajeError : 'Usuario o contraseña incorrectos. Por favor, intente nuevamente.'}
                </span>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn-login" data-bs-dismiss="modal" style="width: 100%;">Entendido</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/javascript/login.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var hasError = "${error}" === "true";

        if (hasError) {
            var myModal = new bootstrap.Modal(document.getElementById('errorModal'));
            myModal.show();
        }
    });
</script>
</body>
</html>