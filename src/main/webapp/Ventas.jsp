<%@page import="java.util.List"%>
<%@page import="model.Venta"%>
<%@page import="model.EmpleadoDTO"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Gestión de Ventas</title>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .btn-menu {
            margin-right: 10px;
        }
        h1, h3 {
            color: #343a40;
        }
        .table-container {
            margin-top: 20px;
        }
        .modal-header {
            background-color: #007bff;
            color: white;
        }
        .form-control {
            height: 38px; /* Altura del campo */
            font-size: 14px; /* Tamaño de texto */
        }
        .form-row {
            align-items: center; /* Alinear verticalmente los elementos */
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col text-start">
            <a href="Menu.jsp" class="btn btn-primary mt-3">HOME</a>
            <a href="controladorCliente?menu=Cliente&accion=Listar" class="btn btn-primary mt-3">CLIENTES</a>
        </div>
    </div>

    <div class="row">
        <div class="col text-center">
            <h1>GESTIONAR VENTA</h1>
        </div>
    </div>
</div>

<div class="container mt-4">
    <div class="row">
        <div class="col">
            <h3>Cliente</h3>
        </div>
    </div>


    <form action="controladorVenta" method="post">
        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="txtcodigoProd">Código del Producto:</label>
                <input type="text" class="form-control" id="txtcodigoProd" name="txtcodigoProd" 
                       value="<%= request.getAttribute("txtcodigoProd") != null ? request.getAttribute("txtcodigoProd") : "" %>" 
                       required />
            </div>
            <button type="submit" class="btn btn-success mt-4" name="action" value="buscarProducto">Buscar Producto</button>
        </div>

        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="txtprenda">Prenda del Producto:</label>
                <input type="text" class="form-control" id="txtprenda" name="txtprenda" 
                       value="<%= request.getAttribute("txtprenda") != null ? request.getAttribute("txtprenda") : "" %>" 
                       readonly />
            </div>
            <div class="form-group col-md-4">
                <label for="txtnombreprod">Nombre del Producto:</label>
                <input type="text" class="form-control" id="txtnombreprod" name="txtnombreprod" 
                       value="<%= request.getAttribute("txtnombreprod") != null ? request.getAttribute("txtnombreprod") : "" %>" 
                       readonly />
            </div>
            <div class="form-group col-md-4">
                <label for="txtcategoria">Categoría del Producto:</label>
                <input type="text" class="form-control" id="txtcategoria" name="txtcategoria" 
                       value="<%= request.getAttribute("txtcategoria") != null ? request.getAttribute("txtcategoria") : "" %>" 
                       readonly />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="txttalla">Talla del Producto:</label>
                <input type="text" class="form-control" id="txttalla" name="txttalla" 
                       value="<%= request.getAttribute("txttalla") != null ? request.getAttribute("txttalla") : "" %>" 
                       readonly />
            </div>
            <div class="form-group col-md-4">
                <label for="txtdescuento">Descuento del Producto:</label>
                <input type="text" class="form-control" id="txtdescuento" name="txtdescuento" 
                       value="<%= request.getAttribute("txtdescuento") != null ? request.getAttribute("txtdescuento") : "" %>" 
                       readonly />
            </div>
            <div class="form-group col-md-4">
                <label for="txtprecioProd">Precio del Producto:</label>
                <input type="text" class="form-control" id="txtprecioProd" name="txtprecioProd" 
                       value="<%= request.getAttribute("txtprecioProd") != null ? request.getAttribute("txtprecioProd") : "" %>" 
                       readonly />
            </div>
            
              <div class="form-group col-md-4">
                <label for="txtcantidad">Cantidad:</label>
                <input type="number" class="form-control" id="txtcantidad" name="txtcantidad" 
                       value="<%= request.getAttribute("txtcantidad") != null ? request.getAttribute("txtcantidad") : "" %>" 
                       />
            </div>
      
        </div>
        
        

        <p style="color:red;"><%= request.getAttribute("mensaje") != null ? request.getAttribute("mensaje") : "" %></p>

        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="txtdocumento">Documento del Cliente:</label>
                <input type="text" class="form-control" id="txtdocumento" name="txtdocumento" 
                       value="<%= request.getAttribute("txtdocumento") != null ? request.getAttribute("txtdocumento") : "" %>" 
                       required />
            </div>
            <button type="submit" class="btn btn-success mt-4" name="action" value="buscarCliente">Buscar Cliente</button>
        </div>

        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="txtnombreclie">Nombre del Cliente:</label>
                <input type="text" class="form-control" id="txtnombreclie" name="txtnombreclie" 
                       value="<%= request.getAttribute("txtnombreclie") != null ? request.getAttribute("txtnombreclie") : "" %>" 
                       readonly />
            </div>
            <div class="form-group col-md-4">
                <label for="txtapellidocliente">Apellido del Cliente:</label>
                <input type="text" class="form-control" id="txtapellidocliente" name="txtapellidocliente" 
                       value="<%= request.getAttribute("txtapellidocliente") != null ? request.getAttribute("txtapellidocliente") : "" %>" 
                       readonly />
            </div>
            <div class="form-group col-md-4">
                <label for="txttipodocumento">Tipo documento:</label>
                <input type="text" class="form-control" id="txttipodocumento" name="txttipodocumento" 
                       value="<%= request.getAttribute("txttipodocumento") != null ? request.getAttribute("txttipodocumento") : "" %>" 
                       readonly />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="txtcodigoclie">Código:</label>
                <input type="text" class="form-control" id="txtcodigoclie" name="txtcodigoclie" 
                       value="<%= request.getAttribute("txtcodigoclie") != null ? request.getAttribute("txtcodigoclie") : "" %>" 
                       readonly />
            </div>
        </div>
        
        
        <!-- Botón para agregar la venta -->
    <div class="form-row">
        <div class="col text-center">
            <button type="submit" class="btn btn-primary mt-4" name="action" value="agregar">Agregar Venta</button>
        
    </form>





    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <div class="table-container">
        <h3>Ventas Realizadas</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID Venta</th>
                    <th>ID Cliente</th>
                    <th>Nombre Cliente</th>
                    <th>Empleado</th>
                    <th>Nombre</th>
                    <th>Prenda</th>
                    <th>Talla</th>
                    <th>Cantidad</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <%            
    List<Venta> listado = (List<Venta>) request.getAttribute("listado");
    if (listado != null && !listado.isEmpty()) {
        for (Venta lis : listado) {
    %>        
                <tr onclick="mostrarDetallesVenta(
                    <%= lis.getIdVenta() %>, 
                    '<%= lis.getTipoDocumento() %>', 
                    '<%= lis.getDocumento() %>', 
                    '<%= lis.getCliente().getCodigoClie() %>', 
                    '<%= lis.getNombreClie() %>', 
                    '<%= lis.getApellidoClie() %>', 
                    '<%= lis.getProducto().getCodigoProd() %>', 
 '<%= lis.getPrendaProd() %>', 
                    '<%= lis.getNombreProd() %>', 
                    '<%= lis.getCategoriaProd() %>', 
                    '<%= lis.getTallaProd() %>', 
                    <%= lis.getCantidad() %>, 
                    <%= lis.getDescuento() %>, 
                    <%= lis.getTotal() %>, 
                    '<%= lis.getFechaVenta() %>', 
                    '<%= lis.getFechaModificacion() %>'
                )">
                    <td><%= lis.getIdVenta() %></td>
                    <td><%= lis.getNombreClie() %></td>
                    <td><%= lis.getApellidoClie() %></td>
                    <td><%= lis.getNombreEmpleado() %></td>
                    <td><%= lis.getNombreProd() %></td>
                    <td><%= lis.getPrendaProd() %></td>
                    <td><%= lis.getTallaProd() %></td>
                    <td><%= lis.getCantidad() %></td>
                    <td><%= lis.getTotal() %></td>
                </tr>
    <% 
        } 
    } else { 
    %>
                <tr>
                    <td colspan="9" class="text-center">No hay ventas registradas.</td>
                </tr>
    <% 
    } 
    %>
            </tbody>
        </table>
    </div>

    <!-- Modal para mostrar detalles -->
    <div class="modal fade" id="modalDetalles" tabindex="-1" role="dialog" aria-labelledby="modalDetallesLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalDetallesLabel">Detalles de la Venta</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>ID VENTA: <span id="detalleidventa"></span></p>
                    
                    <h6>DATOS DEL CLIENTE</h6>
                    
                    <p>TIPO DOCUMENTO: <span id="detalletipodocumento"></span></p>
                    <p>DOCUMENTO: <span id="detalledocumento"></span></p>
                    <p>ID CLIENTE: <span id="detalleIdCliente"></span></p>
                    <p>NOMBRE: <span id="detalleNombreCliente"></span></p>
                    <p>APELLIDO: <span id="detalleApellidoCliente"></span></p>
                    
                    <h6>**DATOS DEL PRODUCTO**</h6>
                    
                    <p>ID PRODUCTO: <span id="detalleIdProducto"></span></p>
                    <p>PRENDA: <span id="detallePrenda"></span></p>
                    <p>CATEGORIA: <span id="detalleCategoria"></span></p>
                    <p>TALLA: <span id="detalleTalla"></span></p>
                    <p>CANTIDAD: <span id="detalleCantidad"></span></p>
                    <p>DESCUENTO: <span id="detalleDescuento"></span></p>
                    <p>TOTAL: <span id="detalleTotal"></span></p>
                    <p>FECHA DE VENTA: <span id="detalleFechaVenta"></span></p>
                    <p>FECHA DE MODIFICACION: <span id="detalleModificacion"></span></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" 
                     onclick="$('#detalleProductoModal').modal('hide');">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Incluir jQuery y Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script src="js/Venta.js"></script>

</body>
</html>