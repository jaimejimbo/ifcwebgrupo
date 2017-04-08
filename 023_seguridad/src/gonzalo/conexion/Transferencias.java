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

import com.mysql.jdbc.PreparedStatement;

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
		HttpSession sesion = request.getSession();
		
		this.classurl = (String)request.getAttribute("classurl"); //$NON-NLS-1$
		this.sqlurl = (String)request.getAttribute("sqlurl"); //$NON-NLS-1$
		this.sqluser = (String)request.getAttribute("sqluser"); //$NON-NLS-1$
		this.sqlpwd = (String)request.getAttribute("sqlpwd"); //$NON-NLS-1$
		
		// Recupero los datos del formulario.
		
		String receptor = request.getParameter("receptor");
		String cantidad = request.getParameter("cantidad");
		String concepto = request.getParameter("concepto");
		String id_cuenta = request.getParameter("cuenta");
		System.out.println("id_cuenta que recupero del transferir.jsp:" + id_cuenta);
				
		System.out.println("Recupero datos de transferencia: " + receptor + cantidad + concepto+ id_cuenta);
		// Intento conectarme a la base de datos.
		
		
		Connection conexion = null;
		CallableStatement cs = null;
		Statement st = null;
		ResultSet rs = null;
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
			
			System.out.println("llego aqui: " + receptor);
			
			//saco id del cliente receptor del dinero a partir de su nombre en variable receptor
			st = conexion.createStatement();
			rs = st.executeQuery("SELECT cliente_id FROM clientes WHERE nombre='"+receptor+"'");
			while (rs.next()){
			System.out.println("id a quien transfiero " + rs.getInt(1));
			
			//id de persona que transfiere, es decir, quien tiene iniciada sesion
			int cliente_id= Integer.parseInt(sesion.getAttribute("cliente_id").toString());
			System.out.println("id de cliente que transfiere, es decir, logueado: " +cliente_id);
			
			cs = conexion.prepareCall("{call transacción(?,?,?,?,?,?,?)}");
			cs.setInt(1, cliente_id); //mi id, soy quien hago transferencia
			cs.setInt(2, rs.getInt(1)); //id de a quien transfiero
			cs.setInt(3, Integer.parseInt(id_cuenta)); //mi id de cuenta con la que transfiero
			cs.setInt(4, 2); //cuenta del otro al que transfiero
			Date fecha=new Date();
			cs.setString(5, fecha.toString()); //fecha de transferencia
			cs.setString(6, concepto); //concepto
			cs.setString(7, cantidad); //cantidad que quiero transferir
			cs.executeQuery();
			}
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
			response.sendRedirect("/banco/jsp/privado/eliminarcuenta.jsp");
		
		}
		
		}


}






