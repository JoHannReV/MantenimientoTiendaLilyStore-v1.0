package controlador;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daoImp.clienteDao;
import model.Cliente;

/**
 * Servlet implementation class controladorCliente
 */
public class controladorCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   private clienteDao clienteDao = new clienteDao();
	
    public controladorCliente() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String codigoClie= request.getParameter("codigoClie");
		
		List<Cliente> listado=clienteDao.listarCliente();
		request.setAttribute("listado", listado);
		
		request.getRequestDispatcher("Cliente.jsp").forward(request,response);
	
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String action = request.getParameter("action");
		
		try 
		{
			if("agregar".equals(action)){insertarCliente(request,response);}
			else if ("eliminar".equals(action)){eliminarCliente(request,response);}
			else if("actualizar".equals(action)){modificarCliente(request,response);}
			else {throw new IllegalArgumentException("Accion no reconocida");}
		} catch (Exception e) {
			 e.printStackTrace();
				request.setAttribute("errorMessage","Error: "+e.getMessage());
				request.getRequestDispatcher("Cliente.jsp").forward(request, response);

		}
		
		}

	private void insertarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		try {
			// Recuperar los datos del formulario
	        String nombre = request.getParameter("txtNombres");
	        String apellido = request.getParameter("txtApellidos");
	        String email = request.getParameter("txtCorreo");
	        String telefono = request.getParameter("txtTelefono");
	        String tipoDocumento = request.getParameter("txtTipoDocumento");
	        String documento = request.getParameter("txtDocumento");
	        String provincia = request.getParameter("txtProvincia");
	        String distrito = request.getParameter("txtDistrito");
	        String direccion = request.getParameter("txtDireccion");
			
	        
	        System.out.println("Nombre: " + nombre);
	        System.out.println("Apellido: " + apellido);
	        System.out.println("Email: " + email);
	        System.out.println("Teléfono: " + telefono);
	        System.out.println("Tipo Documento: " + tipoDocumento);
	        System.out.println("Documento: " + documento);
	        System.out.println("Provincia: " + provincia);
	        System.out.println("Distrito: " + distrito);
	        System.out.println("Dirección: " + direccion);
	        
	        if (nombre == null || apellido == null || email == null || documento == null) {
	            throw new IllegalArgumentException("Los campos no pueden estar vacíos.");
	        }

	        
	        //crear el cliente 
	       Cliente cliente =new Cliente();
	       cliente.setNombreClie(nombre);
	       cliente.setApellidoClie(apellido);
	       cliente.setEmailClie(email);
	       cliente.setNumeroClie(telefono);
	       cliente.setTipoDocumento(tipoDocumento);
	       cliente.setDocumentoClie(documento);
	       cliente.setProvinciaClie(provincia);
	       cliente.setDistritoClie(distrito);
	       cliente.setDireccionClie(direccion);
	       
	       clienteDao.insertarCliente(cliente);
	      
	       response.sendRedirect(request.getContextPath() + "/controladorCliente");

	        
	        
		} 
		
		catch (RuntimeException e) {
		    e.printStackTrace();
		    System.out.println("Error durante la inserción del cliente: " + e.getMessage());
		    request.setAttribute("errorMessage", "Error al insertar cliente: " + e.getMessage());
		    request.getRequestDispatcher("Cliente.jsp").forward(request, response);
		}
	}
	
	
	
	
	private void modificarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try 
		{
	        int codigoClie = Integer.parseInt(request.getParameter("codigoClie"));
	        String nuevoNombre = request.getParameter("txtNombres");
	        String nuevoApellido = request.getParameter("txtApellidos");
	        String nuevoEmail = request.getParameter("txtCorreo");
	        String nuevoNumero = request.getParameter("txtTelefono");
	        String nuevoTipoDocumento = request.getParameter("txtTipoDocumento");
	        String nuevoDocumento = request.getParameter("txtDocumento");
	        String nuevaProvincia = request.getParameter("txtProvincia");
	        String nuevoDistrito = request.getParameter("txtDistrito");
	        String nuevaDireccion = request.getParameter("txtDireccion");
			
			Cliente clienteAModificar=clienteDao.obtenerporID(codigoClie);
	      
			if(clienteAModificar !=null)
			{
				clienteAModificar.setNombreClie(nuevoNombre);
				clienteAModificar.setApellidoClie(nuevoApellido);
				clienteAModificar.setEmailClie(nuevoEmail);

				if (nuevoNumero != null && !nuevoNumero.trim().isEmpty()) {
					clienteAModificar.setNumeroClie(nuevoNumero);
	            } else {
	            	clienteAModificar.setNumeroClie(null); 
	            }
				
				clienteAModificar.setTipoDocumento(nuevoTipoDocumento);
				clienteAModificar.setDocumentoClie(nuevoDocumento);
				clienteAModificar.setProvinciaClie(nuevaProvincia);
				clienteAModificar.setDistritoClie(nuevoDistrito);
				clienteAModificar.setDireccionClie(nuevaDireccion);
				
				clienteDao.actualizarCliente(clienteAModificar);
	        
				request.setAttribute("successMessage", "Cliente actualizado correctamente.");
	            response.sendRedirect(request.getContextPath() + "/controladorCliente");	
			}else {
	            request.setAttribute("errorMessage", "Cliente no encontrado.");
	            request.getRequestDispatcher("error.jsp").forward(request, response);

			}
			
			
			
		} 
		
		catch (NumberFormatException e) {
			request.setAttribute("errorMessage", "Formato inválido en los campos numéricos.");
	        request.getRequestDispatcher("error.jsp").forward(request, response);		}
		
		catch (Exception e) {
		        request.setAttribute("errorMessage", "Error al actualizar el cliente: " + e.getMessage());
		        request.getRequestDispatcher("error.jsp").forward(request, response);
		    }
		
	}
	
	
	private void eliminarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		
		try 
		{
			int codigoCliente=Integer.parseInt(request.getParameter("txtCodigoCliente"));
	        System.out.println("Código de empleado a eliminar: " + codigoCliente);
	        if (codigoCliente <= 0) {
	            throw new IllegalArgumentException("El código del cliente no es válido.");
	        }
		
	        Cliente cliente= new Cliente();
	        cliente.setCodigoClie(codigoCliente);
	        
	        clienteDao.eliminarCliente(cliente);
	        
	        response.sendRedirect(request.getContextPath() + "/controladorCliente");
	        
	        response.getWriter().write("Cliente eliminado con éxito.");
	        response.getWriter().flush();

	        
		} catch (Exception e) {
		    e.printStackTrace();
		    request.setAttribute("errorMessage", "Error al eliminar cliente: " + e.getMessage());
		    request.getRequestDispatcher("Cliente.jsp").forward(request, response);
		}
		
	}
	
	
	
	
	
	
	
	
	
}//fin del controlador 
