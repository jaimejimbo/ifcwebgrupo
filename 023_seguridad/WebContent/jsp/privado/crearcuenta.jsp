<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Crear cuenta</title>
</head>
<body>
<h2>Crear cuenta</h2>
	<form action="../../Crearcuenta" method="post">
		<p><input type="text" name="nombrecuenta" size="50" placeholder="Introduzca un nombre para la cuenta."></p>
		<p><input type="text" name="descripcion" size="50" placeholder="Introduzca una descripcion para la cuenta."></p>
		<p><input type="float" name="fondos" size="50" placeholder="Introduzca los fondos para la cuenta."></p>
		<p><input type="submit" value="Crear"></p>
	</form>
	
	<!-- Un bot�n para regresar al men� del usuario. -->
	<p><a href="/023_seguridad/cuenta.jsp">Volver al menu de usario</a></p>
	
</body>
</html>