package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the clientes database table.
 * 
 */
@Entity
@Table(name="clientes")
@NamedQuery(name="Cliente.findAll", query="SELECT c FROM Cliente c")
public class Cliente implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="CODIGO_CLIE")
	private int codigoClie;

	@Column(name="APELLIDO_CLIE")
	private String apellidoClie;

	@Column(name="DIRECCION_CLIE")
	private String direccionClie;

	@Column(name="DISTRITO_CLIE")
	private String distritoClie;

	@Column(name="DOCUMENTO_CLIE")
	private String documentoClie;

	@Column(name="EMAIL_CLIE")
	private String emailClie;

	@Column(name="NOMBRE_CLIE")
	private String nombreClie;

	@Column(name="NUMERO_CLIE")
	private String numeroClie;

	@Column(name="PROVINCIA_CLIE")
	private String provinciaClie;

	@Column(name="TIPO_DOCUMENTO")
	private String tipoDocumento;

	public Cliente() {
	}

	public int getCodigoClie() {
		return this.codigoClie;
	}

	public void setCodigoClie(int codigoClie) {
		this.codigoClie = codigoClie;
	}

	public String getApellidoClie() {
		return this.apellidoClie;
	}

	public void setApellidoClie(String apellidoClie) {
		this.apellidoClie = apellidoClie;
	}

	public String getDireccionClie() {
		return this.direccionClie;
	}

	public void setDireccionClie(String direccionClie) {
		this.direccionClie = direccionClie;
	}

	public String getDistritoClie() {
		return this.distritoClie;
	}

	public void setDistritoClie(String distritoClie) {
		this.distritoClie = distritoClie;
	}

	public String getDocumentoClie() {
		return this.documentoClie;
	}

	public void setDocumentoClie(String documentoClie) {
		this.documentoClie = documentoClie;
	}

	public String getEmailClie() {
		return this.emailClie;
	}

	public void setEmailClie(String emailClie) {
		this.emailClie = emailClie;
	}

	public String getNombreClie() {
		return this.nombreClie;
	}

	public void setNombreClie(String nombreClie) {
		this.nombreClie = nombreClie;
	}

	public String getNumeroClie() {
		return this.numeroClie;
	}

	public void setNumeroClie(String numeroClie) {
		this.numeroClie = numeroClie;
	}

	public String getProvinciaClie() {
		return this.provinciaClie;
	}

	public void setProvinciaClie(String provinciaClie) {
		this.provinciaClie = provinciaClie;
	}

	public String getTipoDocumento() {
		return this.tipoDocumento;
	}

	public void setTipoDocumento(String tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}

}