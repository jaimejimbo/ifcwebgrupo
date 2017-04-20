<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!String nombre;%>
<!DOCTYPE html>


<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
		<link rel="stylesheet" href="css/custom.css">
		<link href="https://fonts.googleapis.com/css?family=Spirax" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Macondo" rel="stylesheet">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <style>
            .mySlides {display:none;}
        </style>

        <title>Inicio</title>
	</head>
	<body>
		<nav class="navbar navbar-inverse" style="border: 0">
		  <div class="container-fluid">
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
                <img src="/img/evilWhite.png" alt="" height="40" style="vertical-align: bottom">
            </div>
		
		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav navbar-right">
		        <li><a href="<%=request.getContextPath()%>/jsp/privado/indexlogged.jsp" class="hoverblack">
		 <%
			nombre = (String)session.getAttribute("nombre");
		   	if (nombre==null){
		   		nombre = "Iniciar sesión";
		   	} else {
		   		response.sendRedirect(request.getContextPath().concat("/jsp/privado/indexlogged.jsp"));
		   	}
 		%><%=nombre%></a></li>
		      </ul>
		      <!-- <form class="navbar-form navbar-right">
		        <div class="form-group">
		          <input type="text" class="form-control" placeholder="Búsqueda">
		        </div>
		        <button type="submit" class="btn btn-default">Buscar</button>
		      </form> -->
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
	  	<div class="col-lg-4 col-md-3 col-sm-2 col-xs-1"></div>
	  	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 main-bg">

            <div class="row carousel-row">
                <div class="col-xs-8 col-xs-offset-2 slide-row">
                    <div class="carousel slide slide-carousel" id="carousel-1" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-1" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-1" data-slide-to="1"></li>
                            <li data-target="#carousel-1" data-slide-to="2"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            <div class="item active">
                                <img src="/img/tarjetaN.png" alt="Image">
                            </div>
                            <div class="item">
                                <img src="/img/evilbuilding.png" alt="Image">
                            </div>
                            <div class="item">
                                <img src="/img/cartera.png" alt="Image">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="output"></div>
		<script>
			function publico(){
				$.post("Publico", {}, function(data){
					$("#output").html(data);
				});
			}
			
			function privado(){
				$.post("Privado", {}, function(data){
					$("#output").html(data);
				});
			}
		</script>
	    <!--[if lt IE 9]>
	    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	    <![endif]-->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  	</body>
</html>