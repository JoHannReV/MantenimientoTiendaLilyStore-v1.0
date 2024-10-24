<%@page import="model.Producto"%>
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
    background-image: url('https://img.freepik.com/free-vector/white-minimal-background_1393-354.jpg?t=st=1729575678~exp=1729579278~hmac=bb66d02906cf929c297b2b185a7552905a27d667e8505458c6530f6c9f845ec8&w=1480'); /* Fondo con la imagen */
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

.titulo-Producto {
    margin-top: 20px; 
    font-size: 3rem;
    font-weight: bold; 
    font-family: 'Arial', sans-serif; 
}


.btn-nuevo-Producto {
    background-color: rgba(34, 139, 34, 0.85); 
    color: white;
    border: none;
    padding: 9px 30px;
    font-size: 1rem;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn-nuevo-Producto:hover {
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

<title>Gestion Productos</title>
   
</head>
<body>

 <div class="container">
    <div class="row">
        <div class="col text-start">
            <a href="Menu.jsp" class="btn btn-menu mt-3">HOME</a>
            <button type="button" class="btn btn-menu mt-3">CLIENTES</button>
            <button type="button" class="btn btn-menu mt-3">VENTAS</button>
            <button type="button" class="btn btn-menu mt-3">FACTURAS</button>
        </div>
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="col text-start">
            <h1 class="titulo-Producto">Gestión de Productos</h1>
        </div>
    </div>
    
<div class="container text-end">
    <button type="button" class="btn btn-nuevo-Producto mt-3" data-bs-toggle="modal" data-bs-target="#nuevoProductoModal">Nuevo Producto</button>
</div>



<!-- MODAL PARA AGREGAR PRODUCTO  -->

   <!-- MODAL PARA AGREGAR PRODUCTO  -->
<div class="modal fade" id="nuevoProductoModal" tabindex="-1" aria-labelledby="nuevoProductoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="nuevoProductoModalLabel">NUEVO PRODUCTO</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="controladorProducto?menu=Producto&accion=Agregar" method="post">
                    <input type="hidden" name="action" value="agregar"> <!-- accion para el void -->
                    <input type="hidden" name="codigoProd"> <!-- Si necesitas el código del producto SI LEES ESTO, LO HICE SOLO XD, SOY LO MAXIMO CSM-->
                   
                    <div class="mb-3">
                        <label for="txtMarcaID" class="form-label">MARCA</label>
                        <select class="form-select" id="txtMarcaID" name="txtMarcaID" required>
                            <option value="1">Supreme</option>
                            <option value="2">Off-White</option>
                            <option value="3">Stüssy</option>
                            <option value="4">A Bathing Ape (BAPE)</option>
                            <option value="5">Palace</option>
                            <option value="6">Kith</option>
                            <option value="7">Fear of God</option>
                            <option value="8">Anti Social Social Club</option>
                        </select>
                    </div>
                   
                    <div class="mb-3">
                        <label for="txtPrenda" class="form-label">PRENDA</label>
                        <select class="form-select" id="txtPrenda" name="txtPrenda" required>  
                           <option value="Polo">POLO</option>
                            <option value="Buzo">BUZO</option>
                            <option value="Pantalon">PANTALON</option>
                            <option value="Gorra">GORRA</option>
                            <option value="Camisa">CAMISA</option>
                            <option value="Sudadera">SUDADERA</option>
                            <option value="Casaca">CASACA</option>
                            <option value="Camiseta">CAMISETA</option>
                        </select>
                    </div>            
                     <div class="mb-3">
                        <label for="txtNombres" class="form-label">NOMBRE</label>
                        <input type="text" class="form-control" id="txtNombres" name="txtNombres" required>
                    </div>
                   
                     <div class="mb-3">
                        <label for="txtCategoria" class="form-label">CATEGORIA</label>
                        <select class="form-select" id="txtCategoria" name="txtCategoria" required>  
                           <option value="Mujer">MUJER</option>
                            <option value="Hombre">HOMBRE</option>
                            <option value="Nino">NIÑO</option>
                        </select>
                    </div>  
                                      
                    <div class="mb-3">
                        <label for="txtDescripcion" class="form-label">DESCRIPCION</label>
                        <input type="text" class="form-control" id="txtDescripcion" name="txtDescripcion" required>
                    </div>
                    
   
                    <div class="mb-3">
                        <label for="txtTalla" class="form-label">TALLA</label>
                        <select class="form-select" id="txtTalla" name="txtTalla" required>
                            <option value="s">S</option>
                            <option value="m">M</option>
                            <option value="l">L</option>
                            <option value="xl">XL</option>
                            <option value="xxl">XXL</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtLote" class="form-label">NRO.LOTE</label>
                        <input type="text" class="form-control" id="txtLote" name="txtLote" required>
                    </div>
                     
                      <div class="mb-3">
                        <label for="txtPrecio" class="form-label">PRECIO BRUTO</label>
                        <input type="number" step="0.01" class="form-control" id="txtPrecio" name="txtPrecio" required>
                    </div>
                      <div class="mb-3">
                        <label for="txtStock" class="form-label">STOCK</label>
                        <input type="number" step="0.01" class="form-control" id="txtStock" name="txtStock" required>
                    </div>
                    
                    
                    <button type="submit" class="btn btn-warning">Agregar</button>
                </form>
            </div>
        </div>
    </div>
</div>

       <!-- Modal para la tabla  -->
<div class="table-container">       
    <table id="tablaProductos" class="table table-striped-columns" style="width:100%">
        <thead>
            <tr>
                <th>ID</th>
                <th>MARCA</th>
                <th>PRENDA</th>
                <th>NOMBRE</th>
                <th>CATEGORIA</th>
                <th>DESCRIPCION</th>
                <th>TALLA</th>
                <th>PRECIO VENTA</th>
                <th>Acciones</th>
            </tr>
        </thead>
   <tbody>
<% 
List<Producto> listado = (List<Producto>) request.getAttribute("listado"); 
if (listado != null && !listado.isEmpty()) { 
    for (Producto lis : listado) { 
%>
    <tr onclick="mostrarDetallesProducto(
        <%= lis.getCodigoProd()%>, 
        '<%= lis.getProveedore()!= null? lis.getProveedore().getNombreProve():""%>', 
        '<%= lis.getPrendaProd() %>', 
        '<%= lis.getNombreProd() %>', 
        '<%= lis.getCategoriaProd() %>', 
        '<%= lis.getDescripcionProd() %>', 
        '<%= lis.getTallaProd() %>', 
        '<%= lis.getNumeroLoteProd() %>', 
        '<%= lis.getPrecioIngresoProd() %>', 
        '<%= lis.getGananciaProd() %>',
        '<%= lis.getDescuento() %>',
        '<%= lis.getPrecioFinal() %>',
        '<%= lis.getStock() %>',
        '<%= lis.getFechaIngreso() %>',
        '<%= lis.getFechaModificacion() %>'
    )">
        <td><%= lis.getCodigoProd() %></td>
        <td><%= lis.getProveedore() != null ? lis.getProveedore().getNombreProve() : "" %></td>
        <td><%= lis.getPrendaProd() %></td>
        <td><%= lis.getNombreProd() %></td>
        <td><%= lis.getCategoriaProd() %></td>
        <td><%= lis.getDescripcionProd() %></td>
        <td><%= lis.getTallaProd() %></td>
        <td><%= lis.getPrecioFinal() %></td>
        
        <td>
            <button type="button" class="btn btn-edit btn-sm" 
                onclick="editarProducto(
                    <%= lis.getCodigoProd() %>, 
                    '<%= lis.getProveedore()!= null ? lis.getProveedore().getNombreProve() : "" %>', 
                    '<%= lis.getPrendaProd() %>',  
                    '<%= lis.getNombreProd() %>', 
                    '<%= lis.getCategoriaProd() %>', 
                    '<%= lis.getDescripcionProd() %>', 
                    '<%= lis.getTallaProd() %>', 
                    '<%= lis.getNumeroLoteProd() %>', 
                    '<%= lis.getPrecioIngresoProd() %>',
                    '<%= lis.getDescuento() %>', 
                    '<%= lis.getStock() %>' 
                ); event.stopPropagation();">Editar</button>
            
            <form action="controladorProducto" method="post" onsubmit="return confirm('¿Estás seguro de que deseas eliminar este producto?');" style="display:inline;">
                <input type="hidden" name="txtCodigoProducto" value="<%= lis.getCodigoProd() %>">
                <input type="hidden" name="action" value="eliminar">
                <button type="submit" class="btn btn-delete btn-sm">Eliminar</button>
            </form>
        </td>
    </tr>
<% 
    } 
} else { 
%>
    <tr>
        <td colspan="9">No se encontraron PRODUCTOS.</td> 
    </tr>
<% 
} 
%>
</tbody>

    </table>
