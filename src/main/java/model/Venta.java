package model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the ventas database table.
 * 
 */
@Entity
@Table(name="ventas")
@NamedQuery(name="Venta.findAll", query="SELECT v FROM Venta v")
public class Venta implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ID_VENTA")
	private int idVenta;

	@Column(name="APELLIDO_CLIE")
	private String apellidoClie;

	private int cantidad;

	@Column(name="CATEGORIA_PROD")
	private String categoriaProd;

	private BigDecimal descuento;

	private String documento;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="FECHA_MODIFICACION")
	private Date fechaModificacion;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="FECHA_VENTA")
	private Date fechaVenta;

	@Column(name="NOMBRE_CLIE")
	private String nombreClie;

	@Column(name="NOMBRE_EMPLEADO")
	private String nombreEmpleado;

	@Column(name="NOMBRE_PROD")
	private String nombreProd;

	@Column(name="PRECIO_PROD")
	private BigDecimal precioProd;

	@Column(name="PRENDA_PROD")
	private String prendaProd;

	@Column(name="TALLA_PROD")
	private String tallaProd;

	@Column(name="TIPO_DOCUMENTO")
	private String tipoDocumento;

	private BigDecimal total;

	//bi-directional many-to-one association to Cliente
	@ManyToOne
	@JoinColumn(name="CODIGO_CLIE")
	private Cliente cliente;

	//bi-directional many-to-one association to Producto
	@ManyToOne
	@JoinColumn(name="CODIGO_PROD")
	private Producto producto;

	public Venta() {
	}

	public int getIdVenta() {
		return this.idVenta;
	}

	public void setIdVenta(int idVenta) {
		this.idVenta = idVenta;
	}

	public String getApellidoClie() {
		return this.apellidoClie;
	}

	public void setApellidoClie(String apellidoClie) {
		this.apellidoClie = apellidoClie;
	}

	public int getCantidad() {
		return this.cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public String getCategoriaProd() {
		return this.categoriaProd;
	}

	public void setCategoriaProd(String categoriaProd) {
		this.categoriaProd = categoriaProd;
	}

	public BigDecimal getDescuento() {
		return this.descuento;
	}

	public void setDescuento(BigDecimal descuento) {
		this.descuento = descuento;
	}

	public String getDocumento() {
		return this.documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public Date getFechaModificacion() {
		return this.fechaModificacion;
	}

	public void setFechaModificacion(Date fechaModificacion) {
		this.fechaModificacion = fechaModificacion;
	}

	public Date getFechaVenta() {
		return this.fechaVenta;
	}

	public void setFechaVenta(Date fechaVenta) {
		this.fechaVenta = fechaVenta;
	}

	public String getNombreClie() {
		return this.nombreClie;
	}

	public void setNombreClie(String nombreClie) {
		this.nombreClie = nombreClie;
	}

	public String getNombreEmpleado() {
		return this.nombreEmpleado;
	}

	public void setNombreEmpleado(String nombreEmpleado) {
		this.nombreEmpleado = nombreEmpleado;
	}

	public String getNombreProd() {
		return this.nombreProd;
	}

	public void setNombreProd(String nombreProd) {
		this.nombreProd = nombreProd;
	}

	public BigDecimal getPrecioProd() {
		return this.precioProd;
	}

	public void setPrecioProd(BigDecimal precioProd) {
		this.precioProd = precioProd;
	}

	public String getPrendaProd() {
		return this.prendaProd;
	}

	public void setPrendaProd(String prendaProd) {
		this.prendaProd = prendaProd;
	}

	public String getTallaProd() {
		return this.tallaProd;
	}

	public void setTallaProd(String tallaProd) {
		this.tallaProd = tallaProd;
	}

	public String getTipoDocumento() {
		return this.tipoDocumento;
	}

	public void setTipoDocumento(String tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}

	public BigDecimal getTotal() {
		return this.total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public Cliente getCliente() {
		return this.cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public Producto getProducto() {
		return this.producto;
	}

	public void setProducto(Producto producto) {
		this.producto = producto;
	}

}