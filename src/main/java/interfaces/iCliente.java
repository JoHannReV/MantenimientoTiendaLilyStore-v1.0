package interfaces;

import java.util.List;
import java.util.Optional;

import model.Cliente;

public interface iCliente {

	void insertarCliente(Cliente cliente);
	void actualizarCliente(Cliente cliente);
	void eliminarCliente(Cliente cliente);
	List <Cliente>listarCliente();
	Cliente obtenerporID( int codigoClie);
	Optional<Cliente> buscarClientePorDocumento(String documentoClie);
}
