package controlador;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import daoImp.loginDao;
import model.EmpleadoDTO;
import model.Usuariosacceso;

public class controladorUsuario extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private loginDao usuarioDao;

    public controladorUsuario() {
        super();
        usuarioDao = new loginDao(); 
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("Salir".equals(accion)) {
            HttpSession session = request.getSession(false); 
            if (session != null) {
                session.invalidate(); 
            }

            response.sendRedirect("LoginSupp.jsp"); 
            return; 
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("txtUsuario");
        String clave = request.getParameter("txtPassword");

        if (usuario == null || usuario.trim().isEmpty() || clave == null || clave.trim().isEmpty()) {
            response.sendRedirect("loginSupp.jsp?error=empty");
            return; }
        Usuariosacceso usuarioAcceso = usuarioDao.AccesoUsuario(usuario, clave);

        if (usuarioAcceso != null) {
            EmpleadoDTO empleadoDTO = usuarioDao.obtenerEmpleadoPorusuario(usuario); 

            HttpSession session = request.getSession(); 
            session.setAttribute("empleadoDTO", empleadoDTO); 
            RequestDispatcher dispatcher = request.getRequestDispatcher("Menu.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("loginSupp.jsp?error=incorrect");
        }
    }
}
