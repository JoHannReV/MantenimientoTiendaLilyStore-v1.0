package test;

import java.math.BigDecimal;
import java.util.List;

import daoImp.ventaDao;
import model.Cliente;
import model.Producto;
import model.Venta;

public class tesVenta {

	public static void main(String[] args) {

	/*
		        // Crear un cliente
		        Cliente cliente = new Cliente();
		        cliente.setCodigoClie(1); // Supongamos que el cliente ya existe
		        cliente.setNombreClie("Juan");
		        cliente.setApellidoClie("P�rez");

		        // Crear un producto
		        Producto producto = new Producto();
		        producto.setCodigoProd(101); // Supongamos que el producto ya existe
		        producto.setPrendaProd("Camiseta Deportiva");
		        producto.setCategoriaProd("Ropa"); // Aseg�rate de que el nombre del m�todo sea correcto
		        producto.setTallaProd("M");

		        // Crear un objeto Venta
		        Venta venta = new Venta();
		        venta.setDocumento("12345678"); // Documento
		        venta.setTipoDocumento("DNI"); // Tipo de documento
		        venta.setCliente(cliente); // Asignar el cliente
		        venta.setNombreClie(cliente.getNombreClie()); // Nombre del cliente
		        venta.setApellidoClie(cliente.getApellidoClie()); // Apellido del cliente
		        venta.setNombreEmpleado("Mar�a Garc�a"); // Nombre del empleado
		        venta.setProducto(producto); // Asignar el producto
		        venta.setPrendaProd(producto.getPrendaProd()); // Prenda
		        venta.setNombreProd(producto.getPrendaProd()); // Nombre del producto
		        venta.setCategoriaProd(producto.getCategoriaProd()); // Categor�a
		        venta.setTallaProd(producto.getTallaProd()); // Talla
		        venta.setCantidad(2); // Cantidad
		        venta.setDescuento(BigDecimal.valueOf(10.00)); // Descuento
		        venta.setTotal(BigDecimal.valueOf(30.00)); // Total

		        // Crear instancia del DAO y llamar al m�todo insertarVenta
		        ventaDao ventaDAO = new ventaDao(); // Corrige el nombre de la clase
		        ventaDAO.insertarVenta(venta);

		        System.out.println("Venta insertada exitosamente.");	
		*/
		/*
		 List<Venta> ventas = ventaDao.listarVentas();

	        // Imprimir las ventas listadas
	        if (ventas != null && !ventas.isEmpty()) {
	            for (Venta venta : ventas) {
	                System.out.println("Documento: " + venta.getDocumento() + 
	                                   ", Tipo de Documento: " + venta.getTipoDocumento() +
	                                   ", Cliente: " + venta.getNombreClie() + " " + venta.getApellidoClie() + 
	                                   ", Nombre Empleado: " + venta.getNombreEmpleado() + 
	                                   ", Producto: " + venta.getNombreProd() + 
	                                   ", Prenda: " + venta.getPrendaProd() + 
	                                   ", Categor�a: " + venta.getCategoriaProd() + 
	                                   ", Talla: " + venta.getTallaProd() + 
	                                   ", Cantidad: " + venta.getCantidad() + 
	                                   ", Descuento: " + venta.getDescuento() + 
	                                   ", Total: " + venta.getTotal());
	            }
	        } else {
	            System.out.println("No se encontraron ventas.");
	        }
		
		*/
		
		/*
		  ventaDao ventaDAO = new ventaDao();

	        // ID de la venta que quieres buscar
	        int idVenta = 1; // Cambia este valor seg�n el ID que deseas probar

	        // Llama al m�todo para obtener la venta por ID
	        List<Venta> ventas = ventaDAO.obtenerporID(idVenta);

	        // Imprimir la venta obtenida
	        if (ventas != null && !ventas.isEmpty()) {
	            for (Venta venta : ventas) {
	                System.out.println("Documento: " + venta.getDocumento() + 
	                                   ", Tipo de Documento: " + venta.getTipoDocumento() +
	                                   ", Cliente: " + venta.getNombreClie() + " " + venta.getApellidoClie() + 
	                                   ", Nombre Empleado: " + venta.getNombreEmpleado() + 
	                                   ", Producto: " + venta.getNombreProd() + 
	                                   ", Prenda: " + venta.getPrendaProd() + 
	                                   ", Categor�a: " + venta.getCategoriaProd() + 
	                                   ", Talla: " + venta.getTallaProd() + 
	                                   ", Cantidad: " + venta.getCantidad() + 
	                                   ", Descuento: " + venta.getDescuento() + 
	                                   ", Total: " + venta.getTotal());
	            }
	        } else {
	            System.out.println("No se encontr� la venta con ID: " + idVenta);
	        }
		
		
		*/
		
		
		
		
		
		
	}

}
