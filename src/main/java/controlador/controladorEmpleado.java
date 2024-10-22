package controlador;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daoImp.empleadoDao;
import model.Cargo;
import model.Empleado;
import model.Usuariosacceso;

/**
 * Servlet implementation class controladorEmpleado
 */
public class controladorEmpleado extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private empleadoDao empleadoDAO = new empleadoDao();

    public controladorEmpleado() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    	String codigoEmpStr = request.getParameter("codigoEmp");

    
        
        List<Empleado> listado = empleadoDAO.ListarEmpleado();
        request.setAttribute("listado", listado);
        
        request.getRequestDispatcher("Empleado.jsp").forward(request, response);
    
    
    }



	   


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		
		try{
			if("agregar".equals(action))
			{
				agregarEmpleado(request,response);
		    }
			else if("eliminar".equals(action))
			{
				eliminarEmpleado(request,response);
			}else if ("actualizar".equals(action)) { 
	            modificarEmpleado(request, response);
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

	}//fin del post
	
	
	private void modificarEmpleado(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        // Obtener los parámetros del formulario
	        int codigoEmp = Integer.parseInt(request.getParameter("codigoEmp"));
	        String nuevoNombre = request.getParameter("txtNombres");
	        String nuevoApellido = request.getParameter("txtApellidos");
	        String nuevoEmail = request.getParameter("txtCorreo");
	        String nuevoNumero = request.getParameter("txtTelefono");
	        String nuevoTipoDocumento = request.getParameter("txtTipoDocumento");
	        String nuevoDocumento = request.getParameter("txtDocumento");
	        String nuevaProvincia = request.getParameter("txtProvincia");
	        String nuevoDistrito = request.getParameter("txtDistrito");
	        String nuevaDireccion = request.getParameter("txtDireccion");
	        BigDecimal nuevoSueldoBruto = new BigDecimal(request.getParameter("txtSueldo"));
	        String nuevoTipoPension = request.getParameter("txtTipoPension");
	        String nuevoTipoSeguro = request.getParameter("txtTipoSeguro");
	        int nuevoCargoID = Integer.parseInt(request.getParameter("txtCargoID"));
	        String nuevoUsuario = request.getParameter("txtUsuario");
	        String nuevoPassword = request.getParameter("txtPassword");

	        // Obtener el empleado a modificar por ID
	        Empleado empleadoAModificar = empleadoDAO.obtenerporID(codigoEmp);

	        if (empleadoAModificar != null) {
	            // Modificar los campos del empleado
	            empleadoAModificar.setNombreEmp(nuevoNombre);
	            empleadoAModificar.setApellidoEmp(nuevoApellido);
	            empleadoAModificar.setEmailEmp(nuevoEmail);

	            // Verificar si nuevoNumero es nulo o vacío antes de establecer
	            if (nuevoNumero != null && !nuevoNumero.trim().isEmpty()) {
	                empleadoAModificar.setNumeroEmp(nuevoNumero);
	            } else {
	                empleadoAModificar.setNumeroEmp(null); // O mantener el valor existente
	            }

	            empleadoAModificar.setTipoDocumento(nuevoTipoDocumento);
	            empleadoAModificar.setDocumentoEmp(nuevoDocumento);
	            empleadoAModificar.setProvinciaEmp(nuevaProvincia);
	            empleadoAModificar.setDistritoEmp(nuevoDistrito);
	            empleadoAModificar.setDireccionEmp(nuevaDireccion);
	            empleadoAModificar.setSueldoBrutoEmp(nuevoSueldoBruto);
	            empleadoAModificar.setTipoPensionEmp(nuevoTipoPension);
	            empleadoAModificar.setTipoSeguroEmp(nuevoTipoSeguro);

	            // Obtener el nuevo Cargo por ID y asignarlo
	            Cargo nuevoCargo = empleadoDAO.obtenerCargoPorID(nuevoCargoID);
	            if (nuevoCargo != null) {
	                empleadoAModificar.setCargo(nuevoCargo);
	            } else {
	                System.out.println("Cargo no encontrado.");
	            }

	            // Actualizar usuario y contraseña
	            Usuariosacceso usuarioAcceso = empleadoAModificar.getUsuariosacceso();
	            if (usuarioAcceso != null) {
	                usuarioAcceso.setUsername(nuevoUsuario); // Actualizar el nombre de usuario
	                usuarioAcceso.setPassword(nuevoPassword); // Actualizar la contraseña
	            } else {
	                System.out.println("No se encontró acceso de usuario.");
	            }

	            // Actualizar el empleado en la base de datos
	            empleadoDAO.actualizarEmpleado(empleadoAModificar); // Asegúrate que este método maneje la persistencia de los cambios de usuario también.

	            // Mensaje de éxito
	            request.setAttribute("successMessage", "Empleado actualizado correctamente.");
	            response.sendRedirect(request.getContextPath() + "/controladorEmpleado");
	        } else {
	            request.setAttribute("errorMessage", "Empleado no encontrado.");
	            request.getRequestDispatcher("error.jsp").forward(request, response);
	        }
	    } catch (NumberFormatException e) {
	        request.setAttribute("errorMessage", "Formato inválido en los campos numéricos.");
	        request.getRequestDispatcher("error.jsp").forward(request, response);
	    } catch (Exception e) {
	        request.setAttribute("errorMessage", "Error al actualizar el empleado: " + e.getMessage());
	        request.getRequestDispatcher("error.jsp").forward(request, response);
	    }
	} // fin del método modificarEmpleado



		
		private void agregarEmpleado(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	
		
	    // INICIO METODO PARA AGREGAR UN EMPLEADO CORRECTAMENTE
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
		        String sueldoBrutoStr = request.getParameter("txtSueldo");
		        String tipoPension = request.getParameter("txtTipoPension");
		        String tipoSeguro = request.getParameter("txtTipoSeguro");
		        int cargoID = Integer.parseInt(request.getParameter("txtCargoID"));
		        String username = request.getParameter("txtUsuario");
		        String password = request.getParameter("txtPassword");
		        // Debug: Imprimir los parámetros recibidos(sirve para saber si esta agregando correctamente, se puede elimianr o dejar alli :D)
		        System.out.println("Nombre: " + nombre);
		        System.out.println("Apellido: " + apellido);
		        System.out.println("Email: " + email);
		        System.out.println("Teléfono: " + telefono);
		        System.out.println("Tipo Documento: " + tipoDocumento);
		        System.out.println("Documento: " + documento);
		        System.out.println("Provincia: " + provincia);
		        System.out.println("Distrito: " + distrito);
		        System.out.println("Dirección: " + direccion);
		        System.out.println("Sueldo Bruto: " + sueldoBrutoStr);
		        System.out.println("Tipo de Pensión: " + tipoPension);
		        System.out.println("Tipo de Seguro: " + tipoSeguro);
		        System.out.println("Usuario: " + username);
		        System.out.println("Contraseña: " + password);
		        // Validación básica de entrada
		        if (nombre == null || apellido == null || sueldoBrutoStr == null || username == null || password == null) {
		            throw new IllegalArgumentException("Los campos no pueden estar vacíos.");
		        }
		        BigDecimal sueldoBruto;
		        try {
		            sueldoBruto = new BigDecimal(sueldoBrutoStr);
		        } catch (NumberFormatException e) {
		            throw new IllegalArgumentException("El sueldo bruto debe ser un número válido.");
		        }
		        // Crear el empleado
		        Empleado empleado = new Empleado();
		        empleado.setNombreEmp(nombre);
		        empleado.setApellidoEmp(apellido);
		        empleado.setEmailEmp(email);
		        empleado.setNumeroEmp(telefono);
		        empleado.setTipoDocumento(tipoDocumento);
		        empleado.setDocumentoEmp(documento);
		        empleado.setProvinciaEmp(provincia);
		        empleado.setDistritoEmp(distrito);
		        empleado.setDireccionEmp(direccion);
		        empleado.setSueldoBrutoEmp(sueldoBruto); 
		        empleado.setTipoPensionEmp(tipoPension);
		        empleado.setTipoSeguroEmp(tipoSeguro);
		        Cargo cargo = new Cargo();
		        cargo.setCargoID(cargoID); 
		        empleado.setCargo(cargo); 
		        // Crear el usuario
		        Usuariosacceso usuario = new Usuariosacceso();
		        usuario.setUsername(username);
		        usuario.setPassword(password);
		        empleado.setUsuariosacceso(usuario);
		        // Insertar el empleado en la base de datos
		        empleadoDAO.insertarEmpleado(empleado);
		        // Redirigir a la página de empleados después de la inserción
		        response.sendRedirect(request.getContextPath() + "/controladorEmpleado");
		        
		    } catch (RuntimeException e) {
		    	
		    	
		    	 e.printStackTrace();
		        // En vez de redirigir a una página de error, simplemente muestra el error en la misma página
		        request.setAttribute("errorMessage", "Error al insertar empleado: " + e.getMessage());
		        request.getRequestDispatcher("Empleado.jsp").forward(request, response);
		   
		    }
		//FIN METODO PARA AGREGAR UN EMPLEADO CORRECTAMENTE 

