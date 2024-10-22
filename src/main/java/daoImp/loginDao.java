package daoImp;

import interfaces.iUsuario;
import model.Empleado;
import model.EmpleadoDTO;
import model.Usuariosacceso;

import java.util.List;

import javax.persistence.*;


public class loginDao implements iUsuario{

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("MantenimientoTienda");

	public Usuariosacceso AccesoUsuario(String username, String password) {

        EntityManager em = emf.createEntityManager();
	
        try {
            Query query = em.createNativeQuery("CALL SP_ACCESO_ADMINISTRADOR(:login, :clave)", Usuariosacceso.class);
            query.setParameter("login", username);
            query.setParameter("clave", password);

            return (Usuariosacceso) query.getSingleResult();
            
        } catch (Exception e) {
        	System.out.println("Error al ejecutar el procedimient almacenado"+e.getMessage());
            return null;
            
        } finally {em.close();}

	
	
	}
	
	public EmpleadoDTO obtenerEmpleadoPorusuario(String username)
	{
		

		    EntityManager em = emf.createEntityManager();
		    EmpleadoDTO empleadoDTO = null;

		    try {
		        Query query = em.createNativeQuery("CALL ObtenerEmpleadoPorUsuario(:username)");
		        query.setParameter("username", username);
		        Object[] result = (Object[]) query.getSingleResult();
		        
		        // Crea un nuevo DTO con los resultados
		        empleadoDTO = new EmpleadoDTO((String) result[0], (String) result[1], (String) result[2]);
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        em.close(); // Asegúrate de cerrar el EntityManager
		    }
		    return empleadoDTO;


		
	}

	public void setEntityManagerFactory(EntityManagerFactory emf) {
	    this.emf = emf;
	}


}
