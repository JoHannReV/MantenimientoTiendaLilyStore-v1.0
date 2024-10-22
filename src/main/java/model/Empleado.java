package model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the empleados database table.
 * 
 */
@Entity
@Table(name="empleados")
@NamedQuery(name="Empleado.findAll", query="SELECT e FROM Empleado e")
public class Empleado implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="codigo_emp")
	private int codigoEmp;

	@Column(name="apellido_emp")
	private String apellidoEmp;

	@Column(name="descuento_pension_emp")
	private BigDecimal descuentoPensionEmp;

	@Column(name="descuento_seguro_emp")
	private BigDecimal descuentoSeguroEmp;

	@Column(name="direccion_emp")
	private String direccionEmp;

	@Column(name="distrito_emp")
	private String distritoEmp;

	@Column(name="documento_emp")
	private String documentoEmp;

	@Column(name="email_emp")
	private String emailEmp;

	@Column(name="nombre_emp")
	private String nombreEmp;

	@Column(name="numero_emp")
	private String numeroEmp;

	@Column(name="provincia_emp")
	private String provinciaEmp;

	@Column(name="sueldo_bruto_emp")
	private BigDecimal sueldoBrutoEmp;

	@Column(name="sueldo_neto_emp")
	private BigDecimal sueldoNetoEmp;

	@Column(name="tipo_documento")
	private String tipoDocumento;

	@Column(name="tipo_pension_emp")
	private String tipoPensionEmp;

	@Column(name="tipo_seguro_emp")
	private String tipoSeguroEmp;

	//bi-directional many-to-one association to Cargo
	@ManyToOne
	@JoinColumn(name="cargoID")
	private Cargo cargo;

	//bi-directional many-to-one association to Usuariosacceso
	@ManyToOne
	@JoinColumn(name="usuarioID")
	private Usuariosacceso usuariosacceso;

	public Empleado() {
	}

	public int getCodigoEmp() {
		return this.codigoEmp;
	}

	public void setCodigoEmp(int codigoEmp) {
		this.codigoEmp = codigoEmp;
	}

	public String getApellidoEmp() {
		return this.apellidoEmp;
	}

	public void setApellidoEmp(String apellidoEmp) {
		this.apellidoEmp = apellidoEmp;
	}

	public BigDecimal getDescuentoPensionEmp() {
		return this.descuentoPensionEmp;
	}

	public void setDescuentoPensionEmp(BigDecimal descuentoPensionEmp) {
		this.descuentoPensionEmp = descuentoPensionEmp;
	}

	public BigDecimal getDescuentoSeguroEmp() {
		return this.descuentoSeguroEmp;
	}

	public void setDescuentoSeguroEmp(BigDecimal descuentoSeguroEmp) {
		this.descuentoSeguroEmp = descuentoSeguroEmp;
	}

	public String getDireccionEmp() {
		return this.direccionEmp;
	}

	public void setDireccionEmp(String direccionEmp) {
		this.direccionEmp = direccionEmp;
	}

	public String getDistritoEmp() {
		return this.distritoEmp;
	}

	public void setDistritoEmp(String distritoEmp) {
		this.distritoEmp = distritoEmp;
	}

	public String getDocumentoEmp() {
		return this.documentoEmp;
	}

	public void setDocumentoEmp(String documentoEmp) {
		this.documentoEmp = documentoEmp;
	}

	public String getEmailEmp() {
		return this.emailEmp;
	}

	public void setEmailEmp(String emailEmp) {
		this.emailEmp = emailEmp;
	}

	public String getNombreEmp() {
		return this.nombreEmp;
	}

	public void setNombreEmp(String nombreEmp) {
		this.nombreEmp = nombreEmp;
	}

	public String getNumeroEmp() {
		return this.numeroEmp;
	}

	public void setNumeroEmp(String numeroEmp) {
		this.numeroEmp = numeroEmp;
	}

	public String getProvinciaEmp() {
		return this.provinciaEmp;
	}

	public void setProvinciaEmp(String provinciaEmp) {
		this.provinciaEmp = provinciaEmp;
	}

	public BigDecimal getSueldoBrutoEmp() {
		return this.sueldoBrutoEmp;
	}

	public void setSueldoBrutoEmp(BigDecimal sueldoBrutoEmp) {
		this.sueldoBrutoEmp = sueldoBrutoEmp;
	}

	public BigDecimal getSueldoNetoEmp() {
		return this.sueldoNetoEmp;
	}

	public void setSueldoNetoEmp(BigDecimal sueldoNetoEmp) {
		this.sueldoNetoEmp = sueldoNetoEmp;
	}

	public String getTipoDocumento() {
		return this.tipoDocumento;
	}

	public void setTipoDocumento(String tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}

	public String getTipoPensionEmp() {
		return this.tipoPensionEmp;
	}

	public void setTipoPensionEmp(String tipoPensionEmp) {
		this.tipoPensionEmp = tipoPensionEmp;
	}

	public String getTipoSeguroEmp() {
		return this.tipoSeguroEmp;
	}

	public void setTipoSeguroEmp(String tipoSeguroEmp) {
		this.tipoSeguroEmp = tipoSeguroEmp;
	}

	public Cargo getCargo() {
		return this.cargo;
	}

	public void setCargo(Cargo cargo) {
		this.cargo = cargo;
	}

	public Usuariosacceso getUsuariosacceso() {
		return this.usuariosacceso;
	}

	public void setUsuariosacceso(Usuariosacceso usuariosacceso) {
		this.usuariosacceso = usuariosacceso;
	}

}