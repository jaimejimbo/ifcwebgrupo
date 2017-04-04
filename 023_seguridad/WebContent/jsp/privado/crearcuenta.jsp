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
		<jsp:include page="header.jsp" />
	  	<div class="col-lg-3 col-md-2 col-sm-2"></div>
	  	<div class="col-lg-6 col-md-8 col-sm-8 col-xs-12 main-bg">
		<h2 class="text-center">Crear cuenta</h2>
		<hr />
		<br />
			<form method="post" action="../../Crearcuenta">
				<div class="form-group">
					<label for="nombrecuenta" class="fill-width">
						<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Nombre cuenta</div>
						<div class="col-lg-9 col-md-9 col-sm-12 col-xs-12"><input type="text" id="nombrecuenta" name="nombrecuenta" size="50" placeholder="Introduzca un nombre para la cuenta."></div>
					</label>
				</div>
				<div class="form-group">
					<label for="descripcion" class="fill-width">
						<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Descripcion</div>
						<div class="col-lg-9 col-md-9 col-sm-12 col-xs-12"><input type="text" id="descripcion" name="descripcion" size="50" placeholder="Introduzca una descripcion para la cuenta."></div>
					</label>
				</div>
				<div class="form-group">
					<label for="fondos" class="fill-width">
						<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Fondos</div>
						<div class="col-lg-9 col-md-9 col-sm-12 col-xs-12"><input type="float" id="fondos" name="fondos" size="50" placeholder="Introduzca los fondos para la cuenta."></div>
					</label>
				</div>
				<p class="text-right"><input type="submit" value="enviar" onclick="onclick()" class="btn btn-primary" /></p>
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