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

/**
 * Servlet implementation class Registro
 */
@WebServlet("/Registro")
public class Registro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registro() {
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
		
		String nombre = request.getParameter("nombre");
		System.out.println(nombre);
		String contraseņa1 = request.getParameter("contraseņa1");
		System.out.println(contraseņa1);
		String contraseņa2 = request.getParameter("contraseņa2");
		System.out.println(contraseņa2);
		
		if(contraseņa1.equals(contraseņa2)){
			
			System.out.println("Ambas contraseņas coinciden.");
			
			Connection conexion = null;
			Statement st = null;
			ResultSet rs = null;
			Integer encontrado = 0;
			
			try{
				
				Class.forName("com.mysql.jdbc.Driver");
				conexion = DriverManager.getConnection("jdbc:mysql://localhost/bancoonline","root","");
				st = conexion.createStatement();
				rs = st.executeQuery("SELECT * FROM usuarios where nombre='"+nombre+"' and contraseņa ='"+contraseņa1+"'");
				
				while(rs.next()){
					encontrado++;
				}
				
				if(encontrado == 1){
					System.out.println("El registro ya existe.");
				}else{
					st.executeUpdate("INSERT INTO usuarios (nombre, contraseņa) values('"+nombre+"', '"+contraseņa1+"')");
					System.out.println("Se ha creado un nuevo usuario.");
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
			
		}else{
			
			System.out.println("Las contraseņas no coinciden.");
			
		}
	}
}
