package daoImp;

import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.ParameterMode;
import javax.persistence.Persistence;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.TypedQuery;

import interfaces.iProducto;
import model.Cargo;
import model.Cliente;
import model.Producto;
import model.Proveedore;

public class productoDao implements iProducto{

	@Override
	public void insertarProducto(Producto producto) {

		EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	     EntityManager em=emf.createEntityManager();
		
	     try
	     {
		     em.getTransaction().begin();
		     StoredProcedureQuery query = em.createStoredProcedureQuery("insertar_producto");
	         query.registerStoredProcedureParameter("p_marcaID", Integer.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_prenda_prod", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_nombre_prod", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_categoria_prod", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_descripcion_prod", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_talla_prod", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_numero_lote_prod", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_precio_ingreso_prod", Double.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_stock", Integer.class, ParameterMode.IN);
	         
	         
	         query.setParameter("p_marcaID", producto.getProveedore().getProveedorid());
	         
	         query.setParameter("p_prenda_prod", producto.getPrendaProd());
	         query.setParameter("p_nombre_prod", producto.getNombreProd());
	         query.setParameter("p_categoria_prod", producto.getCategoriaProd());
	         query.setParameter("p_descripcion_prod", producto.getDescripcionProd());
	         query.setParameter("p_talla_prod", producto.getTallaProd());
	         query.setParameter("p_numero_lote_prod", producto.getNumeroLoteProd());
	         query.setParameter("p_precio_ingreso_prod", producto.getPrecioIngresoProd().doubleValue());
	         query.setParameter("p_stock", producto.getStock());

	         query.execute();
	         em.getTransaction().commit(); 

		} catch (Exception e) 
	     { 
			if (em.getTransaction().isActive()) {
	             em.getTransaction().rollback();
	         }
	    e.printStackTrace();}
	     finally 
	     {
	         em.close();
	         emf.close();
	     }
	     
	}

	@Override
	public void modificarProducto(Producto producto) {
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    
	    try {
	        em.getTransaction().begin();
	        
	        // Verifica el producto que se est� modificando
	        System.out.println("Modificando producto: " + producto.getCodigoProd());
	        System.out.println("Nombre: " + producto.getNombreProd());

	        StoredProcedureQuery query = em.createStoredProcedureQuery("EDITAR_PRODUCTO");
	        query.registerStoredProcedureParameter("p_codigo_prod", Integer.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_marcaID", Integer.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_prenda_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_nombre_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_categoria_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_descripcion_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_talla_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_numero_lote_prod", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_precio_ingreso_prod", Double.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_descuento", Double.class, ParameterMode.IN); // A�adir par�metro de descuento
	        query.registerStoredProcedureParameter("p_stock", Integer.class, ParameterMode.IN);
	        
	        // Asignar par�metros
	        query.setParameter("p_codigo_prod", producto.getCodigoProd());
	        query.setParameter("p_marcaID", producto.getProveedore().getProveedorid());
	        query.setParameter("p_prenda_prod", producto.getPrendaProd());
	        query.setParameter("p_nombre_prod", producto.getNombreProd());
	        query.setParameter("p_categoria_prod", producto.getCategoriaProd());
	        query.setParameter("p_descripcion_prod", producto.getDescripcionProd());
	        query.setParameter("p_talla_prod", producto.getTallaProd());
	        query.setParameter("p_numero_lote_prod", producto.getNumeroLoteProd());
	        query.setParameter("p_precio_ingreso_prod", producto.getPrecioIngresoProd().doubleValue());
	        query.setParameter("p_descuento", producto.getDescuento().doubleValue()); // Asignar descuento
	        query.setParameter("p_stock", producto.getStock());
	        
	        // Ejecutar el procedimiento
	        query.execute();
	        em.getTransaction().commit();
	        System.out.println("Producto modificado correctamente.");

	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback();
	        }
	        System.err.println("Error al modificar el producto: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        em.close();
	        emf.close();
	    }
	}



	@Override
	public void eliminarProducto(Producto producto) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	     EntityManager em=emf.createEntityManager();	
	     
	     try 
	     {
	    	    em.getTransaction().begin();
	    		em.createNativeQuery("CALL ELIMINAR_PRODUCTO(:codigoProd)")
			    .setParameter("codigoProd", producto.getCodigoProd())
			    .executeUpdate();

			    em.getTransaction().commit();
	    	    
		} catch (Exception e) {
		
			   if(em.getTransaction().isActive())
			   {
				   em.getTransaction().rollback();
			   
			   } e.printStackTrace();
		}finally {

			em.close();
		    
			emf.close();
			}		
	}

	@Override
	public List<Producto> listarProducto() {
		EntityManagerFactory emf=Persistence.createEntityManagerFactory("MantenimientoTienda");
		EntityManager em=emf.createEntityManager();
		List<Producto>listado=null;
		
		try 
		{
			em.getTransaction().begin();
			listado = em.createQuery("SELECT p FROM Producto p", Producto.class).getResultList();
			em.getTransaction().commit();

		
		} catch (RuntimeException e) {
		    e.printStackTrace(); 
		

		}finally{em.close();}
		
		return listado;

	}

	@Override
	public Producto obtenerporID(int id) {
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	   
	    Producto producto=null;
	    
	    try 
	    { producto=em.find(Producto.class, id );
			
		} catch (Exception e) {
            e.printStackTrace();
		}finally {
            em.close();
            emf.close();
        }
		
		return producto;
	}

	
	public Proveedore obtenerProveedorPorID(int proveedorid) {
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    Proveedore proveedor = null;

	    try {
	        proveedor = em.find(Proveedore.class, proveedorid);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        em.close(); 
	    }

	    return proveedor;
	}

	public Optional<Producto> buscarProductoporID(Integer codigoProd) { // Cambiar a Integer
	    // Crear una instancia del EntityManagerFactory una sola vez
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    Optional<Producto> producto = Optional.empty();

	    try {
	        // Crear la consulta
	        TypedQuery<Producto> query = em.createQuery("SELECT p FROM Producto p WHERE p.codigoProd = :codigoProd", Producto.class);
	        query.setParameter("codigoProd", codigoProd); // Pasar el Integer directamente

	        // Obtener el resultado
	        producto = Optional.of(query.getSingleResult());
	    } catch (NoResultException e) {
	        // Manejar el caso donde no se encuentra el producto
	        System.out.println("No se encontr� el producto con el c�digo: " + codigoProd);
	    } catch (Exception e) {
	        // Manejo de otras excepciones
	        e.printStackTrace();
	    } finally {
	        // Cerrar el EntityManager
	        em.close();
	    }

	    return producto; // Retornar un Optional
	}


}
	
	
	

