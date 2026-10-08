(function () {
    'use strict';

    /* ---------- Tema claro / oscuro ---------- */
    var root = document.documentElement;
    var themeToggle = document.getElementById('themeToggle');
    var THEME_KEY = 'liamy-theme';

    function setTheme(theme) {
        if (theme === 'dark') {
            root.setAttribute('data-theme', 'dark');
        } else {
            root.removeAttribute('data-theme');
        }
        try {
            localStorage.setItem(THEME_KEY, theme);
        } catch (e) { /* almacenamiento no disponible */
        }
    }

    if (themeToggle) {
        themeToggle.addEventListener('click', function () {
            var isDark = root.getAttribute('data-theme') === 'dark';
            setTheme(isDark ? 'light' : 'dark');
        });
    }

    /* ---------- Mostrar / ocultar contraseña ---------- */
    var toggleBtn = document.getElementById('togglePassword');
    var passwordInput = document.getElementById('password');

    if (toggleBtn && passwordInput) {
        toggleBtn.addEventListener('click', function () {
            var isVisible = passwordInput.type === 'text';
            passwordInput.type = isVisible ? 'password' : 'text';
            toggleBtn.classList.toggle('is-visible', !isVisible);
            toggleBtn.setAttribute('aria-label', isVisible ? 'Mostrar contraseña' : 'Ocultar contraseña');
        });
    }
})();