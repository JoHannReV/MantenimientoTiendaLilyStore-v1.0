package interfaces;
import java.util.List;



import model.Empleado;
public interface iEmpleado {

	void insertarEmpleado(Empleado empleado);
	void actualizarEmpleado(Empleado empleado);
	void eliminarEmpleado(Empleado empleado);
	Empleado obtenerporID(int codigoEmp);
	List<Empleado> ListarEmpleado();

}
