package gonzalo.conexion;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Transferencias
 */
@WebServlet("/Transferencias")
public class Transferencias extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String classurl;
	String sqlurl;
	String sqluser;
	String sqlpwd;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Transferencias() {
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
		System.out.println("Estoy en post de transferencia");
		HttpSession sesion = request.getSession();
		
		this.classurl = (String)request.getAttribute("classurl"); //$NON-NLS-1$
		this.sqlurl = (String)request.getAttribute("sqlurl"); //$NON-NLS-1$
		this.sqluser = (String)request.getAttribute("sqluser"); //$NON-NLS-1$
		this.sqlpwd = (String)request.getAttribute("sqlpwd"); //$NON-NLS-1$
		
		// Recupero los datos del formulario.
		
		String receptor = request.getParameter("receptor");
		String cantidad = request.getParameter("cantidad");
		String concepto = request.getParameter("concepto");
		
		System.out.println("Recupero datos de transferencia: " + receptor + cantidad + concepto);
		// Intento conectarme a la base de datos.
		
		
		Connection conexion = null;
		CallableStatement cs = null;
		Statement st = null;
		ResultSet rs = null;
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
			cs = conexion.prepareCall("{call transacción(?,?,?,?,?,?,?)}");
			cs.setInt(1, 1); //mi id, soy quien hago transferencia
			
			//ME DA FALLO. saco id del cliente receptor del dinero a partir de su nombre en variable receptor
			st = conexion.createStatement();
			rs = st.executeQuery("SELECT cliente_id FROM clientes where nombre='"+receptor+"'");
			System.out.println(rs.getInt(1));
			cs.setInt(2, rs.getInt(1)); //id de a quien transfiero
			
			cs.setInt(3, 1); //mi id de cuenta con la que transfiero
			cs.setInt(4, 2); //cuenta del otro al que transfiero
			Date fecha=new Date();
			cs.setString(5, fecha.toString()); //fecha de transferencia
			cs.setString(6, concepto); //concepto
			cs.setString(7, cantidad); //cantidad que quiero transferir
			cs.executeQuery();
		}catch(SQLException e){
	
			e.printStackTrace();
			
		}catch(ClassNotFoundException e){
			
			e.printStackTrace();
		
		}

		finally{
			
			try{
				rs.close();
				cs.close();
				conexion.close();
			
			}catch(Exception e){
				
				e.printStackTrace();
			}
		
		}
		
		}


}






