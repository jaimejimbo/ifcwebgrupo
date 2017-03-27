<<<<<<< HEAD
package gonzalo.conexion;

import java.util.concurrent.ThreadLocalRandom;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
 * Servlet implementation class Operaciones3
 */
@WebServlet("/Operaciones3")
public class Operaciones3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String classurl;
	String sqlurl;
	String sqluser;
	String sqlpwd;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Operaciones3() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession sesion = request.getSession();
		
		sesion.invalidate();
		
		response.sendRedirect("/023_seguridad/index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		
		// Me traigo los elementos necesarios para hacer la conexion a la base de datos.
		
		this.classurl = (String)request.getAttribute("classurl"); //$NON-NLS-1$
		this.sqlurl = (String)request.getAttribute("sqlurl"); //$NON-NLS-1$
		this.sqluser = (String)request.getAttribute("sqluser"); //$NON-NLS-1$
		this.sqlpwd = (String)request.getAttribute("sqlpwd"); //$NON-NLS-1$
		
		HttpSession sesion = request.getSession();

		// Me traigo los valores de la sesion iniciada.
		
		Integer cliente_id = (Integer) sesion.getAttribute("cliente_id"); //$NON-NLS-1$
		System.out.println(cliente_id);
		String email = (String) sesion.getAttribute("email"); //$NON-NLS-1$
		System.out.println(cliente_id);
		
		// Me traigo los valores del formulario.
		
		String otronombre = request.getParameter("otronombre").toString();
		System.out.println(otronombre);
		Float transferencia = Float.parseFloat(request.getParameter("transferencia"));
		System.out.println(transferencia);
		
		// Establecemos la conexion con la base de datos.
		
		Connection con = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		ResultSet rst = null;
		
		try{
			
			Class.forName(classurl);
			con = DriverManager.getConnection(sqlurl, sqluser, sqlpwd);
			
			// Buscamos el nombre del usuario logeado.
			
			cs = con.prepareCall("{call cliente_nombre_id(?)}");
			cs.setInt(1,cliente_id);
			rs = cs.executeQuery();
			String nombre_usuario = rs.getString(1);
			System.out.println(nombre_usuario);
			
			// Buscamos la cantidad de dinero disponible en la cuenta del usuario logeado.
			
			cs = con.prepareCall("{call fondos_nombre_cuenta(?)}");
			cs.setString(1, nombre_usuario);
			rs = cs.executeQuery();
			Float cantidad = rs.getFloat(1);
			System.out.println(cantidad);
			
			
			
			// Buscamos el id del cliente de la otra cuenta con el nombre del formulario.
			
			cs = con.prepareCall("{call cliente_id_enombre(?)}");
			cs.setString(1, otronombre);
			rst = cs.executeQuery();
			Integer otrocliente_id = rst.getInt(1);
			System.out.println(otrocliente_id);
			
			// Si existe el otro cliente y la cantidad es mayor que la transferencia realizamso la transacción.
			
			if(rst.next() && cantidad>=transferencia){

				cs = con.prepareCall("{call transacción(?,?,?,?,?,?,?)}");
				cs.setInt(1, cliente_id);
				cs.setInt(2, otrocliente_id);
				
				// AQUÍ ESTÁ EL PROBLEMA: SACAR DE LA TABLA CUENTAS LA COLUMNA cuenta_id suponiendo que un usario tenga
				// varias cuentas, cosa que tampoco he visto en ningun porcedimiento para hacerlo.
				
				
				
					
				cs.executeUpdate();
			} 
			
			response.sendRedirect("/023_seguridad/cuenta.jsp");
			
		}catch(SQLException e){
			
			e.printStackTrace();
		
		}catch(ClassNotFoundException e){
			
			e.printStackTrace();
		
		}
		
		finally{
			
			try{
				if(cs!=null) cs.close();
				con.close();
			
			}catch(Exception e){
				
				e.printStackTrace();
			}
		
		}
	}


	

}
=======
package gonzalo.conexion;

