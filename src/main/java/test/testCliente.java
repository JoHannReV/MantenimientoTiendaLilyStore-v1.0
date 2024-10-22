package test;

import model.Cliente;

import java.util.List;

import daoImp.clienteDao;

public class testCliente {


	 public static void main(String[] args) {
	clienteDao instance = new clienteDao();

	//INSERTAR CLIENTE
	/*
    Cliente cliente = new Cliente();
    cliente.setNombreClie("Alex");
    cliente.setApellidoClie("Pérez");
    cliente.setEmailClie("Alex.perez@example.com");
    cliente.setNumeroClie("982654321");
    cliente.setTipoDocumento("DNI");
    cliente.setDocumentoClie("122345678");
    cliente.setProvinciaClie("Lima");
    cliente.setDistritoClie("Miraflores");
    cliente.setDireccionClie("Av. Principal 123");
    

    try {
        instance.insertarCliente(cliente);
        System.out.println("Cliente insertado exitosamente.");
    } catch (Exception e) {
        System.err.println("Error al insertar cliente: " + e.getMessage());
    }
	*/
	
	
//TEST LISTAR
	     /*   
	        List<Cliente> listaClientes = instance.listarCliente();
	        
	        if (listaClientes != null && !listaClientes.isEmpty()) {
	            System.out.println("Lista de Clientes:");
	            for (Cliente cliente : listaClientes) {
	                System.out.println("Nombre: " + cliente.getNombreClie() + 
	                                   ", Apellido: " + cliente.getApellidoClie() + 
	                                   ", Email: " + cliente.getEmailClie() + 
	                                   ", Número: " + cliente.getNumeroClie() + 
	                                   ", TIPO docu: " + cliente.getTipoDocumento() + 
	                                   ", Documento: " + cliente.getDocumentoClie() +
	                                   ", Provincia: " + cliente.getProvinciaClie() +
	                                   ", Distrito: " + cliente.getDistritoClie() +
	                                   ", Dirección: " + cliente.getDireccionClie());
	            }
	        } else {
	            System.out.println("No se encontraron clientes en la bd.");
	        }
*/    
	/*
	Cliente cliente = new Cliente();
	cliente.setCodigoClie(2); // Código del cliente a modificar
	cliente.setNombreClie("Nuevo Nombre");
	cliente.setApellidoClie("Nuevo Apellido");
	cliente.setEmailClie("nuevo.email@example.com");
	cliente.setNumeroClie("987654321");
	cliente.setTipoDocumento("DNI");
	cliente.setDocumentoClie("12345678");
	cliente.setProvinciaClie("Nueva Provincia");
	cliente.setDistritoClie("Nuevo Distrito");
	cliente.setDireccionClie("Nueva Dirección");

	instance.actualizarCliente(cliente);

     
     System.out.println("Cliente actualizado."); */
	
	
	Cliente clienteParaEliminar = new Cliente();
    clienteParaEliminar.setCodigoClie(3); 

    try {
        instance.eliminarCliente(clienteParaEliminar);
        System.out.println("Cliente eliminado con éxito.");
    } catch (Exception e) {
        System.out.println("Error al eliminar el cliente: " + e.getMessage());
    }
	

	
	
	
	
	 }
	 
}
	

