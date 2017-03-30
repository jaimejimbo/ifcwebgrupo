<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transferir dinero</title>
</head>
<body>
	<form action="Transferencias" method="post">
		<p><input type="text" name="receptor" size="35" placeholder="Introduzca nombre cliente a enviar dinero."></p>
		<p><input type="number" name="cantidad" size="35" placeholder="Introduzca cantidad."></p>
		<p><input type="text" name="concepto" size="35" placeholder="Introduzca concepto."></p>
		<p><input type="submit" value="Transferir"></p>
	</form>
</body>
</html>