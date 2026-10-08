document.addEventListener("DOMContentLoaded", function() {

    // ==========================================
    // 1. Lógica del Tema Oscuro/Claro
    // ==========================================
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


    // ==========================================
    // 2. Toggle del Sidebar (Para Móviles y Escritorio)
    // ==========================================
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


    // ==========================================
    // 3. Interacción del Menú (Simulación de Vistas)
    // ==========================================
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

            // --- Lógica opcional para cambiar de vista ---
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


    // ==========================================
    // 4. Nueva Venta: cliente + producto con
    //    autocompletado, precios por mayor (fijos)
    //    y sede tomada de la sesión.
    // ==========================================
    const productoBuscador = document.getElementById('productoBuscador');

    if (productoBuscador) {

        // ---- Datos de ejemplo. Reemplaza por tu backend ----
        const clientesDataset = [
            { id: 1, nombre: 'Rosa Fernández', doc: 'DNI 45782301', telefono: '987 654 321' },
            { id: 2, nombre: 'Carlos Injante', doc: 'DNI 41209988', telefono: '945 112 233' },
            { id: 3, nombre: 'Importadora Vega SAC', doc: 'RUC 20601234567', telefono: '014 556 778' },
            { id: 4, nombre: 'Ana Chávez', doc: 'DNI 48912233', telefono: '978 223 344' }
        ];

        // Precios por unidad y por volumen. En producción esto
        // viene de tu tabla de productos (precio_unidad, precio_1_4,
        // precio_1_2, precio_docena).
        const productosDataset = [
            { codigo: '7751234560012', nombre: 'Aretes de Plata 950 Gota', precioUnidad: 45.00, precioCuarto: 42.00, precioMedia: 39.00, precioDocena: 35.00 },
            { codigo: '7751234560029', nombre: 'Cadena de Acero Cubana', precioUnidad: 79.90, precioCuarto: 75.00, precioMedia: 70.00, precioDocena: 64.90 },
            { codigo: '7751234560036', nombre: 'Anillo con Circonia Solitario', precioUnidad: 65.00, precioCuarto: 61.00, precioMedia: 57.00, precioDocena: 52.00 },
            { codigo: '7751234560043', nombre: 'Pulsera de Cuero Trenzado', precioUnidad: 32.00, precioCuarto: 30.00, precioMedia: 28.00, precioDocena: 25.00 },
            { codigo: '7751234560050', nombre: 'Collar de Perlas Cultivadas', precioUnidad: 55.00, precioCuarto: 51.00, precioMedia: 47.00, precioDocena: 42.00 },
            { codigo: '7751234560067', nombre: 'Gemelos de Acero Grabados', precioUnidad: 38.00, precioCuarto: 35.00, precioMedia: 33.00, precioDocena: 29.00 }
        ];

        const formatMoney = (valor) => 'S/ ' + valor.toFixed(2);

        // -----------------------------------------
        // 4.1 Sede fija (tomada de la sesión activa)
        // -----------------------------------------
        const ventaSedeFija = document.getElementById('ventaSedeFija');
        if (ventaSedeFija) {
            const sedeSidebar = document.querySelector('.sede-card .text-truncate');
            if (sedeSidebar && sedeSidebar.textContent.trim()) {
                ventaSedeFija.textContent = sedeSidebar.textContent.trim();
            }
        }

        // -----------------------------------------
        // 4.2 Buscador de cliente con autocompletado
        // -----------------------------------------
        const clienteBuscador = document.getElementById('clienteBuscador');
        const clienteDropdown = document.getElementById('clienteDropdown');
        const clienteSeleccionadoChip = document.getElementById('clienteSeleccionadoChip');
        const clienteSeleccionadoNombre = document.getElementById('clienteSeleccionadoNombre');
        const btnQuitarCliente = document.getElementById('btnQuitarCliente');

        let clienteSeleccionado = null;

        const renderClienteDropdown = (lista) => {

            if (lista.length === 0) {
                clienteDropdown.innerHTML = '<div class="search-dropdown-empty">Sin resultados. Usa "Nuevo cliente".</div>';
            } else {
                clienteDropdown.innerHTML = lista.map((c) =>
                    '<div class="search-dropdown-item" data-id="' + c.id + '">' +
                    '<i class="bi bi-person-circle text-muted"></i>' +
                    '<div><span class="fw-semibold d-block">' + c.nombre + '</span>' +
                    '<small class="text-muted">' + c.doc + '</small></div>' +
                    '</div>'
                ).join('');
            }

            clienteDropdown.classList.remove('d-none');

            clienteDropdown.querySelectorAll('.search-dropdown-item').forEach((item) => {
                item.addEventListener('click', () => {
                    const id = Number(item.getAttribute('data-id'));
                    const cliente = clientesDataset.find((c) => c.id === id);
                    if (cliente) seleccionarCliente(cliente);
                });
            });
        };

        const seleccionarCliente = (cliente) => {
            clienteSeleccionado = cliente;
            clienteSeleccionadoNombre.textContent = cliente.nombre + ' · ' + cliente.doc;
            clienteSeleccionadoChip.classList.remove('d-none');
            clienteBuscador.value = '';
            clienteDropdown.classList.add('d-none');
        };

        clienteBuscador.addEventListener('input', () => {
            const texto = clienteBuscador.value.trim().toLowerCase();
            if (!texto) {
                clienteDropdown.classList.add('d-none');
                return;
            }
            const filtrados = clientesDataset.filter((c) =>
                c.nombre.toLowerCase().includes(texto) || c.doc.toLowerCase().includes(texto)
            );
            renderClienteDropdown(filtrados);
        });

        clienteBuscador.addEventListener('focus', () => {
            if (clienteBuscador.value.trim()) renderClienteDropdown(
                clientesDataset.filter((c) => c.nombre.toLowerCase().includes(clienteBuscador.value.trim().toLowerCase()))
            );
        });

        document.addEventListener('click', (e) => {
            if (!clienteDropdown.contains(e.target) && e.target !== clienteBuscador) {
                clienteDropdown.classList.add('d-none');
            }
        });

        btnQuitarCliente.addEventListener('click', () => {
            clienteSeleccionado = null;
            clienteSeleccionadoChip.classList.add('d-none');
        });

        // -----------------------------------------
        // 4.3 Alta rápida de cliente (modal)
        // -----------------------------------------
        const btnGuardarClienteVenta = document.getElementById('btnGuardarClienteVenta');
        const nuevoClienteVentaModalEl = document.getElementById('nuevoClienteVentaModal');
        const nuevoClienteVentaModal = bootstrap.Modal.getOrCreateInstance(nuevoClienteVentaModalEl);

        btnGuardarClienteVenta.addEventListener('click', () => {

            const documento = document.getElementById('ncvDocumento').value.trim();
            const nombre = document.getElementById('ncvNombre').value.trim();
            const telefono = document.getElementById('ncvTelefono').value.trim();

            if (!documento || !nombre) {
                alert('Completa al menos el documento y el nombre del cliente.');
                return;
            }

            const nuevoCliente = {
                id: clientesDataset.length + 1,
                nombre,
                doc: documento,
                telefono: telefono || '—'
            };

            // Aquí deberías enviar "nuevoCliente" a tu backend
            // (fetch/AJAX) y usar el ID real que te devuelva.
            clientesDataset.push(nuevoCliente);
            seleccionarCliente(nuevoCliente);

            document.getElementById('ncvDocumento').value = '';
            document.getElementById('ncvNombre').value = '';
            document.getElementById('ncvTelefono').value = '';

            nuevoClienteVentaModal.hide();
        });

        // -----------------------------------------
        // 4.4 Buscador de producto con autocompletado
        // -----------------------------------------
        const productoDropdown = document.getElementById('productoDropdown');
        const productoSeleccionadoPanel = document.getElementById('productoSeleccionadoPanel');
        const productoVacioMensaje = document.getElementById('productoVacioMensaje');
        const psNombre = document.getElementById('psNombre');
        const psCodigo = document.getElementById('psCodigo');
        const btnQuitarProducto = document.getElementById('btnQuitarProducto');
        const productoCantidad = document.getElementById('productoCantidad');
        const tarifaAplicadaNombre = document.getElementById('tarifaAplicadaNombre');
        const precioAplicado = document.getElementById('precioAplicado');
        const btnAgregarProducto = document.getElementById('btnAgregarProducto');

        let productoSeleccionado = null;

        const renderProductoDropdown = (lista) => {

            if (lista.length === 0) {
                productoDropdown.innerHTML = '<div class="search-dropdown-empty">No se encontraron productos.</div>';
            } else {
                productoDropdown.innerHTML = lista.map((p) =>
                    '<div class="search-dropdown-item" data-codigo="' + p.codigo + '">' +
                    '<i class="bi bi-gem text-muted"></i>' +
                    '<div class="flex-grow-1"><span class="fw-semibold d-block">' + p.nombre + '</span>' +
                    '<small class="text-muted">Cód. ' + p.codigo + '</small></div>' +
                    '<span class="fw-bold text-primary-custom">' + formatMoney(p.precioUnidad) + '</span>' +
                    '</div>'
                ).join('');
            }

            productoDropdown.classList.remove('d-none');

            productoDropdown.querySelectorAll('.search-dropdown-item').forEach((item) => {
                item.addEventListener('click', () => {
                    const codigo = item.getAttribute('data-codigo');
                    const producto = productosDataset.find((p) => p.codigo === codigo);
                    if (producto) seleccionarProducto(producto);
                });
            });
        };

        // Determina la tarifa aplicable según cantidad (reglas de negocio fijas)
        const calcularTarifa = (producto, cantidad) => {
            if (cantidad >= 12) return { tier: 'docena', nombre: 'Docena a más', precio: producto.precioDocena };
            if (cantidad >= 6) return { tier: 'media', nombre: '1/2 docena', precio: producto.precioMedia };
            if (cantidad >= 3) return { tier: 'cuarto', nombre: '1/4 docena', precio: producto.precioCuarto };
            return { tier: 'unidad', nombre: 'Unidad', precio: producto.precioUnidad };
        };

        const actualizarPanelProducto = () => {

            if (!productoSeleccionado) return;

            const cantidad = Math.max(1, Number(productoCantidad.value) || 1);
            const tarifa = calcularTarifa(productoSeleccionado, cantidad);

            tarifaAplicadaNombre.textContent = tarifa.nombre;
            precioAplicado.textContent = formatMoney(tarifa.precio);

            document.querySelectorAll('.tarifa-box').forEach((box) => {
                box.classList.toggle('tarifa-activa', box.getAttribute('data-tier') === tarifa.tier);
            });
        };

        const seleccionarProducto = (producto) => {

            productoSeleccionado = producto;

            psNombre.textContent = producto.nombre;
            psCodigo.textContent = 'Cód. barras: ' + producto.codigo;

            document.querySelector('[data-precio-tier="unidad"]').textContent = formatMoney(producto.precioUnidad);
            document.querySelector('[data-precio-tier="cuarto"]').textContent = formatMoney(producto.precioCuarto);
            document.querySelector('[data-precio-tier="media"]').textContent = formatMoney(producto.precioMedia);
            document.querySelector('[data-precio-tier="docena"]').textContent = formatMoney(producto.precioDocena);

            productoCantidad.value = 1;

            productoSeleccionadoPanel.classList.remove('d-none');
            productoVacioMensaje.classList.add('d-none');
            productoDropdown.classList.add('d-none');
            productoBuscador.value = '';

            actualizarPanelProducto();
        };

        productoBuscador.addEventListener('input', () => {
            const texto = productoBuscador.value.trim().toLowerCase();
            if (!texto) {
                productoDropdown.classList.add('d-none');
                return;
            }
            const filtrados = productosDataset.filter((p) =>
                p.nombre.toLowerCase().includes(texto) || p.codigo.includes(texto)
            );
            renderProductoDropdown(filtrados);
        });

        document.addEventListener('click', (e) => {
            if (!productoDropdown.contains(e.target) && e.target !== productoBuscador) {
                productoDropdown.classList.add('d-none');
            }
        });

        productoCantidad.addEventListener('input', actualizarPanelProducto);

        btnQuitarProducto.addEventListener('click', () => {
            productoSeleccionado = null;
            productoSeleccionadoPanel.classList.add('d-none');
            productoVacioMensaje.classList.remove('d-none');
        });

        // -----------------------------------------
        // 4.5 Carrito
        // -----------------------------------------
        const carritoBody = document.getElementById('carritoBody');
        const carritoVacio = document.getElementById('carritoVacio');
        const resumenItems = document.getElementById('resumenItems');
        const resumenSubtotal = document.getElementById('resumenSubtotal');
        const resumenAhorro = document.getElementById('resumenAhorro');
        const resumenTotal = document.getElementById('resumenTotal');
        const btnRegistrarVenta = document.getElementById('btnRegistrarVenta');

        let carrito = [];

        const renderCarrito = () => {

            carritoBody.innerHTML = '';

            if (carrito.length === 0) {
                carritoBody.appendChild(carritoVacio);
            } else {

                carrito.forEach((item, index) => {

                    const subtotal = item.cantidad * item.precio;

                    const fila = document.createElement('tr');

                    fila.innerHTML =
                        '<td>' + item.nombre + '</td>' +
                        '<td>' + item.cantidad + '</td>' +
                        '<td><span class="badge bg-pink-light text-primary-custom">' + item.tarifaNombre + '</span></td>' +
                        '<td>' + formatMoney(item.precio) + '</td>' +
                        '<td class="fw-bold">' + formatMoney(subtotal) + '</td>' +
                        '<td class="text-end">' +
                        '<button type="button" class="btn btn-link text-danger p-0 btn-quitar-item" data-index="' + index + '" title="Quitar">' +
                        '<i class="bi bi-trash fs-6"></i>' +
                        '</button>' +
                        '</td>';

                    carritoBody.appendChild(fila);
                });
            }

            const totalItems = carrito.reduce((acc, item) => acc + Number(item.cantidad), 0);
            const totalMonto = carrito.reduce((acc, item) => acc + (item.cantidad * item.precio), 0);

            // Ahorro = lo que hubiera costado a precio unidad menos lo realmente cobrado
            const totalSinDescuento = carrito.reduce((acc, item) => acc + (item.cantidad * item.precioUnidadBase), 0);
            const ahorro = totalSinDescuento - totalMonto;

            resumenItems.textContent = totalItems;
            resumenSubtotal.textContent = formatMoney(totalMonto);
            resumenAhorro.textContent = formatMoney(ahorro);
            resumenTotal.textContent = formatMoney(totalMonto);

            document.querySelectorAll('.btn-quitar-item').forEach((btn) => {
                btn.addEventListener('click', function () {
                    const idx = Number(this.getAttribute('data-index'));
                    carrito.splice(idx, 1);
                    renderCarrito();
                });
            });
        };

        btnAgregarProducto.addEventListener('click', () => {

            if (!productoSeleccionado) {
                alert('Busca y selecciona un producto primero.');
                return;
            }

            const cantidad = Math.max(1, Number(productoCantidad.value) || 1);
            const tarifa = calcularTarifa(productoSeleccionado, cantidad);

            carrito.push({
                nombre: productoSeleccionado.nombre,
                cantidad,
                precio: tarifa.precio,
                precioUnidadBase: productoSeleccionado.precioUnidad,
                tarifaNombre: tarifa.nombre
            });

            renderCarrito();

            productoSeleccionado = null;
            productoSeleccionadoPanel.classList.add('d-none');
            productoVacioMensaje.classList.remove('d-none');
            productoBuscador.focus();
        });

        if (btnRegistrarVenta) {

            btnRegistrarVenta.addEventListener('click', () => {

                if (carrito.length === 0) {
                    alert('Agrega al menos un producto antes de registrar la venta.');
                    return;
                }

                if (!clienteSeleccionado) {
                    if (!confirm('No seleccionaste un cliente. ¿Deseas registrar la venta como "Cliente varios"?')) {
                        return;
                    }
                }

                // Aquí se debería enviar: clienteSeleccionado, carrito,
                // comprobante y la sede fija (ventaSedeFija.textContent)
                // al backend vía fetch/AJAX.
                alert('Venta registrada correctamente (simulado). Conecta este botón a tu servlet/controller para guardarla de verdad.');

                carrito = [];
                renderCarrito();

                clienteSeleccionado = null;
                clienteSeleccionadoChip.classList.add('d-none');
            });
        }

        renderCarrito();
    }


    // ==========================================
    // 5. Caja: estado compartido en memoria
    //    (se pierde al recargar la página; cuando
    //    conectes el backend, reemplaza esto por
    //    datos reales del servidor)
    // ==========================================
    const cajaState = {
        abierta: false,
        montoApertura: 0,
        ventasTurno: 0
    };


    // ------------------------------------------
    // 5.1 Apertura de Caja
    // ------------------------------------------
    const btnAperturarCaja = document.getElementById('btnAperturarCaja');

    if (btnAperturarCaja) {

        const aperturaFechaInput = document.getElementById('aperturaFecha');
        if (aperturaFechaInput) {
            aperturaFechaInput.value = new Date().toLocaleString('es-PE');
        }

        const estadoCajaBadge = document.getElementById('estadoCaja');

        btnAperturarCaja.addEventListener('click', () => {

            const montoInput = document.getElementById('aperturaMonto');
            const monto = Number(montoInput.value);

            if (isNaN(monto) || monto < 0) {
                alert('Ingresa un monto inicial válido.');
                return;
            }

            cajaState.abierta = true;
            cajaState.montoApertura = monto;
            cajaState.ventasTurno = 0;

            if (estadoCajaBadge) {
                estadoCajaBadge.textContent = 'CAJA ABIERTA';
                estadoCajaBadge.style.backgroundColor = '#22c55e';
            }

            btnAperturarCaja.disabled = true;
            montoInput.disabled = true;

            alert('Caja aperturada con S/ ' + monto.toFixed(2) + '. Ya puedes usar el Punto de Venta.');
        });
    }


    // ------------------------------------------
    // 5.2 Punto de Venta (POS)
    // ------------------------------------------
    const btnPosAgregar = document.getElementById('btnPosAgregar');

    if (btnPosAgregar) {

        const posCarritoBody = document.getElementById('posCarritoBody');
        const posCarritoVacio = document.getElementById('posCarritoVacio');
        const posTotalEl = document.getElementById('posTotal');
        const btnPosCobrar = document.getElementById('btnPosCobrar');

        let posCarrito = [];
        let metodoPagoActivo = 'Efectivo';

        const formatMoney = (valor) => 'S/ ' + valor.toFixed(2);

        const renderPosCarrito = () => {

            posCarritoBody.innerHTML = '';

            if (posCarrito.length === 0) {
                posCarritoBody.appendChild(posCarritoVacio);
            } else {

                posCarrito.forEach((item, index) => {

                    const subtotal = item.cantidad * item.precio;

                    const fila = document.createElement('tr');

                    fila.innerHTML =
                        '<td>' +
                        '<div class="fw-semibold" style="font-size:0.85rem;">' + item.nombre + '</div>' +
                        '<small class="text-muted">' + item.cantidad + ' x ' + formatMoney(item.precio) + '</small>' +
                        '</td>' +
                        '<td class="text-end fw-bold">' + formatMoney(subtotal) + '</td>' +
                        '<td class="text-end">' +
                        '<button type="button" class="btn btn-link text-danger p-0 btn-pos-quitar" data-index="' + index + '" title="Quitar">' +
                        '<i class="bi bi-x-circle fs-6"></i>' +
                        '</button>' +
                        '</td>';

                    posCarritoBody.appendChild(fila);
                });
            }

            const total = posCarrito.reduce((acc, item) => acc + (item.cantidad * item.precio), 0);
            posTotalEl.textContent = formatMoney(total);

            document.querySelectorAll('.btn-pos-quitar').forEach((btn) => {
                btn.addEventListener('click', function () {
                    const idx = Number(this.getAttribute('data-index'));
                    posCarrito.splice(idx, 1);
                    renderPosCarrito();
                });
            });
        };

        const agregarAlPos = (nombre, cantidad, precio) => {

            const existente = posCarrito.find((item) => item.nombre === nombre && item.precio === precio);

            if (existente) {
                existente.cantidad += cantidad;
            } else {
                posCarrito.push({ nombre, cantidad, precio });
            }

            renderPosCarrito();
        };

        // Productos rápidos
        document.querySelectorAll('.pos-producto').forEach((btn) => {
            btn.addEventListener('click', function () {
                const nombre = this.getAttribute('data-nombre');
                const precio = Number(this.getAttribute('data-precio'));
                agregarAlPos(nombre, 1, precio);
            });
        });

        // Producto manual
        btnPosAgregar.addEventListener('click', () => {

            const nombreInput = document.getElementById('posProductoNombre');
            const cantidadInput = document.getElementById('posProductoCantidad');
            const precioInput = document.getElementById('posProductoPrecio');

            const nombre = nombreInput.value.trim();
            const cantidad = Number(cantidadInput.value);
            const precio = Number(precioInput.value);

            if (!nombre || cantidad <= 0 || isNaN(precio) || precio < 0) {
                alert('Completa el nombre, la cantidad y el precio del producto.');
                return;
            }

            agregarAlPos(nombre, cantidad, precio);

            nombreInput.value = '';
            cantidadInput.value = 1;
            precioInput.value = '';
            nombreInput.focus();
        });

        // Método de pago
        document.querySelectorAll('.pos-metodo').forEach((btn) => {
            btn.addEventListener('click', function () {
                document.querySelectorAll('.pos-metodo').forEach((b) => b.classList.remove('active'));
                this.classList.add('active');
                metodoPagoActivo = this.getAttribute('data-metodo');
            });
        });

        // Cobrar
        if (btnPosCobrar) {

            btnPosCobrar.addEventListener('click', () => {

                if (!cajaState.abierta) {
                    alert('Primero debes aperturar la caja para poder cobrar.');
                    return;
                }

                if (posCarrito.length === 0) {
                    alert('Agrega al menos un producto al ticket.');
                    return;
                }

                const total = posCarrito.reduce((acc, item) => acc + (item.cantidad * item.precio), 0);

                cajaState.ventasTurno += total;

                alert('Venta cobrada por ' + formatMoney(total) + ' (' + metodoPagoActivo + '). (simulado)');

                posCarrito = [];
                renderPosCarrito();
            });
        }

        renderPosCarrito();
    }


    // ------------------------------------------
    // 5.3 Cierre de Caja
    // ------------------------------------------
    const btnCerrarCaja = document.getElementById('btnCerrarCaja');

    if (btnCerrarCaja) {

        const cierreApertura = document.getElementById('cierreApertura');
        const cierreVentasSistema = document.getElementById('cierreVentasSistema');
        const cierreEsperado = document.getElementById('cierreEsperado');
        const cierreContado = document.getElementById('cierreContado');
        const cierreDiferencia = document.getElementById('cierreDiferencia');

        const formatMoney = (valor) => 'S/ ' + valor.toFixed(2);

        const actualizarResumenCierre = () => {

            const esperado = cajaState.montoApertura + cajaState.ventasTurno;

            cierreApertura.textContent = formatMoney(cajaState.montoApertura);
            cierreVentasSistema.textContent = formatMoney(cajaState.ventasTurno);
            cierreEsperado.textContent = formatMoney(esperado);

            const contado = Number(cierreContado.value) || 0;
            const diferencia = contado - esperado;

            cierreDiferencia.textContent = formatMoney(diferencia);

            if (diferencia === 0) {
                cierreDiferencia.style.color = 'var(--text-heading)';
            } else if (diferencia > 0) {
                cierreDiferencia.style.color = '#22c55e';
            } else {
                cierreDiferencia.style.color = '#ef4444';
            }
        };

        cierreContado.addEventListener('input', actualizarResumenCierre);

        // Recalcular cada vez que se entra a esta vista
        document.querySelectorAll('.view-link[data-view="cierre-caja"]').forEach((link) => {
            link.addEventListener('click', actualizarResumenCierre);
        });

        btnCerrarCaja.addEventListener('click', () => {

            if (!cajaState.abierta) {
                alert('La caja no está aperturada.');
                return;
            }

            actualizarResumenCierre();

            cajaState.abierta = false;

            const estadoCajaBadge = document.getElementById('estadoCaja');
            if (estadoCajaBadge) {
                estadoCajaBadge.textContent = 'CAJA CERRADA';
                estadoCajaBadge.style.backgroundColor = '#ef4444';
            }

            alert('Caja cerrada correctamente. (simulado)');
        });

        actualizarResumenCierre();
    }


    // ==========================================
    // 6. Detalle de Ventas (filtro por fecha)
    // ==========================================
    const btnFiltrarDetalleVentas = document.getElementById('btnFiltrarDetalleVentas');

    if (btnFiltrarDetalleVentas) {

        // Datos de ejemplo. Reemplaza esto por lo que
        // te devuelva tu backend (fetch a un endpoint
        // que reciba fechaInicio / fechaFin).
        const ventasEjemplo = [
            { fecha: '2026-09-01T09:15:00', comprobante: 'B001-000501', cliente: 'Rosa Fernández', empleado: 'Luciana R.', metodo: 'Efectivo', total: 120.00 },
            { fecha: '2026-09-01T14:40:00', comprobante: 'B001-000502', cliente: 'Carlos Injante', empleado: 'Diego M.', metodo: 'Yape', total: 89.90 },
            { fecha: '2026-09-02T10:05:00', comprobante: 'F002-000091', cliente: 'Importadora Vega SAC', empleado: 'Luciana R.', metodo: 'Transacción', total: 2180.00 },
            { fecha: '2026-09-02T16:22:00', comprobante: 'B001-000503', cliente: 'Miguel Soto', empleado: 'Diego M.', metodo: 'Tarjeta', total: 159.90 },
            { fecha: '2026-09-03T11:10:00', comprobante: 'B001-000504', cliente: 'Ana Chávez', empleado: 'Luciana R.', metodo: 'Plin', total: 35.00 },
            { fecha: '2026-09-04T09:50:00', comprobante: 'B001-000505', cliente: 'Jorge Ramos', empleado: 'Diego M.', metodo: 'Sip', total: 64.50 },
            { fecha: '2026-09-05T13:35:00', comprobante: 'B001-000506', cliente: 'Rosa Fernández', empleado: 'Luciana R.', metodo: 'Efectivo', total: 250.00 }
        ];

        const detalleFechaInicio = document.getElementById('detalleFechaInicio');
        const detalleFechaFin = document.getElementById('detalleFechaFin');
        const detalleVentasBody = document.getElementById('detalleVentasBody');
        const detalleVentasVacio = document.getElementById('detalleVentasVacio');
        const btnLimpiarDetalleVentas = document.getElementById('btnLimpiarDetalleVentas');

        const detalleTotales = {
            general: document.getElementById('detalleTotalGeneral'),
            Efectivo: document.getElementById('detalleTotalEfectivo'),
            Tarjeta: document.getElementById('detalleTotalTarjeta'),
            Yape: document.getElementById('detalleTotalYape'),
            Plin: document.getElementById('detalleTotalPlin'),
            'Transacción': document.getElementById('detalleTotalTransaccion'),
            Sip: document.getElementById('detalleTotalSip')
        };

        const formatMoney = (valor) => 'S/ ' + valor.toFixed(2);

        const formatFechaHora = (isoString) => {
            const fecha = new Date(isoString);
            return fecha.toLocaleString('es-PE', {
                day: '2-digit', month: '2-digit', year: 'numeric',
                hour: '2-digit', minute: '2-digit'
            });
        };

        const renderDetalleVentas = () => {

            const inicio = detalleFechaInicio.value ? new Date(detalleFechaInicio.value + 'T00:00:00') : null;
            const fin = detalleFechaFin.value ? new Date(detalleFechaFin.value + 'T23:59:59') : null;

            const ventasFiltradas = ventasEjemplo.filter((venta) => {
                const fechaVenta = new Date(venta.fecha);
                if (inicio && fechaVenta < inicio) return false;
                if (fin && fechaVenta > fin) return false;
                return true;
            });

            detalleVentasBody.innerHTML = '';

            if (ventasFiltradas.length === 0) {
                detalleVentasBody.appendChild(detalleVentasVacio);
            } else {

                ventasFiltradas.forEach((venta) => {

                    const fila = document.createElement('tr');

                    fila.innerHTML =
                        '<td>' + formatFechaHora(venta.fecha) + '</td>' +
                        '<td class="text-primary-custom fw-bold">' + venta.comprobante + '</td>' +
                        '<td>' + venta.cliente + '</td>' +
                        '<td>' + venta.empleado + '</td>' +
                        '<td>' + venta.metodo + '</td>' +
                        '<td class="fw-bold">' + formatMoney(venta.total) + '</td>';

                    detalleVentasBody.appendChild(fila);
                });
            }

            // Recalcular totales por método + total general
            const acumulado = { Efectivo: 0, Tarjeta: 0, Yape: 0, Plin: 0, 'Transacción': 0, Sip: 0 };
            let totalGeneral = 0;

            ventasFiltradas.forEach((venta) => {
                if (acumulado.hasOwnProperty(venta.metodo)) {
                    acumulado[venta.metodo] += venta.total;
                }
                totalGeneral += venta.total;
            });

            detalleTotales.general.textContent = formatMoney(totalGeneral);
            Object.keys(acumulado).forEach((metodo) => {
                if (detalleTotales[metodo]) {
                    detalleTotales[metodo].textContent = formatMoney(acumulado[metodo]);
                }
            });
        };

        btnFiltrarDetalleVentas.addEventListener('click', renderDetalleVentas);

        if (btnLimpiarDetalleVentas) {
            btnLimpiarDetalleVentas.addEventListener('click', () => {
                detalleFechaInicio.value = '';
                detalleFechaFin.value = '';
                renderDetalleVentas();
            });
        }

        // Render inicial con todos los datos de ejemplo
        renderDetalleVentas();
    }


    // ==========================================
    // 7. Resumen del día en "Mis Ventas"
    // ==========================================
    const misVentasFechaHoy = document.getElementById('misVentasFechaHoy');

    if (misVentasFechaHoy) {

        const hoy = new Date();

        const formatFechaCorta = (fecha) => {
            const dd = String(fecha.getDate()).padStart(2, '0');
            const mm = String(fecha.getMonth() + 1).padStart(2, '0');
            const yyyy = fecha.getFullYear();
            return dd + '/' + mm + '/' + yyyy;
        };

        misVentasFechaHoy.textContent = formatFechaCorta(hoy);

        // Ventas de ejemplo del día para ESTE vendedor.
        // Reemplaza esto por lo que te devuelva tu backend
        // filtrando por usuario logueado + fecha de hoy.
        const misVentasHoy = [
            { metodo: 'Efectivo', total: 120.00 },
            { metodo: 'Yape', total: 89.90 },
            { metodo: 'Tarjeta', total: 159.90 },
            { metodo: 'Plin', total: 35.00 },
            { metodo: 'Transacción', total: 200.00 },
            { metodo: 'Sip', total: 64.50 }
        ];

        const misVentasSpans = {
            Efectivo: document.getElementById('misVentasEfectivo'),
            Tarjeta: document.getElementById('misVentasTarjeta'),
            Yape: document.getElementById('misVentasYape'),
            Plin: document.getElementById('misVentasPlin'),
            'Transacción': document.getElementById('misVentasTransaccion'),
            Sip: document.getElementById('misVentasSip')
        };

        const misVentasTotalHoy = document.getElementById('misVentasTotalHoy');

        const formatMoneyMisVentas = (valor) => 'S/ ' + valor.toFixed(2);

        const acumuladoHoy = { Efectivo: 0, Tarjeta: 0, Yape: 0, Plin: 0, 'Transacción': 0, Sip: 0 };
        let totalHoy = 0;

        misVentasHoy.forEach((venta) => {
            if (acumuladoHoy.hasOwnProperty(venta.metodo)) {
                acumuladoHoy[venta.metodo] += venta.total;
            }
            totalHoy += venta.total;
        });

        misVentasTotalHoy.textContent = formatMoneyMisVentas(totalHoy);

        Object.keys(acumuladoHoy).forEach((metodo) => {
            if (misVentasSpans[metodo]) {
                misVentasSpans[metodo].textContent = formatMoneyMisVentas(acumuladoHoy[metodo]);
            }
        });
    }

});