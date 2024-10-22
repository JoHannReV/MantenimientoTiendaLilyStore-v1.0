package daoImp;


import java.math.BigDecimal;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.ParameterMode;
import javax.persistence.Query;

import interfaces.iEmpleado;
import model.Cargo;
import model.Empleado;
import model.EmpleadoDTO;
import model.Usuariosacceso;

import java.util.List;
import javax.persistence.StoredProcedureQuery;

import org.eclipse.persistence.internal.jpa.EntityManagerFactoryProvider;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence; 

public class empleadoDao implements iEmpleado{

	@Override
	public void insertarEmpleado(Empleado empleado) {

	     EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	     EntityManager em=emf.createEntityManager();
	     
	    

	     try{
	     em.getTransaction().begin();

         StoredProcedureQuery query = em.createStoredProcedureQuery("insertarEmpleado");

         query.registerStoredProcedureParameter("p_nombre_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_apellido_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_email_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_numero_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_tipo_documento", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_documento_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_provincia_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_distrito_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_direccion_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_sueldo_bruto_emp", Double.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_tipo_pension_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_tipo_seguro_emp", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_cargoID", Integer.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_username", String.class, ParameterMode.IN);
         query.registerStoredProcedureParameter("p_password", String.class, ParameterMode.IN);

         query.setParameter("p_nombre_emp", empleado.getNombreEmp());
         query.setParameter("p_apellido_emp", empleado.getApellidoEmp());
         query.setParameter("p_email_emp", empleado.getEmailEmp());
         query.setParameter("p_numero_emp", empleado.getNumeroEmp());
         query.setParameter("p_tipo_documento", empleado.getTipoDocumento());
         query.setParameter("p_documento_emp", empleado.getDocumentoEmp());
         query.setParameter("p_provincia_emp", empleado.getProvinciaEmp());
         query.setParameter("p_distrito_emp", empleado.getDistritoEmp());
         query.setParameter("p_direccion_emp", empleado.getDireccionEmp());
         query.setParameter("p_sueldo_bruto_emp", empleado.getSueldoBrutoEmp().doubleValue());
         query.setParameter("p_tipo_pension_emp", empleado.getTipoPensionEmp());
         query.setParameter("p_tipo_seguro_emp", empleado.getTipoSeguroEmp());
         query.setParameter("p_cargoID", empleado.getCargo().getCargoID());
         
         query.setParameter("p_username", empleado.getUsuariosacceso().getUsername());
         query.setParameter("p_password", empleado.getUsuariosacceso().getPassword());

         query.execute();

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
	     
	     
}
	     
	     

	@Override
	public void actualizarEmpleado(Empleado empleado) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    
	    try {
	        em.getTransaction().begin();
	        
	        // Crear la consulta para el procedimiento almacenado
	        StoredProcedureQuery query = em.createStoredProcedureQuery("editarEmpleado");

	        // Registrar los parámetros correctamente
	        query.registerStoredProcedureParameter("p_codigo_emp", Integer.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_nombre_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_apellido_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_email_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_numero_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_tipo_documento", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_documento_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_provincia_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_distrito_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_direccion_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_sueldo_bruto_emp", BigDecimal.class, ParameterMode.IN); // Cambiar a BigDecimal
	        query.registerStoredProcedureParameter("p_tipo_pension_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_tipo_seguro_emp", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_cargoID", Integer.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_username", String.class, ParameterMode.IN);
	        query.registerStoredProcedureParameter("p_password", String.class, ParameterMode.IN);

	        // Establecer los valores de los parámetros
	        query.setParameter("p_codigo_emp", empleado.getCodigoEmp());
	        query.setParameter("p_nombre_emp", empleado.getNombreEmp());
	        query.setParameter("p_apellido_emp", empleado.getApellidoEmp());
	        query.setParameter("p_email_emp", empleado.getEmailEmp());
	        query.setParameter("p_numero_emp", empleado.getNumeroEmp());
	        query.setParameter("p_tipo_documento", empleado.getTipoDocumento());
	        query.setParameter("p_documento_emp", empleado.getDocumentoEmp());
	        query.setParameter("p_provincia_emp", empleado.getProvinciaEmp());
	        query.setParameter("p_distrito_emp", empleado.getDistritoEmp());
	        query.setParameter("p_direccion_emp", empleado.getDireccionEmp());
	        query.setParameter("p_sueldo_bruto_emp", empleado.getSueldoBrutoEmp()); // Ya es BigDecimal
	        query.setParameter("p_tipo_pension_emp", empleado.getTipoPensionEmp());
	        query.setParameter("p_tipo_seguro_emp", empleado.getTipoSeguroEmp());
	        query.setParameter("p_cargoID", empleado.getCargo().getCargoID());
	        
	        // Obtener username y password del modelo UsuariosAcceso
	        query.setParameter("p_username", empleado.getUsuariosacceso().getUsername());
	        query.setParameter("p_password", empleado.getUsuariosacceso().getPassword());

	        // Ejecutar el procedimiento almacenado
	        query.execute();

	        em.getTransaction().commit();
	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback();
	        }
	        e.printStackTrace(); // Manejo de excepciones (puedes usar logging)
	    } finally {
	        em.close();
	        emf.close();
	    }
	     
	}

	@Override
	public void eliminarEmpleado(Empleado empleado) {

		EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	     EntityManager em=emf.createEntityManager();
	     
try 
   {
    em.getTransaction().begin();
	
	em.createNativeQuery("CALL eliminarEmpleado(:codigoEmp)")
    .setParameter("codigoEmp", empleado.getCodigoEmp())
    .executeUpdate();
	
    em.getTransaction().commit();

   } catch (Exception e)
       {
	   
	   if(em.getTransaction().isActive())
	   
	   {
		   em.getTransaction().rollback();
	   
	   } e.printStackTrace();
	
       }//fin del catch
finally {

	em.close();
    
	emf.close();
	}				

}

	@Override
	public Empleado obtenerporID(int id) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();		
		
	    Empleado empleado = null;
	  
	    try {
            // Buscar el empleado por su ID
            empleado = em.find(Empleado.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }

        return empleado;
    }
	    

	public Cargo obtenerCargoPorID(int cargoID) {
	    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");
	    EntityManager em = emf.createEntityManager();
	    Cargo cargo = null;
	    try {
	        cargo = em.find(Cargo.class, cargoID);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        em.close();
	        emf.close();
	    }
	    return cargo;
	}
	
	
@Override
public List<Empleado> ListarEmpleado() {
	EntityManagerFactory emf=Persistence.createEntityManagerFactory("MantenimientoTienda");
	EntityManager em=emf.createEntityManager();
	List<Empleado> listado=null;
	try{
		em.getTransaction().begin();
	    listado=em.createQuery("select p from Empleado p",Empleado.class).getResultList();
		em.getTransaction().commit();
		}catch(RuntimeException ex){
			ex.getMessage();
		}finally{
		em.close();
		}
		return listado;
	}






	



	
	
	
}
