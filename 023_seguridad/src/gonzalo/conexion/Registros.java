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
 * Servlet implementation class Registros
 */
@WebServlet("/Registros")
public class Registros extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String classurl;
	String sqlurl;
	String sqluser;
	String sqlpwd;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registros() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		HttpSession sesion = request.getSession();
		
		// Voy a terminar de completar la tabla "clientes", puesto que solo habíamos introducido el email y la contraseña.
		
		this.classurl = (String)request.getAttribute("classurl"); //$NON-NLS-1$
		this.sqlurl = (String)request.getAttribute("sqlurl"); //$NON-NLS-1$
		this.sqluser = (String)request.getAttribute("sqluser"); //$NON-NLS-1$
		this.sqlpwd = (String)request.getAttribute("sqlpwd"); //$NON-NLS-1$
		
		// Con el email ya sé donde tengo que introducir los datos que me faltan. 
		
		String email = (String) sesion.getAttribute("email"); //$NON-NLS-1$
		System.out.println(email);
		
		// Recupero los datos del formulario.
		
		String nombre = request.getParameter("nombre");
		String dni = request.getParameter("dni");
		String direccion = request.getParameter("direccion");
		
		// Intento conectarme a la base de datos.
		
		Connection conexion = null;
		Statement st = null;
		ResultSet rs = null;
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
			st = conexion.createStatement();
			rs = st.executeQuery("SELECT * FROM clientes where email='"+email+"'");
			
			// Necesito comprobar que los valores de las columnas "nombre", "dirección" y "dni" son 
			// 0, de lo contrario ya he introducido los datos en otra ocasión y no es necesario hacerlo de nuevo.
			
			if(rs.next()){
					String nombredelatabla = rs.getString(2);
					String dnidelatabla = rs.getString(4);
					String direcciondelatabla = rs.getString(5);
					System.out.println(nombredelatabla);
					System.out.println(dnidelatabla);
					System.out.println(direcciondelatabla);
				
				// Si los dichos valores son iguales a 0 puedo modificar el registro.
				
				if(nombredelatabla.equals("0") && dnidelatabla.equals("0") && direcciondelatabla.equals("0")){
					
					st.executeUpdate("UPDATE clientes SET nombre='"+nombre+"',DNI='"+dni+"',dirección='"+direccion+"' where email='"+email+"'");
					
					// Me he creado una variable sesion con el nombre introducido para mostrarlo en "cuentas.jsp".
					
					rs = st.executeQuery("SELECT nombre FROM clientes where email='"+email+"'");
					
					if(rs.next()){
						sesion.setAttribute("usuario",rs.getString(1));
					}	
					
					// Independientemente de que hagamos la consulta tenemos que redireccionar a "cuenta.jsp".
					
					response.sendRedirect("/023_seguridad/cuenta.jsp");
					
				}else{
					
					System.out.println("El registro fue completado con anterioridad.");
					
					response.sendRedirect("/023_seguridad/cuenta.jsp");
				}
			}
		
		}catch(SQLException e){
			
			e.printStackTrace();
		
		}catch(ClassNotFoundException e){
			
			e.printStackTrace();
		
		}
		
		finally{
			
			try{
				
				st.close();
				conexion.close();
			
			}catch(Exception e){
				
				e.printStackTrace();
			}
		
		}
		
	}

}
