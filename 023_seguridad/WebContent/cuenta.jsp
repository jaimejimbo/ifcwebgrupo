<<<<<<< HEAD
<<<<<<< HEAD
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
			<ul>
				<li><a href="ingresar.jsp">Ingresar dinero</a></li>
				<li><a href="retirar.jsp">Retirar dinero</a></li>
				<li><a href="transferir.jsp">Transferencia bancaria</a></li>
				<li><a href="crear.jsp">Crear cuenta</a></li>
				<li>
					<form action="Cerrar" method="get">
						<input type="submit" value="Cerrar sesión">
					</form>
				</li>
			</ul>
	</body>
=======
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
		<h3>¿Qué operación desea realizar?</h3>
		<h4><a href="finregistro.jsp">Terminar de completar mi registro</a></h4>
		<h4><a href="crearcuenta.jsp">Crear una nueva cuenta</a></h4>

		
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
>>>>>>> refs/remotes/origin/gonzalo
=======
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
		<h3>¿Qué operación desea realizar?</h3>
		<h4><a href="finregistro.jsp">Terminar de completar mi registro</a></h4>
		<h4><a href="crearcuenta.jsp">Crear una nueva cuenta</a></h4>

		
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
>>>>>>> branch 'gonzalo' of https://github.com/jaimejimbo/ifcwebgrupo.git
</html>