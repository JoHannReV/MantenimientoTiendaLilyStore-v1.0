package controlador;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daoImp.empleadoDao;
import daoImp.productoDao;
import model.Producto;
import model.Proveedore;

/**
 * Servlet implementation class controladorProducto
 */
public class controladorProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private productoDao productoDao=new productoDao();
	
    public controladorProducto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	String codigoProdstr=request.getParameter("codigoProd");
	List<Producto>listado=productoDao.listarProducto();
    request.setAttribute("listado", listado);

	
    request.getRequestDispatcher("Producto.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//DANIEL DEVUELME MI PALTA ME DEBES 750 SOLES
		String action = request.getParameter("action");


		try{
			if("agregar".equals(action))
			{
				agregarProducto(request,response);
		    }
			else if("eliminar".equals(action))
			{
				eliminarProducto(request,response);
			}else if ("actualizar".equals(action)) { 
	            modificarProducto(request, response);
	            }
			else
			{
				throw new IllegalArgumentException("Accion no reconocida");
			}
		}
		 catch(RuntimeException e)
		{
			 e.printStackTrace();
			request.setAttribute("errorMessage","Error: "+e.getMessage());
			request.getRequestDispatcher("Empleado.jsp").forward(request, response);
		}
		
		
		
		
	}

	private void agregarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    try {
	        int marcaID = Integer.parseInt(request.getParameter("txtMarcaID"));
	        String prenda = request.getParameter("txtPrenda");
	        String nombre = request.getParameter("txtNombres");
	        String categoria = request.getParameter("txtCategoria");
	        String descripcion = request.getParameter("txtDescripcion");
	        String talla = request.getParameter("txtTalla");
	        String lote = request.getParameter("txtLote");
	        String precio = request.getParameter("txtPrecio");
	        int stock = Integer.parseInt(request.getParameter("txtStock"));

	        if (prenda == null || nombre == null || categoria == null || descripcion == null || precio == null) {
	            throw new IllegalArgumentException("Los campos no pueden estar vacíos.");
	        }

	        BigDecimal PrecioBruto;
	        try {
	            PrecioBruto = new BigDecimal(precio);
	        } catch (NumberFormatException e) {
	            throw new IllegalArgumentException("El precio bruto debe ser un número válido.");
	        }

	        // Crear el producto y proveedor
	        Producto producto = new Producto();
	        Proveedore proveedor = new Proveedore();
	        proveedor.setProveedorid(marcaID);
	        
	        // Asignar proveedor al producto
	        producto.setProveedore(proveedor);
	        
	        // Asignar valores al producto
	        producto.setPrendaProd(prenda);
	        producto.setNombreProd(nombre);
	        producto.setCategoriaPro(categoria);
	        producto.setDescripcionProd(descripcion);
	        producto.setTallaProd(talla);
	        producto.setNumeroLoteProd(lote);
	        producto.setPrecioIngresoProd(PrecioBruto);
	        producto.setStock(stock);

	        // Insertar producto usando DAO
	        productoDao.insertarProducto(producto);
	        response.sendRedirect(request.getContextPath() + "/controladorProducto");

	    } catch (RuntimeException e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Error al insertar producto: " + e.getMessage());
	        request.getRequestDispatcher("Producto.jsp").forward(request, response);
	    }
	}


	private void modificarProducto(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

		try 
		{ 
			int codigoProd= Integer.parseInt(request.getParameter("codigoProd"));
			int nuevoMarcaID = Integer.parseInt(request.getParameter("txtMarcaID"));
			String nuevoPrenda = request.getParameter("txtPrenda");
	        String nuevoNombre = request.getParameter("txtNombres");
	        String nuevoCategoria = request.getParameter("txtCategoria");
	        String nuevoDescripcion= request.getParameter("txtDescripcion");
	        String nuevoTalla= request.getParameter("txtTalla");
	        String nuevoLote= request.getParameter("txtLote");
	        BigDecimal nuevoPrecio= new BigDecimal(request.getParameter("txtPrecio"));
	        BigDecimal nuevoDescuento= new BigDecimal(request.getParameter("txtDescuento"));
	        int nuevoStock= Integer.parseInt(request.getParameter("txtStock"));

	        
	        
	        Producto productoAModificar = productoDao.obtenerporID(codigoProd);
	        
	        if(productoAModificar!=null){
	        	
	        	productoAModificar.setNombreProd(nuevoNombre);
	        
	        if (nuevoNombre != null && !nuevoNombre.trim().isEmpty()) {
	        	productoAModificar.setNombreProd(nuevoNombre);
            }else {
            	productoAModificar.setNombreProd(nuevoNombre);
            	}
	        
	        productoAModificar.setPrendaProd(nuevoPrenda);
        	productoAModificar.setNombreProd(nuevoNombre);
        	productoAModificar.setCategoriaPro(nuevoCategoria);
        	productoAModificar.setDescripcionProd(nuevoDescripcion);
        	productoAModificar.setTallaProd(nuevoTalla);
        	productoAModificar.setNumeroLoteProd(nuevoLote);
        	productoAModificar.setPrecioIngresoProd(nuevoPrecio);
        	productoAModificar.setDescuento(nuevoDescuento);
        	productoAModificar.setStock(nuevoStock);
        	
	        
	        Proveedore nuevoprove=productoDao.obtenerProveedorPorID(nuevoMarcaID);
	        if (nuevoprove != null) {
                productoAModificar.setProveedore(nuevoprove);
            } else {
                System.out.println("Proveedor no encontrado.");
            }
	        
	        productoDao.modificarProducto(productoAModificar);
           
	        request.setAttribute("successMessage", "Producto actualizado correctamente.");
            response.sendRedirect(request.getContextPath() + "/controladorProducto");

	        } else {
	        	 request.setAttribute("errorMessage", "Empleado no encontrado.");
		            request.getRequestDispatcher("error.jsp").forward(request, response);
			}
		        
	        
		}  catch (NumberFormatException e) {
	        request.setAttribute("errorMessage", "Formato inválido en los campos numéricos.");
	        request.getRequestDispatcher("error.jsp").forward(request, response);
		}catch (Exception e) {
	        request.setAttribute("errorMessage", "Error al actualizar el Producto: " + e.getMessage());
	        request.getRequestDispatcher("error.jsp").forward(request, response);}
		
		
		
	}

	private void eliminarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// TODO Auto-generated method stub
		
	}

	
	
	
	
	
	
	
	
}//final del controlador

