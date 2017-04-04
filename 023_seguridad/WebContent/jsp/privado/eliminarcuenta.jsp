<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div style="text-align:center">
		<h2>¡Bienvenido a su banco online!</h2>
		<h3>Indique las cuentas que desea eliminar:</h3>
		<%
		
			// Recupero las sesiones que hay iniciadas. Aunque me vale con el id del usuario logeado.
			
			HttpSession sesion = request.getSession();
			
			String email = (String)sesion.getAttribute("email"); //$NON-NLS-1$
			String pwd = (String)sesion.getAttribute("pwd"); //$NON-NLS-1$
			Integer cliente_id = (Integer)sesion.getAttribute("cliente_id"); //$NON-NLS-1$
			
			// Compruebo que me traigo bien el "cliente_id".
			
			System.out.println("cliente_id: "+cliente_id);
		
			// Me conecto a la base de datos.
			
			Connection conexion = null;
			CallableStatement cs1 = null;
			CallableStatement cs2 = null;
			
			try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/banco";
				conexion = DriverManager.getConnection(url,"root","");
				
				// Lo primer que quiero hacer es mostrar las cuentas del cliente logueado.
				// No existe un procedimiento para seleccionar las "cuenta_id" del "cliente_id" en la "tabla posesiones".
				// He creado un procedimiento con ese fin ("seleccionar_cuenta_id").
				
				cs1 = conexion.prepareCall("{call seleccionar_cuenta_id(?)}");
				cs1.setInt(1,cliente_id);
				ResultSet rs= cs1.executeQuery();
				
				// Pido que me muestre en la consola esos ids para ver si selecciona bien.
				
				//while(rs.next()){
					//System.out.println("cuenta_id: "+rs.getInt(1));
				//}
				
				// Pido que me muestre en la pantalla las cuentas de esos ids.
				
				out.print("<CENTER><table><tr><td>descripcion</td><td>fondos</td><td>nombre</td><td>seleccionar</td></tr>");
				
				while(rs.next()){
					
					// Creo otro procedimiento que busca el registro en "cuentas" que tiene cada "cuenta_id".
					// Lo he llamado "seleccionar_cuentas".
					
					cs2 = conexion.prepareCall("{call seleccionar_cuentas(?)}");
					
					// Envio el "Resulset" anterior al nuevo procedimiento.
					
					cs2.setInt(1,rs.getInt(1));
					
					//Compruebo que envia bien el "Resulset" del primer procedimiento al segundo.
					
					System.out.println("cuenta_id: "+rs.getInt(1));
					ResultSet mostrar = cs2.executeQuery();
					
					// Muestro en la pantalla los valores de lso registros seleccionados en la tabla "cuentas".
					while(mostrar.next()){
						%>
						<tr>
							<td><%=mostrar.getString(2)%></td>
							<td><%=mostrar.getFloat(3)%></td>
							<td><%=mostrar.getString(4)%></td>
							<td><a href="eliminar.jsp?eliminado=<%=mostrar.getInt(1) %>">Eliminar</a></td>
						</tr>
						<%
					}
				}
					out.print("</table></CENTER>");		
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
			<!-- Un botón para regresar al menú del usuario. -->
			<p><a href="/023_seguridad/cuenta.jsp">Volver al menu de usario</a></p>
	</div>
</body>
</html>