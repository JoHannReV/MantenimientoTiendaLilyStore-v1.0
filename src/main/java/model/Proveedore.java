package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the proveedores database table.
 * 
 */
@Entity
@Table(name="proveedores")
@NamedQuery(name="Proveedore.findAll", query="SELECT p FROM Proveedore p")
public class Proveedore implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private int proveedorid;

	@Column(name="DIRECCION_PROVE")
	private String direccionProve;

	@Column(name="EMAIL_PROVE")
	private String emailProve;

	@Column(name="NOMBRE_PROVE")
	private String nombreProve;

	@Column(name="NUMERO_PROVE")
	private String numeroProve;

	@Column(name="PAIS_PROVE")
	private String paisProve;

	@Column(name="TELEFONO_PROVE")
	private String telefonoProve;

	//bi-directional many-to-one association to Producto
	@OneToMany(mappedBy="proveedore")
	private List<Producto> productos;

	public Proveedore() {
	}

	public int getProveedorid() {
		return this.proveedorid;
	}

	public void setProveedorid(int proveedorid) {
		this.proveedorid = proveedorid;
	}

	public String getDireccionProve() {
		return this.direccionProve;
	}

	public void setDireccionProve(String direccionProve) {
		this.direccionProve = direccionProve;
	}

	public String getEmailProve() {
		return this.emailProve;
	}

	public void setEmailProve(String emailProve) {
		this.emailProve = emailProve;
	}

	public String getNombreProve() {
		return this.nombreProve;
	}

	public void setNombreProve(String nombreProve) {
		this.nombreProve = nombreProve;
	}

	public String getNumeroProve() {
		return this.numeroProve;
	}

	public void setNumeroProve(String numeroProve) {
		this.numeroProve = numeroProve;
	}

	public String getPaisProve() {
		return this.paisProve;
	}

	public void setPaisProve(String paisProve) {
		this.paisProve = paisProve;
	}

	public String getTelefonoProve() {
		return this.telefonoProve;
	}

	public void setTelefonoProve(String telefonoProve) {
		this.telefonoProve = telefonoProve;
	}

	public List<Producto> getProductos() {
		return this.productos;
	}

	public void setProductos(List<Producto> productos) {
		this.productos = productos;
	}

	public Producto addProducto(Producto producto) {
		getProductos().add(producto);
		producto.setProveedore(this);

		return producto;
	}

	public Producto removeProducto(Producto producto) {
		getProductos().remove(producto);
		producto.setProveedore(null);

		return producto;
	}

}