<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../includes.jsp" />
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
					<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Nombre
						cuenta</div>
					<div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
						<input type="text" id="nombrecuenta" name="nombrecuenta"
							placeholder="Introduzca un nombre para la cuenta.">
					</div>
				</label>
			</div>
			<div class="form-group">
				<label for="descripcion" class="fill-width">
					<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Descripcion</div>
					<div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
						<input type="text" id="descripcion" name="descripcion"
							placeholder="Introduzca una descripcion para la cuenta.">
					</div>
				</label>
			</div>
			<div class="form-group">
				<label for="fondos" class="fill-width">
					<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">Fondos</div>
					<div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
						<input type="float" id="fondos" name="fondos" size="50"
							placeholder="Introduzca los fondos para la cuenta.">
					</div>
				</label>
			</div>
			<p class="text-right">
				<input type="submit" value="enviar" onclick="onclick()"
					class="btn btn-primary" />
			</p>
		</form>
	</div>
	<div id="output"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>