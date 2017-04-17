<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Terminar registro</title>
</head>
<body>
	<form action="Registros" method="post">
		<p>
			<input type="text" name="nombre" size="35"
				placeholder="Introduzca su nombre.">
		</p>
		<p>
			<input type="text" name="dni" size="35"
				placeholder="Introduzca su DNI.">
		</p>
		<p>
			<input type="text" name="direccion" size="35"
				placeholder="Introduzca su dirección.">
		</p>
		<p>
			<input type="submit" value="Completar">
		</p>
	</form>
</body>
</html>