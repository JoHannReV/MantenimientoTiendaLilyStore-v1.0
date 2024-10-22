 function cargarDistritos(provinciaId, distritoId) {
	    var provincia = document.getElementById(provinciaId).value;
	    var distritoSelect = document.getElementById(distritoId);
	    
	    distritoSelect.innerHTML = ""; // Limpiar distritos

	    var distritos = {
	        "Lima": [
	            "Ancón", "Ate", "Barranco", "Breña", "Carabayllo", 
	            "Cercado de Lima", "Chaclacayo", "Chorrillos", 
	            "El Agustino", "Independencia", "Jesús María", 
	            "La Molina", "La Victoria", "Lince", "Los Olivos", 
	            "Magdalena del Mar", "Miraflores", "Pachacámac", 
	            "Pucusana", "Puente Piedra", "Rímac", "San Bartolo", 
	            "San Borja", "San Isidro", "San Juan de Lurigancho", 
	            "San Juan de Miraflores", "San Luis", 
	            "San Martín de Porres", "San Miguel", "Santa Anita", 
	            "Santa María del Mar", "Santiago de Surco", 
	            "Surquillo", "Villa El Salvador", "Villa María del Triunfo"
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

 function mostrarDetallesEmpleado(codigoEmp, nombre, apellido, email, numero, tipoDocumento, documento, provincia, distrito, direccion, sueldoBruto, sueldoNeto, pension, dstoPension, seguro, dstoSeguro, cargo, username, password) {
     document.getElementById('detalleId').innerText = codigoEmp;
     document.getElementById('detalleNombre').innerText = nombre;
     document.getElementById('detalleApellido').innerText = apellido;
     document.getElementById('detalleEmail').innerText = email;
     document.getElementById('detalleNumero').innerText = numero;
     document.getElementById('detalleTipoDocumento').innerText = tipoDocumento;
     document.getElementById('detalleDocumento').innerText = documento;
     document.getElementById('detalleProvincia').innerText = provincia;
     document.getElementById('detalleDistrito').innerText = distrito;
     document.getElementById('detalleDireccion').innerText = direccion;
     document.getElementById('detalleSueldoBruto').innerText = sueldoBruto;
     document.getElementById('detalleSueldoNeto').innerText = sueldoNeto;
     document.getElementById('detallePension').innerText = pension;
     document.getElementById('detalleDSTOPension').innerText = dstoPension;
     document.getElementById('detalleSeguro').innerText = seguro;
     document.getElementById('detalleDSTOSeguro').innerText = dstoSeguro;
     document.getElementById('detalleCargo').innerText = cargo;
     document.getElementById('detalleUsername').innerText = username;
     document.getElementById('detallePassword').innerText = password;

     // Muestra el modal
     $('#detalleEmpleadoModal').modal('show');
 }

 

     // Configuración de DataTables
     $(document).ready(function() {
         var table = $('#tablaEmpleados').DataTable({
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
         $('#tablaEmpleados_filter');
     });
     
   // Función para editar un empleado
 // Función para editar un empleado
 function editarEmpleado(codigo, documento, nombre, apellido, telefono, correo, tipoDocumento, documento, provincia, distrito, direccion, sueldo, tipoPension, tipoSeguro, cargoID, usuario, password) {
     document.getElementById('id_empleado_editar').value = codigo;
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
     document.getElementById('sueldo_editar').value = sueldo;
     document.getElementById('tipoPension_editar').value = tipoPension;
     document.getElementById('tipoSeguro_editar').value = tipoSeguro;
     document.getElementById('cargo_editar').value = cargoID;
     document.getElementById('usuario_editar').value = usuario;
     document.getElementById('password_editar').value = password;

     // Muestra el modal para editar
     $('#editarEmpleadoModal').modal('show');
     console.log("Usuario:", usuario);
     console.log("Contraseña:", password);

   }



     // Función para eliminar un empleado
     function eliminarEmpleado(codigoEmp) {
     // Confirmación de eliminación del empleado 
     if (confirm('¿ESTÁS SEGURO DE ELIMINAR A ESTE EMPLEADO?')) {
         // Crear un formulario temporal para enviar el código del empleado al controlador
         const form = document.createElement("form");
         form.method = "POST"; 
         form.action = "controladorEmpleado"; // Acción del formulario
         
         // Crear un input oculto para enviar el código del empleado
         const input = document.createElement("input");
         input.type = "hidden";
         input.name = "action"; // El nombre debe coincidir con el que esperas en el servlet
         input.value = "eliminar"; // El valor que identificarás en el servlet
         
         const inputCodigo = document.createElement("input");
         inputCodigo.type = "hidden";
         inputCodigo.name = "txtCodigoEmpleado"; // El nombre que espera tu servlet
         inputCodigo.value = codigoEmp; // Valor del ID del empleado

         form.appendChild(input); // Agregar el campo de acción
         form.appendChild(inputCodigo); // Agregar el campo de código

         // Agregar el formulario al body y enviarlo
         document.body.appendChild(form);
         form.submit();
     }
 }

     $(document).ready(function() {
         $('#tablaEmpleados').DataTable();
     });
 