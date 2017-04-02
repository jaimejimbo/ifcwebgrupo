<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Cuenta cliente</title>
	</head>
	<body>
		<div style="text-align:center">
			<h2>¡Bienvenido a su banco online!</h2>
			<!-- Aquí aparece el nombre del cliente logeado. -->
			<p>${sessionScope.nombre}</p>
			<!-- Creo el menú que conduce a las distintas operaciones que puede realizar el cliente dentro de su sesión. -->
			<ul>
				<li><a href="ingresar.jsp">Ingresar dinero</a></li>
				<li><a href="retirar.jsp">Retirar dinero</a></li>
				<li><a href="transferir.jsp">Transferencia bancaria</a></li>
				<li><a href="crearcuenta.jsp">Crear cuenta</a></li>
				<li>
					<form action="Cerrar" method="get">
						<input type="submit" value="Cerrar sesión">
					</form>
				</li>
			</ul>
	</body>
</html>