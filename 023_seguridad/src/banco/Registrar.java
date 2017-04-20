package banco;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Registrar
 */
@WebServlet({ "/Registrar", "/registrar.php", "/registrar.html" })
public class Registrar extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	String classurl;
	String sqlurl;
	String sqluser;
	String sqlpwd;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registrar() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// Recupero los valores de los campos: nombre, dni y dirección del formulario para crear un cliente.
		
		String email = request.getParameter("email");
		String nombre = request.getParameter("nombre");
		String dni = request.getParameter("dni");
		String direccion = request.getParameter("direccion");
		
		
		String salt = (String)request.getAttribute("salt");
		String pwd = (String)request.getAttribute("pwd");
		
		HttpSession sesion = request.getSession();
		
		this.classurl = (String)sesion.getAttribute("classurl"); //$NON-NLS-1$
		this.sqlurl = (String)sesion.getAttribute("sqlurl"); //$NON-NLS-1$
		this.sqluser = (String)sesion.getAttribute("sqluser"); //$NON-NLS-1$
		this.sqlpwd = (String)sesion.getAttribute("sqlpwd"); //$NON-NLS-1$
			
		Connection con = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		
		try{

			Class.forName(classurl);
			con = DriverManager.getConnection(sqlurl, sqluser, sqlpwd);
			cs = con.prepareCall("{call cliente_id_email(?)}");
			cs.setString(1, email);
			rs = cs.executeQuery();
			boolean next = rs.next();
			cs.close();
			
			if(next){
				
				System.out.println("El registro ya existe.");
				response.sendRedirect(request.getContextPath().concat("/login.jsp"));
				
			}else{
				
				cs = con.prepareCall("{call nuevo_cliente(?,?,?,?,?,?)}");
				
				cs.setString(2, email);
				cs.setString(5, pwd);
				cs.setString(6, salt);
				
				// Añado a la consulta los campos que faltan para que quede el registro completo en la tabla "clientes".
				
				cs.setString(1, nombre);
				cs.setString(3, dni);
				cs.setString(4, direccion);
				
				rs = cs.executeQuery();
				
				cs = con.prepareCall("call cliente_id_email(?)");
				
				cs.setString(1, email);
				rs = cs.executeQuery();
				rs.next();
				int cliente_id = rs.getInt(1);
				
				// Voy a utilizar estas sesiones en "Privado.java" para conocer el resto de los datos del registro en la tabla "clientes"
				// del cliente que inicia sesión.
				
				sesion.setAttribute("cliente_id", cliente_id);
				sesion.setAttribute("email", email);
				sesion.setAttribute("nombre", nombre);
				sesion.setAttribute("allowed", true);
				
				
				// Redirección al método "post" de "Privado.java".

				response.sendRedirect(request.getContextPath().concat("/jsp/privado/indexlogged.jsp"));
			}		
		
		}catch(SQLException e){
			
			e.printStackTrace();
		
		}catch(ClassNotFoundException e){
			
			e.printStackTrace();
		
		}
		
		finally{
			
			try{
				
				cs.close();
				con.close();
				
			}catch(Exception e){
			
			}
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
