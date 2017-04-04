<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
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
		<title>Inicio</title>
	</head>
	<body>
		<nav class="navbar navbar-default">
		  <div class="container-fluid">
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		      <a class="navbar-brand custombrand" href="#">Banco</a>
		    </div>
		
		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		        <li class="dropdown">
		          <a href="#" class="hoverblack" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Operaciones<span class="caret"></span></a>
		          <ul class="dropdown-menu">
					<li><a href="ingresar.jsp">Ingresar dinero</a></li>
					<li><a href="retirar.jsp">Retirar dinero</a></li>
					<li><a href="transferir.jsp">Transferencia bancaria</a></li>
		          </ul>
		        </li>
		        <li class="dropdown">
		          <a href="#" class="hoverblack" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Cuentas<span class="caret"></span></a>
		          <ul class="dropdown-menu">
					<li><a href="crearcuenta.jsp">Crear cuenta</a></li>
					<li><a href="eliminarcuenta.jsp">Eliminar cuenta</a></li>
		          </ul>
		        </li>
		      </ul>
		      <ul class="nav navbar-nav navbar-right">
		        <li class="dropdown">
		          <a href="#" class="hoverblack" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%= session.getAttribute("nombre") %> <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="preferencias.jsp">Preferencias</a></li>
		            <li><a href="ayuda.jsp">Ayuda</a></li>
		            <li><a href="../../logout.php">Cerrar sesión</a></li>
		          </ul>
		        </li>
		      </ul>
		      <form class="navbar-form navbar-right">
		        <div class="form-group">
		          <input type="text" class="form-control" placeholder="Búsqueda">
		        </div>
		        <button type="submit" class="btn btn-default">Buscar</button>
		      </form>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
	  	<div class="col-lg-1 col-md-1 col-sm-1"></div>
	  	<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12 main-bg">
			<div style="text-align:center">
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