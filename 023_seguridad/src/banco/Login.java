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
	private String url = Messages.getString("sqlurl"); //$NON-NLS-1$
	private String user = Messages.getString("sqluser"); //$NON-NLS-1$
	private String sqlpwd = Messages.getString("sqlpwd"); //$NON-NLS-1$
       
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
		
		String email = request.getParameter("email"); //$NON-NLS-1$
		String pwd = (String)request.getAttribute("pwd"); //$NON-NLS-1$

		try{

			Class.forName("com.mysql.jdbc.Driver"); //$NON-NLS-1$
			con = DriverManager.getConnection(url, user, sqlpwd);
			ResultSet rs;
			cs = con.prepareCall("call login(?,?)"); //$NON-NLS-1$
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
				sesion.setAttribute("cliente_id", -1); //$NON-NLS-1$
			}else if(coinc==1){
				cs = con.prepareCall("call cliente_id_email(?)"); //$NON-NLS-1$
				rs = cs.executeQuery();
				int cliente_id = rs.getRow();
				sesion.setAttribute("cliente_id", cliente_id); //$NON-NLS-1$
				sesion.setAttribute("email", email); //$NON-NLS-1$
			}else{
				System.out.println("Error"); //$NON-NLS-1$
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
