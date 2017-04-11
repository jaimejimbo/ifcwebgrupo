<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../includes.jsp" />
<title>Movimientos</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="col-lg-1 col-md-1 col-sm-1"></div>
	<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12 main-bg">
		<table class="table table-striped">
			<thead>
				<th>Fecha</th>
				<th>Destinatario</th>
				<th>Cantidad</th>
				<th>Concepto</th>
			</thead>
			<tbody>
				<%
					ResultSet rs = (ResultSet) session.getAttribute("datos");
					while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getFloat(3)%></td>
					<td><%=rs.getString(4)%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<div id="output"></div>
	<!--[if lt IE 9]>
	    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	    <![endif]-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>