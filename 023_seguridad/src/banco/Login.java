package banco;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Login
 */
@WebServlet({ "/Login", "/login.php", "/login.html" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection con;
	private java.sql.PreparedStatement pstmt;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession sesion = request.getSession();
		
		String email = request.getParameter("email");
		String pwd = (String)request.getAttribute("pwd");
		HttpSession session = request.getSession();
		System.out.println(pwd);
		
		Connection conexion = null;
		CallableStatement cs = null;
		ResultSet rs = null;

		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
			cs = conexion.prepareCall("{call login(?,?)}");
			cs.setString(1, email);
			cs.setString(2, pwd);
			rs = cs.executeQuery();
			System.out.println(pwd);
			if(rs.getInt(1)>0){
				System.out.println("El usuario existe. Se inicia sesion.");
			}else{
				System.out.println("El usuario no existe.");
			}		
			
			}catch(SQLException e){
				
				e.printStackTrace();
			
			}catch(ClassNotFoundException e){
				
				e.printStackTrace();
			
			}
			
			finally{
				
				try{
					
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