</div>


<!-- Modal -->
<div class="modal fade" id="detalleProductoModal" tabindex="-1" role="dialog" aria-labelledby="detalleProductoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detalleProductoModalLabel">Detalles del Empleado</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>ID : <span id="detalleId"></span></p>
                <p>MARCA : <span id="detalleMarca"></span></p>
                <p>PRENDA : <span id="detallePrenda"></span></p>
                <p>NOMBRE : <span id="detalleNombre"></span></p>
                <p>CATEGORIA : <span id="detalleCategoria"></span></p>
                <p>DESCRIPCION : <span id="detalleDescripcion"></span></p>
                <p>TALLA : <span id="detalleTalla"></span></p>
                <p>NRO. LOTE : <span id="detalleLote"></span></p>
                <p>PRECIO INGRESO: <span id="detallePrecioIngreso"></span></p>
                <p>GANANCIA: <span id="detalleGanancia"></span></p>
                <p>DESCUENTO: <span id="detalleDescuento"></span></p>
                <p>PRECIO VENTA : <span id="detallePrecio"></span></p>
                <p>STOCK : <span id="detalleStock"></span></p>
                <p>FECHA INGRESO : <span id="detalleIngreso"></span></p>
                <p>PRECIO MODIFICACION : <span id="detalleModificacion"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#detalleProductoModal').modal('hide');">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal para editar Producto -->
