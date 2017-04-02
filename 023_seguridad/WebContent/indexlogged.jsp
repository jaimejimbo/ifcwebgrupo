<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
		<link rel="stylesheet" href="custom.css">
		<link href="https://fonts.googleapis.com/css?family=Spirax" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Macondo" rel="stylesheet">
		<title>Inicio</title>
	</head>
	<body>
		<nav class="navbar navbar-default">
		  <div class="container-fluid">
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		      <a class="navbar-brand custombrand" href="#">Banco</a>
		    </div>
		
		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		        <li><a href="#" class="hoverblack">Noticias</a></li>
		        <li><a href="#" class="hoverblack">Ofertas</a></li>
		        <li><a href="#" class="hoverblack">Cuentas</a></li>
		        <li><a href="#" class="hoverblack">Correo</a></li>
		        <!--<li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="#">Action</a></li>
		            <li><a href="#">Another action</a></li>
		            <li><a href="#">Something else here</a></li>
		            <li role="separator" class="divider"></li>
		            <li><a href="#">Separated link</a></li>
		            <li role="separator" class="divider"></li>
		            <li><a href="#">One more separated link</a></li>
		          </ul>
		        </li>-->
		      </ul>
		      <ul class="nav navbar-nav navbar-right">
		        <li class="dropdown">
		          <a href="#" class="hoverblack" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Nombre <span class="caret hoverblack"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="#" class="hoverblack">Preferencias</a></li>
		            <li><a href="#" class="hoverblack">Ayuda</a></li>
		            <li><a href="#" class="hoverblack">Cerrar sesión</a></li>
		          </ul>
		        </li>
		      </ul>
		      <form class="navbar-form navbar-right">
		        <div class="form-group">
		          <input type="text" class="form-control" placeholder="Búsqueda">
		        </div>
		        <button type="submit" class="btn btn-default">Buscar</button>
		      </form>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
	  	<div class="col-lg-4 col-md-3 col-sm-2 col-xs-1"></div>
	  	<div class="col-lg-4 col-md-6 col-sm-8 col-xs-10 main-bg">
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