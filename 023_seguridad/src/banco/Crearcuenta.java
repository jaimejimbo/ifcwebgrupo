package banco;

import java.io.IOException;
import java.sql.CallableStatement;
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
 * Servlet implementation class Crearcuenta
 */
@WebServlet("/Crearcuenta")
public class Crearcuenta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Crearcuenta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		
		// Recupero los datos del formulario.
		
		String nombrecuenta = (String)request.getParameter("nombrecuenta");
		String descripcion = (String)request.getParameter("descripcion");
		Float fondos = Float.parseFloat(request.getParameter("fondos"));
		
		// Recupero las sesiones que hay iniciadas. Aunque me vale con el id del usuario logeado.
		
		HttpSession sesion = request.getSession();
		
		String email = (String)sesion.getAttribute("email"); //$NON-NLS-1$
		String pwd = (String)sesion.getAttribute("pwd"); //$NON-NLS-1$
		Integer cliente_id = (Integer)sesion.getAttribute("cliente_id"); //$NON-NLS-1$
		System.out.println("cliente_id: "+cliente_id);
		
		// Intento conectarme a la base de datos.
		
		Connection conexion = null;
		CallableStatement cs1 = null;
		CallableStatement cs2 = null;
		CallableStatement cs3 = null;
				
		try{
					
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");

			// Utilizo el procedimiento creado "crear_cuenta" para crear la cuenta en la tabla "cuentas".
			
			cs1 = conexion.prepareCall("{call crear_cuenta(?,?,?)}");
			cs1.setString(1, descripcion);
			cs1.setFloat(2, fondos);
			cs1.setString(3, nombrecuenta);
			
			cs1.executeUpdate();
		
			// Ahora tengo que asociar la cuenta creada al id del usuario logeado.
			
			// Primero cojo el id de la cuenta creada en la tabla "cuentas" con el procedimiento "cuenta_id".
			
			cs2 = conexion.prepareCall("{call cuenta_id(?,?)}");
			cs2.setString(1, nombrecuenta);
			
			cs2.registerOutParameter(2, java.sql.Types.INTEGER);
			
			cs2.execute();
			
			System.out.println("cuenta_id: "+cs2.getInt(2));
			// Ahora debo recuperar el id de la cuenta creada, lo he buscado en internet (es el "registeOutParameter" que hay antes de ejcutar la consulta).
			
			Integer cuenta_id = cs2.getInt(2);
			
			
			// Por último asocio la cuenta con el procedimiento "asociar_cuenta" creado.
			
			cs3 = conexion.prepareCall("{call asociar_cuenta(?,?)}");
			
			cs3.setInt(1, cliente_id);
			cs3.setInt(2, cuenta_id);
			
			cs3.executeUpdate();
			
			response.sendRedirect("/023_seguridad/jsp/privado/indexlogged.jsp");
			
		}catch(SQLException e){
			
			e.printStackTrace();
			
		}catch(ClassNotFoundException e){
			
			e.printStackTrace();
		
		}

		
		finally{
			
			try{

				cs1.close();
				cs2.close();
				cs3.close();
				conexion.close();
			
			}catch(Exception e){
				
				e.printStackTrace();
			}
		
		}
		
		}

			
			
			

}
