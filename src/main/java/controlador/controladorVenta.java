package controlador;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daoImp.clienteDao;
import daoImp.productoDao;
import daoImp.ventaDao;
import model.Cliente;
import model.EmpleadoDTO;
import model.Producto;
import model.Venta;

/**
 * Servlet implementation class controladorVenta
 */
public class controladorVenta extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	
	private ventaDao ventadao=new ventaDao();
	private   clienteDao clientedao = new clienteDao();
	private productoDao productodao=new productoDao();
	
	
    public controladorVenta() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codigoVents=request.getParameter("codigoVen");
		
		List<Venta>listado=ventadao.listarVentas();
		request.setAttribute("listado", listado);
		
	    request.getRequestDispatcher("Ventas.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String action = request.getParameter("action");

	    try {
	        switch (action) {
	            case "agregar":
	                agregarVenta(request, response);
	                break;
	            case "buscarProducto":
	                buscarProductoPorID(request, response);
	                break;
	            case "buscarCliente":
	                buscarClienteporDocumento(request, response);
	                break;
	            case "actualizar":
	                modificarVenta(request, response);
	                break;
	            case "listar": // Nuevo caso para listar ventas
	                listarVentas(request, response);
	                break;
	            default:
	                throw new IllegalArgumentException("Acci�n no reconocida: " + action);
	        }
	    } catch (RuntimeException e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Error: " + e.getMessage());
	        request.getRequestDispatcher("Ventas.jsp").forward(request, response);
	    }
	}

	// Nuevo m�todo para listar ventas
	private void listarVentas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    List<Venta> listaVentas = ventaDao.listarVentas();// Cambia esto por tu m�todo real

	    // Agregar la lista de ventas al request
	    request.setAttribute("ventas", listaVentas);

	    // Redirigir a la vista
	    request.getRequestDispatcher("Ventas.jsp").forward(request, response);
	}

	


	

	


	private void agregarVenta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        // Obtener el objeto EmpleadoDTO de la sesi�n
	        HttpSession session = request.getSession();
	        EmpleadoDTO empleado = (EmpleadoDTO) session.getAttribute("empleadoDTO");

	        if (empleado == null) {
	            throw new RuntimeException("No hay empleado en sesi�n.");
	        }

	        // Obtener los par�metros del request
	        String documento = request.getParameter("txtdocumento");
	        String tipoDocumento = request.getParameter("txttipodocumento");
	        int codigoClie = Integer.parseInt(request.getParameter("txtcodigoclie"));
	        String nombreClie = request.getParameter("txtnombreclie");
	        String apellidoClie = request.getParameter("txtapellidocliente");
	        String nombreEmpleado = empleado.getNombre() + " " + empleado.getApellido();

	        int codigoProd = Integer.parseInt(request.getParameter("txtcodigoProd"));
	        String prendaProd = request.getParameter("txtprenda");
	        String nombreProd = request.getParameter("txtnombreprod");
	        String categoriaProd = request.getParameter("txtcategoria");
	        String tallaProd = request.getParameter("txttalla");
	        int cantidad = Integer.parseInt(request.getParameter("txtcantidad"));
	        BigDecimal descuento = new BigDecimal(request.getParameter("txtdescuento"));
	        BigDecimal precioProd = new BigDecimal(request.getParameter("txtprecioProd"));

	        // Crear el objeto Venta
	        Venta venta = new Venta();
	        Cliente cliente = new Cliente();
	        cliente.setCodigoClie(codigoClie);
	        venta.setCliente(cliente);

	        Producto producto = new Producto();
	        producto.setCodigoProd(codigoProd);
	        venta.setProducto(producto);

	        // Asignar valores al objeto venta
	        venta.setDocumento(documento);
	        venta.setTipoDocumento(tipoDocumento);
	        venta.setNombreClie(nombreClie);
	        venta.setApellidoClie(apellidoClie);
	        venta.setNombreEmpleado(nombreEmpleado);
	        venta.setPrendaProd(prendaProd);
	        venta.setNombreProd(nombreProd); // Se a�adi� el nombre del producto
	        venta.setCategoriaProd(categoriaProd);
	        venta.setTallaProd(tallaProd);
	        venta.setCantidad(cantidad);
	        venta.setDescuento(descuento);
	        venta.setPrecioProd(precioProd);
	        // El total se calcula en el procedimiento almacenado, as� que no es necesario calcularlo aqu�
	        // venta.setTotal(precioProd.multiply(new BigDecimal(cantidad))); // Comentado

	        // Usar el DAO para insertar la venta
	        ventaDao ventaDao = new ventaDao(); // Corrige la instancia
	        ventaDao.insertarVenta(venta);

	        // Redirigir despu�s de la inserci�n
	        response.sendRedirect(request.getContextPath() + "/controladorVenta");

	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Error al convertir un n�mero: " + e.getMessage());
	        request.getRequestDispatcher("Ventas.jsp").forward(request, response);
	    } catch (RuntimeException e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Error al insertar la venta: " + e.getMessage());
	        request.getRequestDispatcher("Ventas.jsp").forward(request, response);
	    }
	}

	

	
	protected void buscarProductoPorID(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String codigoProdStr = request.getParameter("txtcodigoProd"); // Aseg�rate de que este es el nombre correcto del par�metro
	    Integer codigoProd = null;

	    // Validar la conversi�n de String a Integer
	    try {
	        codigoProd = Integer.valueOf(codigoProdStr);
	    } catch (NumberFormatException e) {
	        request.setAttribute("mensaje", "El c�digo del producto debe ser un n�mero v�lido.");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("Ventas.jsp");
	        dispatcher.forward(request, response);
	        return; 
	    }

	    Optional<Producto> productoOpt = productodao.buscarProductoporID(codigoProd);

	    if (productoOpt.isPresent()) {
	        Producto producto = productoOpt.get();
	        
	        // Establecer los atributos en el request
	        request.setAttribute("txtprenda", producto.getPrendaProd());
	        request.setAttribute("txtnombreprod", producto.getNombreProd());
	        request.setAttribute("txtcategoria", producto.getCategoriaProd());
	        request.setAttribute("txttalla", producto.getTallaProd());
	        request.setAttribute("txtdescuento", producto.getDescuento());
	        request.setAttribute("txtprecioProd", producto.getPrecioFinal());
	        request.setAttribute("txtcodigoProd", codigoProd); 
	        
	        String documentoClie = request.getParameter("txtdocumento"); 
	        if (documentoClie != null) {
	            Optional<Cliente> clienteOpt = clientedao.buscarClientePorDocumento(documentoClie);
	            if (clienteOpt.isPresent()) {
	                Cliente cliente = clienteOpt.get();
	                request.setAttribute("txtnombreclie", cliente.getNombreClie());
	                request.setAttribute("txtapellidocliente", cliente.getApellidoClie());
	                request.setAttribute("txttipodocumento", cliente.getTipoDocumento());
	                request.setAttribute("txtcodigoclie", cliente.getCodigoClie());
	                request.setAttribute("txtdocumento", documentoClie);
	            }
	        }

	        RequestDispatcher dispatcher = request.getRequestDispatcher("Ventas.jsp");
	        dispatcher.forward(request, response);
	        request.setAttribute("txtcodigoProd", request.getParameter("txtcodigoProd"));
	        
	        request.getSession().setAttribute("producto", producto); // Guardar el producto en sesi�n

	    } else {
	        request.setAttribute("mensaje", "No se encontr� el producto con el c�digo: " + codigoProd);
	        RequestDispatcher dispatcher = request.getRequestDispatcher("Ventas.jsp");
	        dispatcher.forward(request, response);
	    }
	}




	private void buscarClienteporDocumento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String documentoClie = request.getParameter("txtdocumento"); // Aseg�rate que el nombre coincide con el del formulario

	    if (documentoClie == null || documentoClie.trim().isEmpty()) {
	        request.setAttribute("errorMessage", "El documento del cliente no puede estar vac�o.");
	        request.getRequestDispatcher("Ventas.jsp").forward(request, response);
	        return;
	    }

	    try {
	        Optional<Cliente> clienteOpt = clientedao.buscarClientePorDocumento(documentoClie);

	        if (clienteOpt.isPresent()) {
	            Cliente cliente = clienteOpt.get();
	            request.setAttribute("txtnombreclie", cliente.getNombreClie()); // Nombre del cliente
	            request.setAttribute("txtapellidocliente", cliente.getApellidoClie()); // Apellido del cliente
	            request.setAttribute("txttipodocumento", cliente.getTipoDocumento()); // Tipo de documento
	            request.setAttribute("txtcodigoclie", cliente.getCodigoClie()); // ID Cliente
	            request.setAttribute("txtcodigoclie", cliente.getCodigoClie()); // ID Cliente
	            request.setAttribute("txtdocumento", documentoClie);

	            String codigoProdStr = request.getParameter("txtcodigoProd"); // Obtener el c�digo del producto
	            if (codigoProdStr != null && !codigoProdStr.trim().isEmpty()) {
	                Integer codigoProd = Integer.valueOf(codigoProdStr);
	                Optional<Producto> productoOpt = productodao.buscarProductoporID(codigoProd);
	                
	                if (productoOpt.isPresent()) {
	                    Producto producto = productoOpt.get();
	                    request.setAttribute("txtprenda", producto.getPrendaProd());
	                    request.setAttribute("txtnombreprod", producto.getNombreProd());
	                    request.setAttribute("txtcategoria", producto.getCategoriaProd()); 
	                    request.setAttribute("txttalla", producto.getTallaProd());
	                    request.setAttribute("txtdescuento", producto.getDescuento());
	                    request.setAttribute("txtprecioProd", producto.getPrecioFinal());
	                    request.setAttribute("txtcodigoProd", codigoProd); // Cambiar a Integer aqu�
	                }
	            }
	            request.getSession().setAttribute("cliente", cliente); // Guardar el cliente en sesi�n

	            request.getRequestDispatcher("Ventas.jsp").forward(request, response);
	        } else {
	            request.setAttribute("errorMessage", "No se encontr� el cliente con el documento: " + documentoClie);
	            request.getRequestDispatcher("Ventas.jsp").forward(request, response);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Error al buscar el cliente: " + e.getMessage());
	        request.getRequestDispatcher("Ventas.jsp").forward(request, response);
	    }
	}

	
	

	
	
	
	
	
	private void modificarVenta(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}


}
