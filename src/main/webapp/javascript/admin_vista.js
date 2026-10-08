document.addEventListener("DOMContentLoaded", function() {

    // Lógica del Tema Oscuro/Claro
    const themeToggleBtn = document.getElementById('themeToggle');
    const htmlElement = document.documentElement;
    const iconSun = document.querySelector('.icon-sun');
    const iconMoon = document.querySelector('.icon-moon');

    const updateIcon = (isDark) => {
        if (isDark) {
            iconSun.classList.add('d-none');
            iconMoon.classList.remove('d-none');
        } else {
            iconMoon.classList.add('d-none');
            iconSun.classList.remove('d-none');
        }
    };

    // Revisar tema actual al cargar
    const currentTheme = htmlElement.getAttribute('data-theme') === 'dark';
    updateIcon(currentTheme);

    // Evento click para cambiar tema
    themeToggleBtn.addEventListener('click', () => {
        const isCurrentlyDark = htmlElement.getAttribute('data-theme') === 'dark';
        let targetTheme = isCurrentlyDark ? 'light' : 'dark';

        htmlElement.setAttribute('data-theme', targetTheme);
        localStorage.setItem('liamy-theme', targetTheme);
        updateIcon(!isCurrentlyDark);
    });

    // Toggle del Sidebar
    const sidebarToggleBtn = document.getElementById('sidebarToggle');
    const sidebar = document.getElementById('sidebar');

    sidebarToggleBtn.addEventListener('click', () => {
        if (window.innerWidth <= 991) {
            // Comportamiento móvil
            sidebar.classList.toggle('show');
        } else {
            // Comportamiento escritorio
            sidebar.classList.toggle('collapsed');
        }
    });

    // Interacción del Menú (Simulación de Vistas)
    const menuLinks = document.querySelectorAll('.submenu-link, .menu-link:not(.has-arrow)');

    menuLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            // Si el enlace tiene href="#", prevenimos que la página salte arriba
            if(this.getAttribute('href') === '#') {
                e.preventDefault();
            }

            // Remover clase active de todos los links
            menuLinks.forEach(l => l.classList.remove('active'));

            // Añadir clase active al clickeado
            this.classList.add('active');

            // --- Lógica para cambiar de vista ---
            // Si el enlace tiene un atributo "data-view", mostramos el div correspondiente
            const targetView = this.getAttribute('data-view');
            if(targetView) {
                // Ocultar todas las vistas
                document.querySelectorAll('.view-section').forEach(view => {
                    view.classList.remove('active');
                });

                // Mostrar la vista objetivo
                const viewToShow = document.getElementById('view-' + targetView);
                if(viewToShow) {
                    viewToShow.classList.add('active');
                }
            }
        });
    });
});