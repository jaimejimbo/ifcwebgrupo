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
	private String url = Messages.getString("sqlurl"); //$NON-NLS-1$
	private String user = Messages.getString("sqluser"); //$NON-NLS-1$
	private String sqlpwd = Messages.getString("sqlpwd"); //$NON-NLS-1$
	private String classurl = Messages.getString("classurl"); //$NON-NLS-1$
       
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
		String salt = (String)request.getAttribute("salt");
		String pwd = (String)request.getAttribute("pwd");
		HttpSession sesion = request.getSession();
			
		Connection con = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		
		try{

			Class.forName(classurl);
			con = DriverManager.getConnection(url, user, sqlpwd);
			cs = con.prepareCall("{call cliente_id_email(?)}");
			cs.setString(1, email);
			rs = cs.executeQuery();
			boolean next = rs.next();
			cs.close();
			
			if(next){
				System.out.println("El registro ya existe.");
			}else{
				cs = con.prepareCall("{call nuevo_cliente('',?,'','',?,?)}");
				cs.setString(1, email);
				cs.setString(2, pwd);
				cs.setString(3, salt);
				rs = cs.executeQuery();
				cs = con.prepareCall("call cliente_id_email(?)");
				cs.setString(1, email);
				rs = cs.executeQuery();
				int cliente_id = rs.getRow();
				sesion.setAttribute("cliente_id", cliente_id);
				sesion.setAttribute("email", email);
				cs.close();
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
