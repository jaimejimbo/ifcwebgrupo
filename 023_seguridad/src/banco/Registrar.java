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
import javax.websocket.Session;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Servlet implementation class Registrar
 */
@WebServlet({ "/Registrar", "/registrar.php", "/registrar.html" })
public class Registrar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		String email = request.getParameter("email");
		String salt = BCrypt.gensalt(16);
		String pwd = BCrypt.hashpw(request.getParameter("pwd"), salt);
		HttpSession sesion = request.getSession();
		sesion.setAttribute("email", email);
			
		Connection conexion = null;
		CallableStatement cs = null;
		CallableStatement cst = null;
		ResultSet rs = null;
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
			cs = conexion.prepareCall("{call cliente_id_email(?)}");
			cs.setString(1, email);
			rs = cs.executeQuery();
			
			if(rs.next()){
				System.out.println("El registro ya existe.");
			}else{
				cst = conexion.prepareCall("{call nuevo_cliente(0,?,0,0,?,?)}");
				cst.setString(1, email);
				cst.setString(2, pwd);
				cst.setString(3, salt);
				rs = cst.executeQuery();
				System.out.println("Se ha creado un nuevo usuario.");
			}		
		
		}catch(SQLException e){
			
			e.printStackTrace();
		
		}catch(ClassNotFoundException e){
			
			e.printStackTrace();
		
		}
		
		finally{
			
			try{
				cst.close();
				cs.close();
				conexion.close();
			
			}catch(Exception e){
				
				e.printStackTrace();
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
