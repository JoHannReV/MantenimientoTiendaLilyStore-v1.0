package daoImp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.ParameterMode;
import javax.persistence.Query;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.TypedQuery;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import interfaces.iCliente;
import model.Cliente;

public class clienteDao implements iCliente{

	@Override
	public void insertarCliente(Cliente cliente) {

		 EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	     EntityManager em=emf.createEntityManager();
	     
	     try 
	     {
		     em.getTransaction().begin();
	         StoredProcedureQuery query = em.createStoredProcedureQuery("INSERTARCLIENTE");
	        
	      // Registro de parámetros
	         query.registerStoredProcedureParameter("p_nombre_clie", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_apellido_clie", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_email_clie", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_numero_clie", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_tipo_documento", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_documento_clie", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_provincia_clie", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_distrito_clie", String.class, ParameterMode.IN);
	         query.registerStoredProcedureParameter("p_direccion_clie", String.class, ParameterMode.IN);

	         // Establecimiento de parámetros
	         query.setParameter("p_nombre_clie", cliente.getNombreClie());
	         query.setParameter("p_apellido_clie", cliente.getApellidoClie());
	         query.setParameter("p_email_clie", cliente.getEmailClie());
	         query.setParameter("p_numero_clie", cliente.getNumeroClie());
	         query.setParameter("p_tipo_documento", cliente.getTipoDocumento());
	         query.setParameter("p_documento_clie", cliente.getDocumentoClie());
	         query.setParameter("p_provincia_clie", cliente.getProvinciaClie());
	         query.setParameter("p_distrito_clie", cliente.getDistritoClie());
	         query.setParameter("p_direccion_clie", cliente.getDireccionClie());

	         
	         query.execute();
	         em.getTransaction().commit();

	     }
	     
	     catch (Exception e) 
	     {
	    	 if (em.getTransaction().isActive()){em.getTransaction().rollback();}
	    	 }
		
	}

	@Override
	public void actualizarCliente(Cliente cliente) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	
	try 
	{
        em.getTransaction().begin();
        StoredProcedureQuery query = em.createStoredProcedureQuery("MODIFICARCLIENTE");
        
        query.registerStoredProcedureParameter("p_codigo_clie", Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_nombre_clie", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_apellido_clie", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_email_clie", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_numero_clie", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_tipo_documento", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_documento_clie", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_provincia_clie", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_distrito_clie", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_direccion_clie", String.class, ParameterMode.IN);

		
        query.setParameter("p_codigo_clie", cliente.getCodigoClie());
        query.setParameter("p_nombre_clie", cliente.getNombreClie());
        query.setParameter("p_apellido_clie", cliente.getApellidoClie());
        query.setParameter("p_email_clie", cliente.getEmailClie());
        query.setParameter("p_numero_clie", cliente.getNumeroClie());
        query.setParameter("p_tipo_documento", cliente.getTipoDocumento());
        query.setParameter("p_documento_clie", cliente.getDocumentoClie());
        query.setParameter("p_provincia_clie", cliente.getProvinciaClie());
        query.setParameter("p_distrito_clie", cliente.getDistritoClie());
        query.setParameter("p_direccion_clie", cliente.getDireccionClie());
        
        
        query.execute();
        
        em.getTransaction().commit();


	} 
	catch (Exception e) 
	{
		if (em.getTransaction().isActive()) { em.getTransaction().rollback();} e.printStackTrace(); 
        }
	finally {
        em.close();
        emf.close();
    }
	
	}

	@Override
	public void eliminarCliente(Cliente cliente) {
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();

	    try {
	        em.getTransaction().begin();
	        em.createNativeQuery("CALL ELIMINARCLIENTE(:codigoClie)")
	          .setParameter("codigoClie", cliente.getCodigoClie()) 
	          .executeUpdate();
	        em.getTransaction().commit(); 
	    } catch (Exception e) {
	        e.printStackTrace();
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback(); 
	        }
	    } finally {
	        em.close();
	        emf.close();
	    }
	}

	@Override
	public List<Cliente> listarCliente() {
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    List<Cliente> listado = null;

	    try {
	        em.getTransaction().begin(); 
	        listado = em.createQuery("SELECT c FROM Cliente c", Cliente.class).getResultList();
	        em.getTransaction().commit(); 
	    } catch (Exception e) {
	        System.err.println("Error al listar clientes: " + e.getMessage());
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback(); 
	        }
	    } finally {
	        em.close(); 
	    }
	    return listado;
	}

	@Override
	public Cliente obtenerporID(int id) {
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    
	    Cliente cliente = null;
	    try 
	    {
		cliente=em.find(Cliente.class, id);	
		} catch (Exception e) {
            e.printStackTrace();
		}finally {
            em.close();
            emf.close();
        }
		return cliente;
	}

	@Override
	
	public Optional<Cliente> buscarClientePorDocumento(String documentoClie) {
	    // Crear una instancia del EntityManagerFactory una sola vez
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    Optional<Cliente> cliente = Optional.empty();

	    try {
	        // Crear la consulta
	        TypedQuery<Cliente> query = em.createQuery("SELECT c FROM Cliente c WHERE c.documentoClie = :documentoClie", Cliente.class);
	        query.setParameter("documentoClie", documentoClie);
	        
	        // Obtener el resultado
	        cliente = Optional.of(query.getSingleResult());
	    } catch (NoResultException e) {
	        // Manejar el caso donde no se encuentra el cliente
	        System.out.println("No se encontró el cliente con el documento: " + documentoClie);
	    } catch (Exception e) {
	        // Manejo de otras excepciones
	        e.printStackTrace();
	    } finally {
	        // Cerrar el EntityManager
	        em.close();
	    }
	    
	    return cliente; // Retornar un Optional
    }


}
