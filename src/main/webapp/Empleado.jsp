<%@page import="model.Empleado"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/Empleado.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">

<style >

/* Estilo para el botón de regresar */
.btn-regresar {
    background-color: #ff5722; /* Color de fondo naranja */
    color: white; /* Color del texto */
    border: none; /* Sin borde */
    border-radius: 5px; /* Bordes redondeados */
    padding: 10px 20px; /* Espaciado interno */
    font-size: 1rem; /* Tamaño de la fuente */
    cursor: pointer; /* Cambia el cursor al pasar por encima */
    transition: background-color 0.3s, transform 0.3s; /* Efecto de transición */
}

.btn-regresar:hover {
    background-color: #e64a19; /* Color de fondo más oscuro al pasar el mouse */
    transform: scale(1.05); /* Aumentar tamaño al pasar el mouse */
}


/* Estilo para el botón de Nuevo Empleado */
.btn-nuevo-empleado {
    background-color: #28a745; /* Color de fondo verde */
    color: white; /* Color del texto */
    border: none; /* Sin borde */
    border-radius: 8px; /* Bordes redondeados */
    padding: 12px 24px; /* Espaciado interno */
    font-size: 1.1rem; /* Tamaño de la fuente */
    cursor: pointer; /* Cambia el cursor al pasar por encima */
    transition: background-color 0.3s, transform 0.3s; /* Efecto de transición */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Sombra */
}

/* Efecto al pasar el mouse */
.btn-nuevo-empleado:hover {
    background-color: #218838; /* Color más oscuro al pasar el mouse */
    transform: scale(1.05); /* Aumentar tamaño al pasar el mouse */
}

/* Efecto al hacer clic */
.btn-nuevo-empleado:active {
    transform: scale(0.95); /* Reducir tamaño al hacer clic */
}



/* Estilos para el contenedor de la tabla */
.table-container {
    display: flex; /* Usar flexbox para centrar contenido */
    flex-direction: column; /* Dirección de columna */
    justify-content: center; /* Centrando verticalmente */
    align-items: center; /* Centrando horizontalmente */
    margin: 20px auto; /* Margen superior e inferior */
    background-color: rgba(255, 165, 0, 0.1); /* Fondo suave */
    border-radius: 10px; /* Bordes redondeados */
    padding: 20px; /* Espaciado interno */
    max-width: 90%; /* Ancho máximo del contenedor */
    height: 100%; /* Para asegurarse de que ocupa el 100% de la altura disponible */
}

/* Estilos para la tabla */
.table {
    width: 100%; /* Mantener la tabla al 100% de su contenedor */
    border-collapse: collapse; /* Colapsar bordes */
    margin: 0 auto; /* Centrar la tabla */
}

/* Encabezados de la tabla */
.table th {
    background-color: #ffcc80; /* Fondo naranja suave para los encabezados */
    color: #333; /* Color del texto oscuro */
    padding: 12px; /* Espaciado interno */
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Fuente elegante */
    text-align: left; /* Alinear texto a la izquierda */
    font-size: 1.1rem; /* Tamaño de fuente */
    font-weight: bold; /* Negrita */
}

/* Filas de la tabla */
.table td {
    border: 1px solid #ddd; /* Bordes claros */
    padding: 12px; /* Espaciado interno */
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Fuente elegante */
    font-size: 1rem; /* Tamaño de fuente */
    font-weight: bold; /* Negrita */
}

/* Filas al pasar el mouse */
.table tbody tr:hover {
    background-color: rgba(255, 165, 0, 0.2); /* Fondo más claro al pasar el mouse */
}

/* Estilo para los botones de editar y eliminar */
.table .btn {
    background-color: transparent; /* Sin fondo */
    border: none; /* Sin borde */
    padding: 0; /* Sin padding */
    font-size: 1rem; /* Tamaño de fuente */
    font-weight: bold; /* Negrita */
    cursor: pointer; /* Cambia el cursor al pasar por encima */
    transition: color 0.3s; /* Efecto de transición */
}

