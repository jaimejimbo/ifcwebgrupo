<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	  	<div class="col-lg-3 col-md-2 col-sm-2"></div>
	  	<div class="col-lg-6 col-md-8 col-sm-8 col-xs-12 main-bg">
		<h2 class="text-center">Crear cuenta</h2>
			<form method="post" action="../../Crearcuenta">
				<div class="form-group">
					<label for="nombrecuenta" class="fill-width">
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">Nombre cuenta</div>
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"><input type="text" name="nombrecuenta" size="50" placeholder="Introduzca un nombre para la cuenta."></div>
					</label>
				</div>
				<div class="form-group">
					<label for="descripcion" class="fill-width">
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">Descripcion</div>
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"><input type="text" name="descripcion" size="50" placeholder="Introduzca una descripcion para la cuenta."></div>
					</label>
				</div>
				<div class="form-group">
					<label for="fondos" class="fill-width">
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">Fondos</div>
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"><input type="float" name="fondos" size="50" placeholder="Introduzca los fondos para la cuenta."></div>
					</label>
				</div>
				<input type="submit" value="enviar" onclick="onclick()" class="btn btn-warning" />
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