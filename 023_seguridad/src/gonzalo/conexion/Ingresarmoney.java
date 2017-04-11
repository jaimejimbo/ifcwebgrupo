package gonzalo.conexion;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Ingresarmoney
 */
@WebServlet("/Ingresarmoney")
public class Ingresarmoney extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Ingresarmoney() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		// Recupero los datos del formulario.

			String nombrecuenta = (String) request.getParameter("nombrecuenta");
			Float cantidad = Float.parseFloat(request.getParameter("cantidad"));
			
		// Recupero las sesiones que hay iniciadas.
			
			HttpSession sesion = request.getSession();
			
			String email = (String) sesion.getAttribute("email"); //$NON-NLS-1$
			String pwd = (String) sesion.getAttribute("pwd"); //$NON-NLS-1$
			Integer cliente_id = (Integer) sesion.getAttribute("cliente_id"); //$NON-NLS-1$
				
		// Intento conectarme a la base de datos.

			Connection conexion = null;
			Statement st1 = null; //Este lo uso para obtener el "cuenta_id" en la tabla "cuentas".
			Statement st2 = null; //Este lo uso para obtener el "cliente_id" en la tabla "posesiones" gracias a "cuenta_id".
			Statement st3 = null; //Este lo uso para ingresar el money.
			
			// Empiezo con la fiesta.
			
			try {

				Class.forName("com.mysql.jdbc.Driver");
				conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco", "root", "");
				
				// Voy a ver si existe la cuenta que se introduce y de paso me quedo con los fondos de dicha cuenta.
				
				st1 = conexion.createStatement();
				ResultSet rs1 = st1.executeQuery("SELECT cuenta_id,fondos FROM cuentas where nombre='"+nombrecuenta+"'");
				
				// Si existe la cuenta seguimos con la marcha.
				
				if(rs1.next()){
					 
					// Recupero "cuenta_id" y "fondos".
					
					int cuenta_id=rs1.getInt(0);
					float fondos=rs1.getFloat(1);
					
					// Busco el "cliente_id" en la tabla "posesiones" para ver si la cuenta es de ese cliente.
					
					st2 = conexion.createStatement();
					ResultSet rs2 = st2.executeQuery("SELECT cliente_id FROM posesiones where cuenta_id='"+cuenta_id+"'");
					
					int cliente_id_posesiones=rs2.getInt(0);
					
					// Compruebo si coinciden.
					
					if(cliente_id_posesiones==cliente_id){ // "cliente_id" es la sesión.
						
						// Ya se que la cuenta es de ese cliente, toca ingresar.
						
						st3 = conexion.createStatement();
						st3.executeUpdate("UPDATE cuentas SET fondos='"+fondos+"'+'"+cantidad+"' where nombre='"+nombrecuenta+"'");
						
					}
					
				}
			
			} catch (SQLException e) {

				e.printStackTrace();

			} catch (ClassNotFoundException e) {

				e.printStackTrace();

			}

			finally {

				try {

					if (st1 != null)
						st1.close();
					if (st2 != null)
						st2.close();
					if (st3 != null)
						st3.close();
					conexion.close();

				} catch (Exception e) {

					e.printStackTrace();
				}
				
				// Aqui rediriges a donde quieras
				response.sendRedirect(request.getContextPath().concat("/jsp/privado/indexlogged.jsp"));
			}

		}
				
			
			

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
