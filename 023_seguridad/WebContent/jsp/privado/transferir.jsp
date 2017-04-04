<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page language="java" %> 
<%@ page import = "java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transferir dinero</title>
</head>
<body>
	<form action="../../Transferencias" method="post">
		<p><input type="text" name="receptor" size="35" placeholder="Introduzca nombre cliente a enviar dinero."></p>
		<p><input type="number" name="cantidad" size="35" placeholder="Introduzca cantidad."></p>
		<p><input type="text" name="concepto" size="35" placeholder="Introduzca concepto."></p>
		<% 
	HttpSession sesion = request.getSession();

try 
{ 
   // Conexion con bd 
     Connection conexion = null; 
     CallableStatement sentencia = null; 
     ResultSet resultado = null; 
     Class.forName("com.mysql.jdbc.Driver");
	conexion = DriverManager.getConnection("jdbc:mysql://localhost/banco","root","");
   if (!conexion.isClosed()) 
   { 
      // La consulta 
      sentencia = conexion.prepareCall("{call nombres_cuenta(?)}"); 
      sentencia.setString(1, sesion.getAttribute("cliente_id").toString());
      sentencia.execute();
      resultado = sentencia.getResultSet();
     	out.println("Seleccione una cuenta desde la que transferir");    
      	out.println(" <select id='cuenta' name='cuenta'>"); 

      // continuamos con el select 
      while (resultado.next()) 
      { 
         	out.println("<option value='"+resultado.getInt("cuenta_id")+"'>"+resultado.getString("nombre")+"</option>");//imprimimos el contenido del select  
    	  //EL PROCEDIMIENTO NOMBRES_CUENTA ESTA CON LIMIT 1 POR LO QUE DEVUELVE SOLO UNA CUENTA, HAY QUE PONERLO PARA TODAS
      } 

 out.println("</select>"); 
      // cierre de la conexion 
      conexion.close(); 
   } 
   else 
      // Error en la conexion 
      out.println("fallo"); 
} 
catch (Exception e) 
{ 
   // Error en algun momento. 
   out.println("Excepcion "+e); 
   e.printStackTrace(); 
} 
%> 
		<p><input type="submit" value="Transferir"></p>
	</form>
	
	
	
</body>
</html>