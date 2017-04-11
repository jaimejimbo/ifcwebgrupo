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

import com.mysql.jdbc.ResultSetMetaData;


/**
 * Servlet implementation class Login
 */
@WebServlet({ "/Login", "/login.php", "/login.html" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection con;
	private CallableStatement cs;
	String classurl;
	String sqlurl;
	String sqluser;
	String sqlpwd;
       
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
		this.classurl = (String)sesion.getAttribute("classurl"); //$NON-NLS-1$
		this.sqlurl = (String)sesion.getAttribute("sqlurl"); //$NON-NLS-1$
		this.sqluser = (String)sesion.getAttribute("sqluser"); //$NON-NLS-1$
		this.sqlpwd = (String)sesion.getAttribute("sqlpwd"); //$NON-NLS-1$
		
		String email = request.getParameter("email"); //$NON-NLS-1$
		String pwd = (String)request.getAttribute("pwd"); //$NON-NLS-1$
		try{

			Class.forName(classurl);
			con = DriverManager.getConnection(sqlurl, sqluser, sqlpwd);
			ResultSet rs;
			cs = con.prepareCall("call login(?,?)"); //$NON-NLS-1$
			cs.setString(1, email);
			cs.setString(2, pwd);
			rs = cs.executeQuery();
			int coinc = -1;
			try{
				if(rs.next()){
					coinc=1;
				} else {
					coinc=0;
				}
			}catch(SQLException ex){
				ex.printStackTrace();
			}
			if(coinc==0){
				sesion.setAttribute("cliente_id", null); //$NON-NLS-1$
				response.sendRedirect("/banco/jsp/login.jsp");
			}else if(coinc==1){
				cs = con.prepareCall("call cliente_id_email(?)"); //$NON-NLS-1$
				cs.setString(1, email);
				rs = cs.executeQuery();
				rs.next();
				int cliente_id = rs.getInt(1);
				cs = con.prepareCall("call cliente_nombre_id(?)");
				cs.setInt(1, cliente_id);
				rs = cs.executeQuery();
				rs.next();
				String nombre = rs.getString(1);
				sesion.setAttribute("cliente_id", cliente_id); //$NON-NLS-1$
				sesion.setAttribute("email", email); //$NON-NLS-1$
				sesion.setAttribute("nombre", nombre);
				sesion.setAttribute("allowed", true);
				try{
					
					cs.close();
					con.close();
				
				}catch(Exception e){
					e.printStackTrace();
				}
				response.sendRedirect(request.getContextPath().concat("/jsp/privado/indexlogged.jsp"));
			}else{
				System.out.println("Error del coinc"); //$NON-NLS-1$
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
