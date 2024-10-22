 function cargarDistritos(provinciaId, distritoId) {
	    var provincia = document.getElementById(provinciaId).value;
	    var distritoSelect = document.getElementById(distritoId);
	    
	    distritoSelect.innerHTML = ""; // Limpiar distritos

	    var distritos = {
	        "Lima": [
	            "Ancon", "Ate", "Barranco", "Breña", "Carabayllo", 
	            "Cercado de Lima", "Chaclacayo", "Chorrillos", 
	            "El Agustino", "Independencia", "Jesús María", 
	            "La Molina", "La Victoria", "Lince", "Los Olivos", 
	            "Magdalena del Mar", "Miraflores", "Pachacámac", 
	            "Pucusana", "Puente Piedra", "Rimac", "San Bartolo", 
	            "San Borja", "San Isidro", "San Juan de Lurigancho", 
	            "San Juan de Miraflores", "San Luis", 
	            "San Martín de Porres", "San Miguel", "Santa Anita", 
	            "Santa María del Mar", "Santiago de Surco", 
	            "Surquillo", "Villa El Salvador", "Villa Maria del Triunfo"
	        ],
	        "Amazonas": [
	            "Chachapoyas", "Asunción", "Balsas", "Cheto", "Cochamal", 
	            "La Jalca", "Levanto", "Magdalena", "Mariscal Castilla", 
	            "San Francisco de Daguas", "San Isidro de Maino", "Tingo"
	        ],
	        // Agregar más provincias y sus distritos aquí...
	    };

	    var distritosProvincia = distritos[provincia] || [];
	    for (var i = 0; i < distritosProvincia.length; i++) {
	        var option = document.createElement("option");
	        option.value = distritosProvincia[i];
	        option.text = distritosProvincia[i];
	        distritoSelect.add(option);
	    }
	}

 function mostrarDetallesCliente(codigoClie, nombre, apellido, email, numero, tipoDocumento, documento, provincia, distrito, direccion) {
     document.getElementById('detalleId').innerText = codigoClie;
     document.getElementById('detalleNombre').innerText = nombre;
     document.getElementById('detalleApellido').innerText = apellido;
     document.getElementById('detalleEmail').innerText = email;
     document.getElementById('detalleNumero').innerText = numero;
     document.getElementById('detalleTipoDocumento').innerText = tipoDocumento;
     document.getElementById('detalleDocumento').innerText = documento;
     document.getElementById('detalleProvincia').innerText = provincia;
     document.getElementById('detalleDistrito').innerText = distrito;
     document.getElementById('detalleDireccion').innerText = direccion;
     

     // Muestra el modal
     $('#detalleClienteModal').modal('show');
 }

 

     // Configuración de DataTables
     $(document).ready(function() {
         var table = $('#tablaCliente').DataTable({
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
         $('#tablaClientes_filter');
     });
     
   // Función para editar un empleado
 // Función para editar un empleado
 function editarCliente(codigo, documento, nombre, apellido, telefono, correo, tipoDocumento, documento, provincia, distrito, direccion) {
     document.getElementById('id_cliente_editar').value = codigo;
     document.getElementById('documento_editar').value = documento;
     document.getElementById('nombres_editar').value = nombre;
     document.getElementById('apellidos_editar').value = apellido;
     document.getElementById('telefono_editar').value = telefono;
     document.getElementById('correo_editar').value = correo;
     document.getElementById('tipoDocumento_editar').value = tipoDocumento;
     document.getElementById('documento_editar').value = documento;
     document.getElementById('provincia_editar').value = provincia;
     document.getElementById('distrito_editar').value = distrito;
     document.getElementById('direccion_editar').value = direccion;
    
     // Muestra el modal para editar
     $('#editarClienteModal').modal('show');
   

   }



//Función para eliminar un cliente
 function eliminarCliente(codigoClie) {
     if (confirm('¿ESTÁS SEGURO DE ELIMINAR A ESTE Cliente?')) {
         const form = document.createElement("form");
         form.method = "POST"; 
         form.action = "controladorCliente"; 

         const input = document.createElement("input");
         input.type = "hidden";
         input.name = "action"; 
         input.value = "eliminar"; 

         const inputCodigo = document.createElement("input");
         inputCodigo.type = "hidden";
         inputCodigo.name = "txtCodigoCliente";
         inputCodigo.value = codigoClie; 

         console.log("Enviando código de cliente para eliminar:", codigoClie); 

         form.appendChild(input); 
         form.appendChild(inputCodigo); 

         document.body.appendChild(form);
         form.submit();
     }
 }


     $(document).ready(function() {
         $('#tablaClientes').DataTable();
     });
     