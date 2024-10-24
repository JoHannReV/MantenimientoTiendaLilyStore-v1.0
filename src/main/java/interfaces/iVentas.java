package interfaces;

import java.util.List;

import model.Venta;

public interface iVentas {

	void insertarVenta(Venta venta);
	void modificarVenta(Venta venta);
	
	List<Venta> obtenerporID(int idVenta);
}
