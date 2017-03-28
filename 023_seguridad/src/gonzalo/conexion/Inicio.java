package gonzalo.conexion;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Inicio
 */
@WebServlet("/Inicio")
public class Inicio extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Inicio() {
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
		// TODO Auto-generated method stub
		// doGet(request, response);
		
		HttpSession sesion = request.getSession();
		
		String nombre = request.getParameter("nombre");
		System.out.println(nombre);
		String contraseña = request.getParameter("contraseña");
		System.out.println(contraseña);
		
		// Buscamos al usuario en la base de datos.
		
		Connection conexion = null;
		Statement st = null;
		ResultSet rs = null;
		Integer encontrado = 0;
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
			st = conexion.createStatement();
			rs = st.executeQuery("SELECT * FROM usuarios where nombre='"+nombre+"' and contraseña ='"+contraseña+"'");
			
			while(rs.next()){
				encontrado++;
			}
			
			if(encontrado == 1){
				System.out.println("El usuario existe. Se inicia sesion.");
				
				sesion.setAttribute("nombre",nombre);
				sesion.setAttribute("contraseña",contraseña);
				
			
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
					
					st.close();
					conexion.close();
				
				}catch(Exception e){
					
					e.printStackTrace();
				}
			
			}
		
	}

}
