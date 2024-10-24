
 function mostrarDetallesProducto(codigoProd,marca,prenda ,nombre, categoria, descripcion, talla, lote, precioingreso, ganancia, descuento, precio, stock, ingreso, modificacion)
 {
     document.getElementById('detalleId').innerText = codigoProd;
     document.getElementById('detalleMarca').innerText = marca;
     document.getElementById('detallePrenda').innerText = prenda;
     document.getElementById('detalleNombre').innerText = nombre;
     document.getElementById('detalleCategoria').innerText = categoria;
     document.getElementById('detalleDescripcion').innerText = descripcion;
     document.getElementById('detalleTalla').innerText = talla;
     document.getElementById('detalleLote').innerText = lote;
     document.getElementById('detallePrecioIngreso').innerText = precioingreso;
     document.getElementById('detalleGanancia').innerText = ganancia;
     document.getElementById('detallePrecio').innerText = precio;
     document.getElementById('detalleDescuento').innerText = descuento;
     document.getElementById('detalleStock').innerText = stock;
     document.getElementById('detalleIngreso').innerText = ingreso;
     document.getElementById('detalleModificacion').innerText = modificacion;

     
  
     
     
     // Muestra el modal
     $('#detalleProductoModal').modal('show');
 }

 

     // Configuración de DataTables
     $(document).ready(function() {
         var table = $('#tablaProducto').DataTable({
             language: {
                 "sProcessing": "Procesando...",
                 "sLengthMenu": "Mostrar _MENU_ registros",
                 "sZeroRecords": "No se encontraron resultados",
                 "sEmptyTable": "Ningún dato disponible en esta tabla",
                 "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_",
                 "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0",
                 "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                 "sInfoPostFix": "",
                 "sSearch": "Buscar:",
                 "sUrl": "",
                 "sInfoThousands": ",",
                 "sLoadingRecords": "Cargando...",
                 "oPaginate": {
                     "sFirst": "Primero",
                     "sLast": "Último",
                     "sNext": "Siguiente",
                     "sPrevious": "Anterior"
                 },
                 "oAria": {
                     "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                     "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                 }
             }
         });

         // Eliminar la caja de texto junto al search
         $('#tablaProducto_filter');
     });
     
 // Función para editar  
     function editarProducto(codigo, marca, prenda, nombre, categoria, descripcion, talla, lote, precio, descuento, stock) {
    	    document.getElementById('id_producto_editar').value = codigo;
    	    document.getElementById('marcaID_editar').value = marca; // Asigna el valor de la marca
    	    document.getElementById('prenda_editar').value = prenda;
    	    document.getElementById('nombres_editar').value = nombre;
    	    document.getElementById('categoria_editar').value = categoria;
    	    document.getElementById('descripcion_editar').value = descripcion;
    	    document.getElementById('talla_editar').value = talla;
    	    document.getElementById('lote_editar').value = lote;
    	    document.getElementById('precio_editar').value = precio;
    	    document.getElementById('descuento_editar').value = descuento;
    	    document.getElementById('stock_editar').value = stock;

    	    // Muestra el modal para editar
    	    $('#editarProductoModal').modal('show');
    	    console.log("Código:", codigo);
    	    console.log("Marca:", marca);
    	    console.log("Prenda:", prenda);

     }

     



  // Función para eliminar un producto
     function eliminarProducto(codigoProd) {
         if (confirm("¿Estás seguro de que deseas eliminar este producto?")) {
             $.ajax({
                 url: 'controladorProducto', // URL del servlet
                 type: 'POST',
                 data: {
                     accion: 'eliminar', // acción específica para eliminar
                     codigoProd: codigoProd
                 },
                 success: function(response) {
                     alert("Producto eliminado correctamente");
                     location.reload(); // Recargar la página después de la eliminación
                 },
                 error: function(xhr, status, error) {
                     alert("Hubo un error al eliminar el producto: " + error);
                 }
             });
         }
     }

     
     $(document).ready(function() {
         $('#tablaProductos').DataTable();
     });
     
     