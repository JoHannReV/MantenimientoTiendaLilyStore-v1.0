package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the usuariosacceso database table.
 * 
 */
@Entity
@NamedQuery(name="Usuariosacceso.findAll", query="SELECT u FROM Usuariosacceso u")
public class Usuariosacceso implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private int usuarioID;

	private String password;

	private String username;

	//bi-directional many-to-one association to Empleado
	@OneToMany(mappedBy="usuariosacceso")
	private List<Empleado> empleados;



	public Usuariosacceso() {
	}

	public int getUsuarioID() {
		return this.usuarioID;
	}

	public void setUsuarioID(int usuarioID) {
		this.usuarioID = usuarioID;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<Empleado> getEmpleados() {
		return this.empleados;
	}

	public void setEmpleados(List<Empleado> empleados) {
		this.empleados = empleados;
	}

	public Empleado addEmpleados(Empleado empleados) {
		getEmpleados().add(empleados);
		empleados.setUsuariosacceso(this);

		return empleados;
	}

	public Empleado removeEmpleados(Empleado empleados) {
		getEmpleados().remove(empleados);
		empleados.setUsuariosacceso(null);

		return empleados;
	}

	


}