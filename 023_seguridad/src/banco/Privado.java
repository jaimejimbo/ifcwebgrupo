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
 * Servlet implementation class Privado
 */
@WebServlet("/Privado")
public class Privado extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	String classurl;
	String sqlurl;
	String sqluser;
	String sqlpwd;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Privado() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		// response.getWriter().append("P�gina banco privada ").append(request.getContextPath());
		
		// Voy a buscar el nombre del cliente que se ha logeado.
		// Esto es pura cortes�a, cuando uno se mete en su cuenta del banco sale tu nombre.
		
		
		HttpSession sesion = request.getSession();
		
		/*this.classurl = (String)request.getAttribute("classurl"); //$NON-NLS-1$
		System.out.println(classurl);
		this.sqlurl = (String)request.getAttribute("sqlurl"); //$NON-NLS-1$
		System.out.println(sqlurl);
		this.sqluser = (String)request.getAttribute("sqluser"); //$NON-NLS-1$
		System.out.println(sqluser);
		this.sqlpwd = (String)request.getAttribute("sqlpwd"); //$NON-NLS-1$
		System.out.println(sqlpwd);*/
		
		// He visto que hay un procedimiento ya creado para obtener el nombre a partir del id.
		
		Integer cliente_id = (Integer) sesion.getAttribute("cliente_id");
		System.out.println(cliente_id);
		
		
		Connection con = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		
		try{

			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/banco", "root", "");
			
			// Utilizo el procedimiento ya creado para obtener el nombre del cliente logeado.
			
			cs = con.prepareCall("{call cliente_nombre_id(?)}");
			
			cs.setInt(1, cliente_id);
			
			rs = cs.executeQuery();
		
			if(rs.next()){
				
				sesion.setAttribute("nombre", rs.getString(1));
				String nombre = (String) request.getAttribute("nombre");
				System.out.println(nombre);

			// Redirecci�n a "cuenta.jsp" donde crear� el men� para acceder a las distintas operaciones que puede hacer el cliente logeado.
	
			response.sendRedirect("/banco/jsp/privado/cuenta.jsp");
		
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
