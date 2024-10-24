package daoImp;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.ParameterMode;
import javax.persistence.Persistence;
import javax.persistence.StoredProcedureQuery;

import interfaces.iVentas;
import model.Venta;

public class ventaDao implements iVentas  {

	public void insertarVenta(Venta venta) {
	    EntityManagerFactory emf = null;
	    EntityManager em = null;

	    try {
	        emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	        em = emf.createEntityManager();
	        em.getTransaction().begin();

	        // Crear la consulta del procedimiento almacenado
	        StoredProcedureQuery query = em.createStoredProcedureQuery("insertarVenta");

	        // Registrar los parámetros del procedimiento
	        query.registerStoredProcedureParameter("p_documento", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_tipo_documento", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_codigo_clie", Integer.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_nombre_clie", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_apellido_clie", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_nombre_empleado", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_codigo_prod", Integer.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_prenda_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_nombre_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_categoria_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_talla_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_cantidad", Integer.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_descuento", BigDecimal.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_precio_prod", BigDecimal.class, ParameterMode.IN);

	        // Asignar los parámetros a la consulta
	        query.setParameter("p_documento", venta.getDocumento());
	        query.setParameter("p_tipo_documento", venta.getTipoDocumento());
	        query.setParameter("p_codigo_clie", venta.getCliente().getCodigoClie());
	        query.setParameter("p_nombre_clie", venta.getNombreClie());
	        query.setParameter("p_apellido_clie", venta.getApellidoClie());
	        query.setParameter("p_nombre_empleado", venta.getNombreEmpleado());
	        query.setParameter("p_codigo_prod", venta.getProducto().getCodigoProd());
	        query.setParameter("p_prenda_prod", venta.getPrendaProd());
	        query.setParameter("p_nombre_prod", venta.getNombreProd());
	        query.setParameter("p_categoria_prod", venta.getCategoriaProd());
	        query.setParameter("p_talla_prod", venta.getTallaProd());
	        query.setParameter("p_cantidad", venta.getCantidad());
	        query.setParameter("p_descuento", venta.getDescuento());
	        query.setParameter("p_precio_prod", venta.getPrecioProd());

	        // Ejecutar el procedimiento
	        query.execute();
	        em.getTransaction().commit();

	    } catch (Exception e) {
	        e.printStackTrace(); // Considera usar un logger
	        if (em != null && em.getTransaction().isActive()) {
	            em.getTransaction().rollback(); // Revertir la transacción si hay un error
	        }
	    } finally {
	        if (em != null) {
	            em.close(); // Cerrar EntityManager
	        }
	        if (emf != null) {
	            emf.close(); // Cerrar EntityManagerFactory
	        }
	    }
	}



	@Override
	public void modificarVenta(Venta venta) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Venta> obtenerporID(int idVenta) {
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    
	    List<Venta> ventas = new ArrayList<>();
	    
	    try {
	        em.getTransaction().begin();
	        
	        Venta venta = em.find(Venta.class, idVenta);
	        
	        if (venta != null) {
	            ventas.add(venta);
	        }
	        
	        em.getTransaction().commit(); 
	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        em.close();
	        emf.close();
	    }
	    
	    return ventas;
	}


	public static List<Venta> listarVentas() {
		EntityManagerFactory emf=Persistence.createEntityManagerFactory("MantenimientoTienda");
		EntityManager em=emf.createEntityManager();
	    
	    List<Venta> listado = null; 

	    try {
	        em.getTransaction().begin();
	        
	        listado = em.createQuery("SELECT v FROM Venta v", Venta.class).getResultList();
	        
	        em.getTransaction().commit(); 
	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        em.close();
	        emf.close();
	    }

	    return listado; 
	}
	
	
}
