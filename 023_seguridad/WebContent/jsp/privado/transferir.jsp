<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" %> 
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
		<link rel="stylesheet" href="../../css/custom.css">
		<link href="https://fonts.googleapis.com/css?family=Spirax" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Macondo" rel="stylesheet">
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
	    <!--[if lt IE 9]>
	    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	    <![endif]-->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  	</body>
</html>