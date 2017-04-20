<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../includes.jsp"/>
    <title>Inicio</title>
</head>
<body onload="cargarcuentas(<%=session.getAttribute("cliente_id")%>)">
<jsp:include page="header.jsp"/>
<div class="col-lg-1 col-md-1 col-sm-1"></div>
<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12 main-bg">
    <div id="cuentas"></div>
    <p class="text-right">
        <a class="fa fa-plus" href="crearcuenta.jsp">Añadir</a>
    </p>
</div>
<div id="output"></div>
    <!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<jsp:include page="footer.jsp"></jsp:include>
<script>
    function cargarcuentas(cliente_id) {
        $.post("/cuentas.php", {clienteid: cliente_id}, function(data){
            $("#cuentas").html(data);
        });
    }
</script>
</body>
</html>