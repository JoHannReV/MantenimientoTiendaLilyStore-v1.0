package test;

import java.math.BigDecimal;
import java.util.List;

import daoImp.productoDao;
import model.Producto;
import model.Proveedore;

public class testProducto {

	
	public static void main(String[] args) {
       
	}}
		/*
		// Crear una instancia del DAO

        proveedor.setProveedorid(1); // Cambia este valor seg�n tu base de datos

        // Crear un nuevo producto y establecer sus atributos
        Producto producto = new Producto();
        producto.setProveedore(proveedor);
        producto.setPrendaProd("Pantal�n Jeans");  // Establece el tipo de prenda
        producto.setNombreProd("Jeans Azul");
        producto.setCategoriaPro("Ropa Casual");
        producto.setDescripcionProd("Pantal�n de mezclilla resistente");
        producto.setTallaProd("32");
        producto.setNumeroLoteProd("Lote345");
        producto.setPrecioIngresoProd(new BigDecimal("30.50"));  // Aseg�rate de usar BigDecimal
        producto.setStock(150);  // Ejemplo de cantidad en stock

        // Llamar al m�todo para insertar el producto
        productoDAO.insertarProducto(producto);

        System.out.println("Producto insertado correctamente.");
	*/
		
		
        /*
        List<Producto> productos = dao.listarProducto(); // Llama al m�todo

        // Imprime los productos listados
        if (productos != null && !productos.isEmpty()) {
            for (Producto producto : productos) {
                System.out.println("ID: " + producto.getCodigoProd() + 
                		", Nombre: " + producto.getNombreProd() + ", Precio: " + producto.getPrecioIngresoProd() + "cate"+ producto.getCategoriaProd());
            }
        } else {
            System.out.println("No se encontraron productos.");
        }
        
       */
        /*
        Producto producto = new Producto();
        producto.setCodigoProd(13); 

        dao.eliminarProducto(producto);
		
        
        
   
     // Obtener el proveedor por ID
        Proveedore proveedor = dao.obtenerProveedorPorID(3); // Cambia 14 por el ID del proveedor que deseas
/*
        if (proveedor != null) {
            producto.setCodigoProd(14); 
            producto.setNombreProd("Nuevo Nombre");
            producto.setProveedore(proveedor); // Usar el proveedor obtenido
            producto.setPrendaProd("Camiseta");
            producto.setCategoriaPro("Ropa");
            producto.setDescripcionProd("Descripci�n actualizada");
            producto.setTallaProd("M");
            producto.setNumeroLoteProd("Lote123");
            producto.setPrecioIngresoProd(new BigDecimal(100.00));
            producto.setDescuento(new BigDecimal("6.00")); // Descuento de 5
            producto.setStock(50);

            // Llamar al m�todo de modificaci�n
            dao.modificarProducto(producto);
        } else {
            System.err.println("Proveedor no encontrado.");
        }
    */
		
		/*
       
                // Instanciamos el DAO
                productoDao dao = new productoDao();

                // Creamos un nuevo producto
                Producto producto = new Producto();
                
                // Creamos un proveedor y lo asignamos al producto
                Proveedore proveedor = new Proveedore();
                proveedor.setProveedorid(1); // Aqu� deber�as poner un ID v�lido que exista en tu tabla 'proveedores'
                producto.setProveedore(proveedor);
                
                // Seteamos los valores del producto
                producto.setPrendaProd("Camisa");
                producto.setNombreProd("Camisa formal");
                producto.setCategoriaPro("Ropa Formal");
                producto.setDescripcionProd("Camisa blanca formal de alta calidad");
                producto.setTallaProd("L");
                producto.setNumeroLoteProd("12345");
                producto.setPrecioIngresoProd(new BigDecimal(50.00));
                producto.setStock(100);
                
                // Intentamos insertar el producto
                try {
                    dao.insertarProducto(producto);
                    System.out.println("Producto insertado con �xito.");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        */
		
		
	

