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
 * Servlet implementation class Login
 */
@WebServlet({ "/Login", "/login.php", "/login.html" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection con;
	private CallableStatement cs;
       
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
		System.out.println(pwd);

		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
			ResultSet rs;
			cs = con.prepareCall("{call login(?,?)}");
			cs.setString(1, email);
			cs.setString(2, pwd);
			rs = cs.executeQuery();
			int coinc = -1;
			try{
				coinc = rs.getRow();
			}catch(SQLException ex){
				ex.printStackTrace();
			}
			if(coinc==0){
				System.out.println("El usuario no existe.");
			}else if(coinc==1){
				System.out.println("El usuario existe. Se inicia sesion.");
			}else{
				System.out.println("Error");
			}
			
		}catch(SQLException e){
				
			e.printStackTrace();
			
		}catch(ClassNotFoundException e){
				
			e.printStackTrace();
			
		}finally{
				
			try{
				
				cs.close();
				con.close();
			
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
