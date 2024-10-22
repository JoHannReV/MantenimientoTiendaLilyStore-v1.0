package model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the productos database table.
 * 
 */
@Entity
@Table(name="productos")
@NamedQuery(name="Producto.findAll", query="SELECT p FROM Producto p")
public class Producto implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="CODIGO_PROD")
	private int codigoProd;

	@Column(name="CATEGORIA_PROD")
	private String categoriaProd;

	@Lob
	@Column(name="DESCRIPCION_PROD")
	private String descripcionProd;

	private BigDecimal descuento;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="FECHA_INGRESO")
	private Date fechaIngreso;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="FECHA_MODIFICACION")
	private Date fechaModificacion;

	@Column(name="GANANCIA_PROD")
	private BigDecimal gananciaProd;

	@Column(name="NOMBRE_PROD")
	private String nombreProd;

	@Column(name="NUMERO_LOTE_PROD")
	private String numeroLoteProd;

	@Column(name="PRECIO_FINAL")
	private BigDecimal precioFinal;

	@Column(name="PRECIO_INGRESO_PROD")
	private BigDecimal precioIngresoProd;

	@Column(name="PRENDA_PROD")
	private String prendaProd;

	private int stock;

	@Column(name="TALLA_PROD")
	private String tallaProd;

	//bi-directional many-to-one association to Proveedore
	@ManyToOne
	@JoinColumn(name="MARCA_ID")
	private Proveedore proveedore;

	

	
	
    public Producto() {
    }

	public int getCodigoProd() {
		return this.codigoProd;
	}

	public void setCodigoProd(int codigoProd) {
		this.codigoProd = codigoProd;
	}

	public String getCategoriaProd() {
		return this.categoriaProd;
	}

	public void setCategoriaPro(String categoriaPro) {
		this.categoriaProd = categoriaPro;
	}

	

	public String getDescripcionProd() {
		return this.descripcionProd;
	}

	public void setDescripcionProd(String descripcionProd) {
		this.descripcionProd = descripcionProd;
	}

	public BigDecimal getDescuento() {
		return this.descuento;
	}

	public void setDescuento(BigDecimal descuento) {
		this.descuento = descuento;
	}

	public Date getFechaIngreso() {
		return this.fechaIngreso;
	}

	public void setFechaIngreso(Date fechaIngreso) {
		this.fechaIngreso = fechaIngreso;
	}

	public Date getFechaModificacion() {
		return this.fechaModificacion;
	}

	public void setFechaModificacion(Date fechaModificacion) {
		this.fechaModificacion = fechaModificacion;
	}

	public BigDecimal getGananciaProd() {
		return this.gananciaProd;
	}

	public void setGananciaProd(BigDecimal gananciaProd) {
		this.gananciaProd = gananciaProd;
	}

	public String getNombreProd() {
		return this.nombreProd;
	}

	public void setNombreProd(String nombreProd) {
		this.nombreProd = nombreProd;
	}

	public String getNumeroLoteProd() {
		return this.numeroLoteProd;
	}

	public void setNumeroLoteProd(String numeroLoteProd) {
		this.numeroLoteProd = numeroLoteProd;
	}

	public BigDecimal getPrecioFinal() {
		return this.precioFinal;
	}

	public void setPrecioFinal(BigDecimal precioFinal) {
		this.precioFinal = precioFinal;
	}

	public BigDecimal getPrecioIngresoProd() {
		return this.precioIngresoProd;
	}

	public void setPrecioIngresoProd(BigDecimal precioIngresoProd) {
		this.precioIngresoProd = precioIngresoProd;
	}

	public String getPrendaProd() {
		return this.prendaProd;
	}

	public void setPrendaProd(String prendaProd) {
		this.prendaProd = prendaProd;
	}

	public int getStock() {
		return this.stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getTallaProd() {
		return this.tallaProd;
	}

	public void setTallaProd(String tallaProd) {
		this.tallaProd = tallaProd;
	}

	public Proveedore getProveedore() {
		return this.proveedore;
	}

	public void setProveedore(Proveedore proveedore) {
		this.proveedore = proveedore;
	}

}