import java.util.concurrent.ThreadLocalRandom;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
 * Servlet implementation class Operaciones3
 */
@WebServlet("/Operaciones3")
public class Operaciones3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String classurl;
	String sqlurl;
	String sqluser;
	String sqlpwd;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Operaciones3() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession sesion = request.getSession();
		
		sesion.invalidate();
		
		response.sendRedirect("/023_seguridad/index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		
		// Me traigo los elementos necesarios para hacer la conexion a la base de datos.
		
		this.classurl = (String)request.getAttribute("classurl"); //$NON-NLS-1$
		this.sqlurl = (String)request.getAttribute("sqlurl"); //$NON-NLS-1$
		this.sqluser = (String)request.getAttribute("sqluser"); //$NON-NLS-1$
		this.sqlpwd = (String)request.getAttribute("sqlpwd"); //$NON-NLS-1$
		
		HttpSession sesion = request.getSession();

		// Me traigo los valores de la sesion iniciada.
		
		Integer cliente_id = (Integer) sesion.getAttribute("cliente_id"); //$NON-NLS-1$
		System.out.println(cliente_id);
		String email = (String) sesion.getAttribute("email"); //$NON-NLS-1$
		System.out.println(cliente_id);
		
		// Me traigo los valores del formulario.
		
		String otronombre = request.getParameter("otronombre").toString();
		System.out.println(otronombre);
		Float transferencia = Float.parseFloat(request.getParameter("transferencia"));
		System.out.println(transferencia);
		
		// Establecemos la conexion con la base de datos.
		
		Connection con = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		ResultSet rst = null;
		
		try{
			
			Class.forName(classurl);
			con = DriverManager.getConnection(sqlurl, sqluser, sqlpwd);
			
			// Buscamos el nombre del usuario logeado.
			
			cs = con.prepareCall("{call cliente_nombre_id(?)}");
			cs.setInt(1,cliente_id);
			rs = cs.executeQuery();
			String nombre_usuario = rs.getString(1);
			System.out.println(nombre_usuario);
			
			// Buscamos la cantidad de dinero disponible en la cuenta del usuario logeado.
			
			cs = con.prepareCall("{call fondos_nombre_cuenta(?)}");
			cs.setString(1, nombre_usuario);
			rs = cs.executeQuery();
			Float cantidad = rs.getFloat(1);
			System.out.println(cantidad);
			
			
			
			// Buscamos el id del cliente de la otra cuenta con el nombre del formulario.
			
			cs = con.prepareCall("{call cliente_id_enombre(?)}");
			cs.setString(1, otronombre);
			rst = cs.executeQuery();
			Integer otrocliente_id = rst.getInt(1);
			System.out.println(otrocliente_id);
			
			// Si existe el otro cliente y la cantidad es mayor que la transferencia realizamso la transacción.
			
			if(rst.next() && cantidad>=transferencia){

				cs = con.prepareCall("{call transacción(?,?,?,?,?,?,?)}");
				cs.setInt(1, cliente_id);
				cs.setInt(2, otrocliente_id);
				
				// AQUÍ ESTÁ EL PROBLEMA: SACAR DE LA TABLA CUENTAS LA COLUMNA cuenta_id suponiendo que un usario tenga
				// varias cuentas, cosa que tampoco he visto en ningun porcedimiento para hacerlo.
				
				
				
					
				cs.executeUpdate();
			} 
			
			response.sendRedirect("/023_seguridad/cuenta.jsp");
			
		}catch(SQLException e){
			
			e.printStackTrace();
		
		}catch(ClassNotFoundException e){
			
			e.printStackTrace();
		
		}
		
		finally{
			
			try{
				if(cs!=null) cs.close();
				con.close();
			
			}catch(Exception e){
				
				e.printStackTrace();
			}
		
		}
	}


	

}
>>>>>>> a9026bc770d35963e8875bf759ffe4ee36bf066f