/* Color y estilos del botón Editar */
.table .btn-edit {
    color: #007bff; /* Color azul */
}

/* Color y estilos del botón Eliminar */
.table .btn-delete {
    color: #dc3545; /* Color rojo */
}

/* Efecto hover para los botones */
.table .btn:hover {
    text-decoration: underline; /* Subrayar texto al pasar el mouse */
}


/* Estilo para el campo de búsqueda */
.dataTables_filter input {
    width: 200px; /* Ajusta el ancho según tu preferencia */
    padding: 5px; /* Espaciado interno */
    border: 2px solid #ff5722; /* Color de borde */
    border-radius: 5px; /* Bordes redondeados */
    font-size: 1rem; /* Tamaño de la fuente */
}

.dataTables_filter label {
    font-weight: bold; /* Texto en negrita */
    color: #ff5722; /* Color del texto */
    font-family: 'Arial', sans-serif; /* Cambia la fuente si lo deseas */
}

/* Estilo para el texto de búsqueda y otros textos relacionados */
.dataTables_filter label, /* Texto "Buscar" */
.dataTables_length label, /* Texto "Mostrar entradas" */
.dataTables_info { /* Texto de información de la tabla */
    font-weight: bold; /* Negrita */
    color: black; /* Color negro */
    font-size: 1.1rem; /* Aumenta el tamaño de la fuente */
}

/* Estilo para el input del buscador */
.dataTables_filter input {
    margin-left: 10px; /* Espacio entre el texto y el input */
}

/* Estilo para los textos que muestran información sobre la tabla */
.dataTables_info {
    font-weight: bold; /* Negrita */
    color: black; /* Color negro */
    font-size: 1.1rem; /* Aumenta el tamaño de la fuente */
}


</style>

<title>Gestion de Empleados</title>
   
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col text-start">
            <a href="Menu.jsp" class="btn btn-primary mt-3">HOME</a>
            <a href="controladorCliente?menu=Cliente&accion=Listar" class="btn btn-primary mt-3">CLIENTES</a>
        </div>
    </div>


    
   
<div class="container">
    <h1 class="text-center mt-5">MANTENIMIENTO EMPLEADOS</h1>
    
<div class="container text-center">
    <button type="button" class="btn btn-nuevo-empleado mt-3" data-bs-toggle="modal" data-bs-target="#nuevoEmpleadoModal">Nuevo Empleado</button>
</div>


<!-- MODAL PARA AGREGAR EMPLEADO  -->

   <!-- MODAL PARA AGREGAR EMPLEADO  -->