///
		}//fin del metodo agregar
		
		
		private void eliminarEmpleado(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		

	    // INICIO METODO PARA ELIMINAR UN EMPLEADO CORRECTAMENTE

		 try {
		        // Recupera el ID del empleado a eliminar
		        int codigoEmpleado = Integer.parseInt(request.getParameter("txtCodigoEmpleado"));

		        // Debug: Imprimir el código del empleado recibido(para saber si esta eliminando correctamente )
		        System.out.println("Código de empleado a eliminar: " + codigoEmpleado);

		        // Validación básica de entrada
		        if (codigoEmpleado <= 0) {
		            throw new IllegalArgumentException("El código del empleado no es válido.");
		        }

		        // Crear un objeto Empleado con el código proporcionado
		        Empleado empleado = new Empleado();
		        empleado.setCodigoEmp(codigoEmpleado);

		        // Eliminar el empleado de la base de datos
		        empleadoDAO.eliminarEmpleado(empleado);

		        // Redirigir a la página de empleados después de la eliminación
		        response.sendRedirect(request.getContextPath() + "/controladorEmpleado");

		    } catch (RuntimeException e) {
		    	
		    	
		        e.printStackTrace();
		        // En vez de redirigir a una página de error, simplemente muestra el error en la misma página
		        request.setAttribute("errorMessage", "Error al eliminar empleado: " + e.getMessage());
		        request.getRequestDispatcher("Empleado.jsp").forward(request, response);
		    
		    }
		    // FIN METODO PARA ELIMINAR UN EMPLEADO CORRECTAMENTE 
		
		
		
		
	}//fin del metodo eliminar

}//fin del controlador
