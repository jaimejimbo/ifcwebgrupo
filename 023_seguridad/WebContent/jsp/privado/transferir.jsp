<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" %> 
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<jsp:include page="../includes.jsp" />
		<title>Transferir dinero</title>
	</head>
	<body>
		<jsp:include page="header.jsp" />
	  	<div class="col-lg-1 col-md-1 col-sm-1"></div>
	  	<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12 main-bg">
			<form action="../../Transferencias" method="post">
				<div class="form-group">
					<label for="receptor" class="fill-width"><div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Receptor</div>
					     <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12"><input type="text" id="receptor" name="receptor" placeholder="Introduzca nombre cliente a enviar dinero."></div></label>
				</div>
				<div class="form-group">
					<label for="cantidad" class="fill-width"><div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Cantidad</div>
						 <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12"><input type="number" id="cantidad" name="cantidad" placeholder="Introduzca cantidad."></div></label>
				</div>
				<div class="form-group">
					<label for="concepto" class="fill-width"><div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Concepto</div>
						 <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12"><input type="text" id="concepto" name="concepto" placeholder="Introduzca concepto."></div></label>
				</div>
				<div class="form-group">
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
						      	out.println("<div class=\"form-group\">");
								out.println("<label for=\"cuenta\" class=\"fill-width\"><div class=\"col-lg-3 col-md-3 col-sm-12 col-xs-12\">Cuenta</div>");
								out.println("<div class=\"col-lg-9 col-md-9 col-sm-12 col-xs-12\"><select class='fill-width' id='cuenta' name='cuenta'>");	
						
						      // continuamos con el select 
						      while (resultado.next()) 
						      { 
						         	out.println("<option value='"+resultado.getInt("cuenta_id")+"'>"+resultado.getString("nombre")+"</option>");//imprimimos el contenido del select  
						    	  //EL PROCEDIMIENTO NOMBRES_CUENTA ESTA CON LIMIT 1 POR LO QUE DEVUELVE SOLO UNA CUENTA, HAY QUE PONERLO PARA TODAS
						      } 
						
						 		out.println("</select>"); 
								out.println("</div></label></div>");	
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
				</div>
				<p class="text-right"><input type="submit" class="btn btn-primary" value="Enviar" /></p>
			</form>
		</div>
		<div id="output"></div>
<jsp:include page="footer.jsp" />
  	</body>
</html>