<div class="modal fade" id="nuevoEmpleadoModal" tabindex="-1" aria-labelledby="nuevoEmpleadoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="nuevoEmpleadoModalLabel">NUEVO EMPLEADO</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="controladorEmpleado?menu=Empleado&accion=Agregar" method="post">
                    <input type="hidden" name="action" value="agregar"> <!-- accion para el void -->
                    <input type="hidden" name="codigoEmp"> <!-- Si necesitas el código del empleado -->

                    <div class="mb-3">
                        <label for="txtNombres" class="form-label">Nombres</label>
                        <input type="text" class="form-control" id="txtNombres" name="txtNombres" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtApellidos" class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="txtApellidos" name="txtApellidos" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtCorreo" class="form-label">Correo</label>
                        <input type="email" class="form-control" id="txtCorreo" name="txtCorreo" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtTelefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="txtTelefono" name="txtTelefono" required pattern="\d+" title="Solo se permiten números">
                    </div>
                    <div class="mb-3">
                        <label for="txtTipoDocumento" class="form-label">Tipo de Documento</label>
                        <select class="form-select" id="txtTipoDocumento" name="txtTipoDocumento" required>
                            <option value="DNI">DNI</option>
                            <option value="RUC">RUC</option>
                            <option value="CE">CE</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtDocumento" class="form-label">Documento</label>
                        <input type="text" class="form-control" id="txtDocumento" name="txtDocumento" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtProvincia" class="form-label">Provincia</label>
                        <select class="form-select" id="txtProvincia" onchange="cargarDistritos('txtProvincia', 'txtDistrito')" name="txtProvincia"  required>
                            <option value="Lima">Lima</option>
                            <option value="Amazonas">Amazonas</option>
                            <!-- Agregar más provincias aquí -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtDistrito" class="form-label">Distrito</label>
                        <select class="form-select" id="txtDistrito" name="txtDistrito" required>
                            <option value="">Seleccione una provincia primero</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtDireccion" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="txtDireccion" name="txtDireccion" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtSueldo" class="form-label">Sueldo Bruto</label>
                        <input type="number" step="0.01" class="form-control" id="txtSueldo" name="txtSueldo" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtTipoPension" class="form-label">Tipo de Pensión</label>
                        <select class="form-select" id="txtTipoPension" name="txtTipoPension" required>
                            <option value="ONP">ONP</option>
                            <option value="AFP">AFP</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtTipoSeguro" class="form-label">Tipo de Seguro</label>
                        <select class="form-select" id="txtTipoSeguro" name="txtTipoSeguro" required>
                            <option value="ESSALUD">ESSALUD</option>
                            <option value="SIS">SIS</option>
                            <option value="Privado">Privado</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtCargoID" class="form-label">Cargo</label>
                        <select class="form-select" id="txtCargoID" name="txtCargoID" required>
                            <option value="1">Vendedor</option>
                            <option value="2">Supervisor</option>
                            <option value="3">Almacenero</option>
                            <option value="4">Administrador</option>
                        </select>
                    </div>
                    <!-- Nuevos campos para usuario y contraseña -->
                    <div class="mb-3">
                        <label for="txtUsuario" class="form-label">Nuevo Usuario</label>
                        <input type="text" class="form-control" id="txtUsuario" name="txtUsuario" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Nueva Contraseña</label>
                        <input type="password" class="form-control" id="txtPassword" name="txtPassword" required>
                    </div>
                    <button type="submit" class="btn btn-warning">Agregar</button>
                </form>
            </div>
        </div>
    </div>
</div>
       <!-- Modal para la tabla  -->
 <div class="table-container">       
<table id="tablaEmpleados" class="table table-striped-columns" style="width:100%">
    <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Email</th>
            <th>Número</th>
            <th>Tipo.Doc</th>
            <th>Nro.Doc</th>
            <th>Sueldo.Nto</th>
            <th>Pensión</th>
            <th>Seguro</th>
            <th>Cargo</th>
            <th>User</th>
            <th>Acciones</th>
        </tr>
    </thead>
  <tbody>