<div class="modal fade" id="editarProductoModal" tabindex="-1" aria-labelledby="editarProductoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Encabezado del modal -->
            <div class="modal-header">
                <h5 class="modal-title" id="editarProductoModalLabel">EDITAR PRODUCTO</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <!-- Formulario para editar PRODUCTO -->
                <form action="controladorProducto?menu=Producto&accion=Actualizar" method="post">
                    <input type="hidden" name="action" value="actualizar"> <!-- acción para el void -->
                    <input type="hidden" id="id_producto_editar" name="codigoProd"> <!-- Campo oculto para el ID del empleado -->

                   
                    <div class="mb-3">
                        <label for="txtMarcaID" class="form-label">MARCA</label>
                        <select class="form-select" id="marcaID_editar" name="txtMarcaID" required>
                            <option value="1">Supreme</option>
                            <option value="2">Off-White</option>
                            <option value="3">Stüssy</option>
                            <option value="4">A Bathing Ape (BAPE)</option>
                            <option value="5">Palace</option>
                            <option value="6">Kith</option>
                            <option value="7">Fear of God</option>
                            <option value="8">Anti Social Social Club</option>
                        </select>
                    </div>
                   
                    <div class="mb-3">
                        <label for="txtPrenda" class="form-label">PRENDA</label>
                        <select class="form-select" id="prenda_editar" name="txtPrenda" required>  
                           <option >POLO</option>
                            <option >BUZO</option>
                            <option >PANTALON</option>
                            <option >GORRA</option>
                            <option >CAMISA</option>
                            <option >SUDADERA</option>
                            <option >CASACA</option>
                            <option >CAMISETA</option>
                        </select>
                    </div>            
                     <div class="mb-3">
                        <label for="txtNombres" class="form-label">NOMBRE</label>
                        <input type="text" class="form-control" id="nombres_editar" name="txtNombres" required>
                    </div>
                   
                     <div class="mb-3">
                        <label for="txtCategoria" class="form-label">CATEGORIA</label>
                        <select class="form-select" id="categoria_editar" name="txtCategoria" required>  
                           <option >MUJER</option>
                            <option >HOMBRE</option>
                            <option >NIÑO</option>
                        </select>
                    </div>  
                                      
                    <div class="mb-3">
                        <label for="txtDescripcion" class="form-label">DESCRIPCION</label>
                        <input type="text" class="form-control" id="descripcion_editar" name="txtDescripcion" required>
                    </div>
                    
   
                    <div class="mb-3">
                        <label for="txtTalla" class="form-label">TALLA</label>
                        <select class="form-select" id="talla_editar" name="txtTalla" required>
                            <option >S</option>
                            <option >M</option>
                            <option >L</option>
                            <option >XL</option>
                            <option >XXL</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtLote" class="form-label">NRO.LOTE</label>
                        <input type="text" class="form-control" id="lote_editar" name="txtLote" required>
                    </div>
                     
                      <div class="mb-3">
                        <label for="txtPrecio" class="form-label">PRECIO BRUTO</label>
                        <input type="number" step="0.01" class="form-control" id="precio_editar" name="txtPrecio" required>
                    </div>
                     <div class="mb-3">
                        <label for="txtDescuento" class="form-label">DESCUENTO%</label>
                        <input type="number" step="0.01" class="form-control" id="descuento_editar" name="txtDescuento" required>
                    </div>
                      <div class="mb-3">
                        <label for="txtStock" class="form-label">STOCK</label>
                        <input type="number" step="0.01" class="form-control" id="stock_editar" name="txtStock" required>
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

   <script src="js/Producto.js"></script>

</body>
</html>