package interfaces;

import java.util.List;

import model.Producto;

public interface iProducto {

	void insertarProducto(Producto producto);
	void modificarProducto(Producto producto);
	void eliminarProducto(Producto producto);
	List<Producto>listarProducto();
	Producto obtenerporID(int codigoProd);
	
}
