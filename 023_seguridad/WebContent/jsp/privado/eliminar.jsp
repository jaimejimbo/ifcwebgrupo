<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<% 
		// Recupero "eliminado" que es el "cuenta_id" que deseo eliminar.
		
		Integer eliminado = Integer.parseInt(request.getParameter("eliminado"));
		
		// Me conecto a la base de datos.
			
		Connection conexion = null;
		CallableStatement cs1 = null;
		CallableStatement cs2 = null;
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
			
			// Primero elimino la cuenta en la tabla "posesiones" con el procedimiento "disociar_cuenta".
			
			cs1 = conexion.prepareCall("{call disociar_cuenta(?)}");
			cs1.setInt(1,eliminado);
			cs1.executeUpdate();
			
			// Después elimino la cuenta en la tabla "cuentas" con el procedimiento "eliminar_cuenta".
			
			cs2 = conexion.prepareCall("{call eliminar_cuenta(?)}");
			cs2.setInt(1,eliminado);
			cs2.executeUpdate();
			
			response.sendRedirect("/023_seguridad/jsp/privado/indexlogged.jsp");
			
			
		}catch(ClassNotFoundException e){
						
			e.printStackTrace();
					
		}
					
		finally{
						
			try{
							
			cs1.close();
			cs2.close();
			conexion.close();
						
			}catch(Exception e){
							
				e.printStackTrace();
			}
					
		}
		
	%>
		
		
</body>
</html>