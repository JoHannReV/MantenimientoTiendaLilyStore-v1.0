<%@page import="model.Cliente"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">

<style>

body {
    background-image: url('https://img.freepik.com/free-vector/abstract-minimal-white-background_23-2148887988.jpg?t=st=1729533692~exp=1729537292~hmac=d741cc6cb4f413bfc0c1463927993d8d9d2a63d52af95b30e4c29c6c0f9964c2&w=826'); /* Fondo con la imagen */
    background-size: cover; 
    background-position: center; 
    margin: 0; 
    padding: 20px; 
    font-family: Arial, sans-serif; 
}

.btn-menu {
    font-weight: normal;
    font-size: 1rem;
    border: none;
    
    background-color: transparent;
    transition: transform 0.3s, font-weight 0.3s;
}

.btn-menu:hover {
    font-weight: bold;
    transform: scale(1.1);
}

.titulo-clientes {
    margin-top: 20px; 
    font-size: 3rem;
    font-weight: bold; 
    font-family: 'Arial', sans-serif; 
}


.btn-nuevo-cliente {
    background-color: rgba(34, 139, 34, 0.85); 
    color: white;
    border: none;
    padding: 9px 30px;
    font-size: 1rem;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn-nuevo-cliente:hover {
    background-color: rgba(34, 139, 34, 1); 
}


.table-container {
    background-color: white; 
    padding: 20px; 
    border-radius: 8px; 
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); 
}

.table {
    width: 100%;
    border-collapse: collapse; 
}

th {
    background-color: transparent; 
    border-bottom: 2px solid #ccc; 
    padding: 10px; 
    text-align: left; 
    
}

td {
    padding: 10px; 
    border-bottom: 1px solid #eee; 
}

.btn-edit {
    background-color: transparent; 
    color: blue; /
    font-weight: bold;
        border: none; 
    cursor: pointer; 
}

.btn-delete {
    background-color: transparent; 
    color: red; 
    font-weight: bold;
    border: none; 
    cursor: pointer;
}

.btn-edit:hover, .btn-delete:hover {
    text-decoration: underline; 
}

</style>

<title>Gestion Clientes</title>
   
</head>
<body>

 <div class="container">
    <div class="row">
        <div class="col text-start">
            <a href="Menu.jsp" class="btn btn-menu mt-3">HOME</a>
            <button type="button" class="btn btn-menu mt-3">VENTAS</button>
            <button type="button" class="btn btn-menu mt-3">REPORTES</button>
        </div>
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="col text-start">
            <h1 class="titulo-clientes">Gestión de Clientes</h1>
        </div>
    </div>
    
<div class="container text-end">
    <button type="button" class="btn btn-nuevo-cliente mt-3" data-bs-toggle="modal" data-bs-target="#nuevoClienteModal">Nuevo Cliente</button>
</div>



<!-- MODAL PARA AGREGAR CLIENTE  -->

   <!-- MODAL PARA AGREGAR CLIENTE  -->
<div class="modal fade" id="nuevoClienteModal" tabindex="-1" aria-labelledby="nuevoClienteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="nuevoClienteModalLabel">NUEVO CLIENTE</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="controladorCliente?menu=Cliente&accion=Agregar" method="post">
                    <input type="hidden" name="action" value="agregar"> <!-- accion para el void -->
                    <input type="hidden" name="codigoClie"> <!-- Si necesitas el código del empleado -->

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
                    
                    <button type="submit" class="btn btn-warning">Agregar</button>
                </form>
            </div>
        </div>
    </div>
</div>
       <!-- Modal para la tabla  -->
<div class="table-container">       
    <table id="tablaClientes" class="table table-striped-columns" style="width:100%">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Email</th>
                <th>Número</th>
                <th>Tipo.Doc</th>
                <th>Nro.Doc</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <% 
        List<Cliente> listado = (List<Cliente>) request.getAttribute("listado"); 
        if (listado != null && !listado.isEmpty()) { 
            for (Cliente lis : listado) { 
        %>
            <tr onclick="mostrarDetallesCliente(
            <%= lis.getCodigoClie()%>, 
            '<%= lis.getNombreClie() %>', 
            '<%= lis.getApellidoClie() %>', 
            '<%= lis.getEmailClie() %>', 
            '<%= lis.getNumeroClie() %>', 
            '<%= lis.getTipoDocumento() %>', 
            '<%= lis.getDocumentoClie() %>', 
            '<%= lis.getProvinciaClie() %>', 
            '<%= lis.getDistritoClie() %>', 
            '<%= lis.getDireccionClie() %>' 
            )">
                <td><%= lis.getCodigoClie() %></td>
                <td><%= lis.getNombreClie() %></td>
                <td><%= lis.getApellidoClie() %></td>
                <td><%= lis.getEmailClie() %></td>
                <td><%= lis.getNumeroClie() %></td>
                <td><%= lis.getTipoDocumento() %></td>
                <td><%= lis.getDocumentoClie() %></td>
                
                <td>
                    <button type="button" class="btn btn-edit btn-sm" 
                        onclick="editarCliente(
                            <%= lis.getCodigoClie() %>, 
                            '<%= lis.getDocumentoClie() %>', 
                            '<%= lis.getNombreClie() %>', 
                            '<%= lis.getApellidoClie() %>', 
                            '<%= lis.getNumeroClie() %>', 
                            '<%= lis.getEmailClie() %>', 
                            '<%= lis.getTipoDocumento() %>', 
                            '<%= lis.getDocumentoClie() %>',
                            '<%= lis.getProvinciaClie() %>', 
                            '<%= lis.getDistritoClie() %>', 
                            '<%= lis.getDireccionClie() %>',
                            event  // Pasa el objeto del evento
                        ); event.stopPropagation();">Editar</button>
                    <button type="button" class="btn btn-delete btn-sm" onclick="eliminarCliente(<%= lis.getCodigoClie() %>)">Eliminar</button>
                </td>
            </tr>
        <% 
            } 
        } else { 
        %>
            <tr>
                <td colspan="8">No se encontraron clientes.</td> <!-- Ajusta el colspan al número de columnas -->
            </tr>
        <% 
        } 
        %>
        </tbody>
    </table>
</div>


<!-- Modal -->
<div class="modal fade" id="detalleClienteModal" tabindex="-1" role="dialog" aria-labelledby="detalleClienteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detalleClienteModalLabel">Detalles del Empleado</h5>
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
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#detalleClienteModal').modal('hide');">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal para editar empleado -->
<div class="modal fade" id="editarClienteModal" tabindex="-1" aria-labelledby="editarClienteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Encabezado del modal -->
            <div class="modal-header">
                <h5 class="modal-title" id="editarClienteModalLabel">Editar Empleado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <!-- Formulario para editar empleado -->
                <form action="controladorCliente?menu=Cliente&accion=Actualizar" method="post">
                    <input type="hidden" name="action" value="actualizar"> <!-- acción para el void -->
                    <input type="hidden" id="id_cliente_editar" name="codigoClie"> <!-- Campo oculto para el ID del empleado -->

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

   <script src="js/Cliente.js"></script>

</body>
</html>