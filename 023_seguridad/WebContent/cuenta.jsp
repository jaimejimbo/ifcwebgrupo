<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Cuenta</title>
</head>
<body>
	<div style="text-align:center">
		<h2>¡Bienvenido a su banco online!</h2>
		<p>${sessionScope.nombre}</p>
		<h3>Dinero en cuenta:</h3>
		<p>${sessionScope.cantidad}</p>
		<h3>¿Qué operación desea realizar?</h3>
		<h4>Ingresar dinero</h4>
		<form action="Operaciones" method="post">
			<p><input type="number" name="ingreso" size="35" placeholder="Introduzca cantidad a ingresar."></p>
			<p><input type="submit" value="Ingresar"></p>
		</form>
		<h4>Extraer dinero</h4>
		<form action="Operaciones" method="get">
			<p><input type="number" name="retirada" size="35" placeholder="Introduzca cantidad a retirar."></p>
			<p><input type="submit" value="Sacar"></p>
		</form>
		<h4>Realizar una transferencia</h4>
		<form action="Operaciones2" method="get">
			<p><input type="text" name="otronombre" size="38" placeholder="Introduzca el nombre de la otra cuenta."></p>
			<p><input type="number" name="transferencia" size="38" placeholder="Introduzca transferencia."></p>
			<p><input type="submit" value="Transferir"></p>
		</form>
		<h4>Cerrar sesión</h4>
		<form action="Operaciones3" method="get">
			<p><input type="submit" value="Salir"></p>
		</form>
	</div>
</body>
</html>