<% 
List<Empleado> listado = (List<Empleado>) request.getAttribute("listado"); 
if (listado != null && !listado.isEmpty()) { 
    for (Empleado lis : listado) { 
%>
    <tr onclick="mostrarDetallesEmpleado(
    <%= lis.getCodigoEmp() %>, 
    '<%= lis.getNombreEmp() %>', 
    '<%= lis.getApellidoEmp() %>', 
    '<%= lis.getEmailEmp() %>', 
    '<%= lis.getNumeroEmp() %>', 
    '<%= lis.getTipoDocumento() %>', 
    '<%= lis.getDocumentoEmp() %>', 
    '<%= lis.getProvinciaEmp() %>', 
    '<%= lis.getDistritoEmp() %>', 
    '<%= lis.getDireccionEmp() %>', 
    '<%= lis.getSueldoBrutoEmp() %>', 
    '<%= lis.getSueldoNetoEmp() %>', 
    '<%= lis.getTipoPensionEmp() %>', 
    '<%= lis.getDescuentoPensionEmp() %>', 
    '<%= lis.getTipoSeguroEmp() %>', 
    '<%= lis.getDescuentoSeguroEmp() %>', 
    '<%= lis.getCargo() != null ? lis.getCargo().getNombreCargo() : "" %>', 
    '<%= lis.getUsuariosacceso() != null ? lis.getUsuariosacceso().getUsername() : "" %>', 
    '<%= lis.getUsuariosacceso() != null ? lis.getUsuariosacceso().getPassword() : "" %>'
)">

        <td><%= lis.getCodigoEmp() %></td>
        <td><%= lis.getNombreEmp() %></td>
        <td><%= lis.getApellidoEmp() %></td>
        <td><%= lis.getEmailEmp() %></td>
        <td><%= lis.getNumeroEmp() %></td>
        <td><%= lis.getTipoDocumento() %></td>
        <td><%= lis.getDocumentoEmp() %></td>
        <td><%= lis.getSueldoNetoEmp() %></td>
        <td><%= lis.getTipoPensionEmp() %></td>
        <td><%= lis.getTipoSeguroEmp() %></td>
        <td><%= lis.getCargo() != null ? lis.getCargo().getNombreCargo() : "" %></td>
        <td><%= lis.getUsuariosacceso() != null ? lis.getUsuariosacceso().getUsername() : "" %></td>
        <td>
            <button type="button" class="btn btn-edit btn-sm" 
             onclick="editarEmpleado(
        <%= lis.getCodigoEmp() %>, 
        '<%= lis.getDocumentoEmp() %>', 
        '<%= lis.getNombreEmp() %>', 
        '<%= lis.getApellidoEmp() %>', 
        '<%= lis.getNumeroEmp() %>', 
        '<%= lis.getEmailEmp() %>', 
        '<%= lis.getTipoDocumento() %>', 
        '<%= lis.getDocumentoEmp() %>', 
        '<%= lis.getProvinciaEmp() %>', 
        '<%= lis.getDistritoEmp() %>', 
        '<%= lis.getDireccionEmp() %>', 
        '<%= lis.getSueldoBrutoEmp() %>', 
        '<%= lis.getTipoPensionEmp() %>', 
        '<%= lis.getTipoSeguroEmp() %>', 
        '<%= lis.getCargo() != null ? lis.getCargo().getCargoID() : "" %>', 
        '<%= lis.getUsuariosacceso() != null ? lis.getUsuariosacceso().getUsername() : "" %>', 
        '<%= lis.getUsuariosacceso() != null ? lis.getUsuariosacceso().getPassword() : "" %>'
    ); event.stopPropagation();">Editar</button>

            <button type="button" class="btn btn-delete btn-sm" onclick="eliminarEmpleado(<%= lis.getCodigoEmp() %>)">Eliminar</button>
        </td>
    </tr>
<% 
    } 
} else { 
%>
    <tr>
        <td colspan="19">No se encontraron empleados.</td> <!-- Asegúrate que el colspan coincide con el número de columnas -->
    </tr>
<% 
} 
%>
</tbody>

</table>
</div>

<!-- Modal -->
<div class="modal fade" id="detalleEmpleadoModal" tabindex="-1" role="dialog" aria-labelledby="detalleEmpleadoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detalleEmpleadoModalLabel">Detalles del Empleado</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>ID: <span id="detalleId"></span></p>
                <p>Nombre: <span id="detalleNombre"></span></p>
                <p>Apellido: <span id="detalleApellido"></span></p>
                <p>Email: <span id="detalleEmail"></span></p>
                <p>Número: <span id="detalleNumero"></span></p>
                <p>Tipo Documento: <span id="detalleTipoDocumento"></span></p>
                <p>Documento: <span id="detalleDocumento"></span></p>
                <p>Provincia: <span id="detalleProvincia"></span></p>
                <p>Distrito: <span id="detalleDistrito"></span></p>
                <p>Dirección: <span id="detalleDireccion"></span></p>
                <p>Sueldo Bruto: <span id="detalleSueldoBruto"></span></p>
                <p>Sueldo Neto: <span id="detalleSueldoNeto"></span></p>
                <p>Pensión: <span id="detallePension"></span></p>
                <p>Dcto. Pensión: <span id="detalleDSTOPension"></span></p>
                <p>Seguro: <span id="detalleSeguro"></span></p>
                <p>Dcto. Seguro: <span id="detalleDSTOSeguro"></span></p>
                <p>Cargo: <span id="detalleCargo"></span></p>
                <p>User: <span id="detalleUsername"></span></p>
                <p>Password: <span id="detallePassword"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#detalleEmpleadoModal').modal('hide');">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal para editar empleado -->
