package interfaces;

import java.util.List;

import model.Cliente;

public interface iCliente {

	void insertarCliente(Cliente cliente);
	void actualizarCliente(Cliente cliente);
	void eliminarCliente(Cliente cliente);
	List <Cliente>listarCliente();
	Cliente obtenerporID( int codigoClie);
}
