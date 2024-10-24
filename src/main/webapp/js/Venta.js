function mostrarDetallesVenta(idventa, documento, tipodocumento, codigoclie, nombreclie, apellidoclie, codigoprod, prendaprod, nombrepro, categoria, talla, cantidad, descuento, total, fechaVenta, fechaModificacion) {
   
    
    // Datos del Cliente
    document.getElementById('detalleidventa').textContent = idventa;
    document.getElementById('detalletipodocumento').textContent = tipodocumento;
    document.getElementById('detalledocumento').textContent = documento;
    document.getElementById('detalleIdCliente').textContent = codigoclie;
    document.getElementById('detalleNombreCliente').textContent = nombreclie;
    document.getElementById('detalleApellidoCliente').textContent = apellidoclie;

    // Datos del Producto
    document.getElementById('detalleIdProducto').textContent = codigoprod;
    document.getElementById('detallePrenda').textContent = prendaprod;
    document.getElementById('detalleCategoria').textContent = categoria;
    document.getElementById('detalleTalla').textContent = talla;
    document.getElementById('detalleCantidad').textContent = cantidad;
    document.getElementById('detalleDescuento').textContent = descuento;
    document.getElementById('detalleTotal').textContent = total;

    // Fechas
    document.getElementById('detalleFechaVenta').textContent = fechaVenta;
    document.getElementById('detalleModificacion').textContent = fechaModificacion;

    // Mostrar el modal
    $('#modalDetalles').modal('show');
}

function buscarCliente() {
    var documento = document.getElementById("txtdocumento").value;
    if (documento) {
        // Redirige a la acción de búsqueda en el servlet
        window.location.href = "controladorVenta?action=buscarCliente&txtdocumento=" + documento;
    } else {
        alert("Por favor, ingrese un documento.");
    }
}


function limpiarCampos(formId) {
    var form = document.getElementById(formId);
    var inputs = form.getElementsByTagName('input');
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].type !== 'hidden') {
            inputs[i].value = '';
        }
    }
}