<div class="modal fade" id="editarEmpleadoModal" tabindex="-1" aria-labelledby="editarEmpleadoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Encabezado del modal -->
            <div class="modal-header">
                <h5 class="modal-title" id="editarEmpleadoModalLabel">Editar Empleado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <!-- Formulario para editar empleado -->
                <form action="controladorEmpleado?menu=Empleado&accion=Actualizar" method="post">
                    <input type="hidden" name="action" value="actualizar"> <!-- acción para el void -->
                    <input type="hidden" id="id_empleado_editar" name="codigoEmp"> <!-- Campo oculto para el ID del empleado -->

                    <div class="mb-3">
                        <label for="txtNombres" class="form-label">Nombres</label>
                        <input type="text" class="form-control" id="nombres_editar" name="txtNombres" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtApellidos" class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="apellidos_editar" name="txtApellidos" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtCorreo" class="form-label">Correo</label>
                        <input type="email" class="form-control" id="correo_editar" name="txtCorreo" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtTelefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="telefono_editar" name="txtTelefono" required pattern="\d+" title="Solo se permiten números">
                    </div>
                    <div class="mb-3">
                        <label for="txtTipoDocumento" class="form-label">Tipo de Documento</label>
                        <select class="form-select" id="tipoDocumento_editar" name="txtTipoDocumento" required>
                            <option value="DNI">DNI</option>
                            <option value="RUC">RUC</option>
                            <option value="CE">CE</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtDocumento" class="form-label">Documento</label>
                        <input type="text" class="form-control" id="documento_editar" name="txtDocumento" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtProvincia" class="form-label">Provincia</label>
                        <select class="form-select" id="provincia_editar" onchange="cargarDistritos('provincia_editar', 'distrito_editar')" name="txtProvincia" required>
                            <option value="Lima">Lima</option>
                            <option value="Amazonas">Amazonas</option>
                            <!-- Agregar más provincias aquí -->
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="txtDistrito" class="form-label">Distrito</label>
                        <select class="form-select" id="distrito_editar" name="txtDistrito" required>
                            <option value="">Seleccione una provincia primero</option>
                        </select>
                    </div>
                     
                    
                    <div class="mb-3">
                        <label for="txtDireccion" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="direccion_editar" name="txtDireccion" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtSueldo" class="form-label">Sueldo Bruto</label>
                        <input type="number" step="0.01" class="form-control" id="sueldo_editar" name="txtSueldo" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtTipoPension" class="form-label">Tipo de Pensión</label>
                        <select class="form-select" id="tipoPension_editar" name="txtTipoPension" required>
                            <option value="ONP">ONP</option>
                            <option value="AFP">AFP</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtTipoSeguro" class="form-label">Tipo de Seguro</label>
                        <select class="form-select" id="tipoSeguro_editar" name="txtTipoSeguro" required>
                            <option value="ESSALUD">ESSALUD</option>
                            <option value="SIS">SIS</option>
                            <option value="Privado">Privado</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtCargoID" class="form-label">Cargo</label>
                        <select class="form-select" id="cargo_editar" name="txtCargoID" required>
                            <option value="1">Vendedor</option>
                            <option value="2">Supervisor</option>
                            <option value="3">Almacenero</option>
                            <option value="4">Administrador</option>
                        </select>
                    </div>
                      <div class="mb-3">
                        <label for="txtUsuario" class="form-label">Nuevo Usuario</label>
                        <input type="text" class="form-control" id="usuario_editar" name="txtUsuario" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Nueva Contraseña</label>
                        <input type="password" class="form-control" id="password_editar" name="txtPassword" required>
                    </div>
                    
                    
                    <button type="submit" class="btn btn-warning">Actualizar</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

   <script src="js/Empleado.js"></script>

</body>
</html>