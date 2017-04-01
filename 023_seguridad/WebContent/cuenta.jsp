<!DOCTYPE>
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
			
				<p><a href="ingresar.jsp">Ingresar dinero</a></p>
				<p><a href="retirar.jsp">Retirar dinero</a></p>
				<p><a href="transferir.jsp">Transferencia bancaria</a></p>
				<p><a href="crearcuenta.jsp">Crear cuenta</a></p>
				<p><a href="eliminarcuenta.jsp">Eliminar cuenta</a></p>
				<form action="Cerrar" method="get">
					<input type="submit" value="Cerrar sesión">
				</form>		
	</body>
</html>