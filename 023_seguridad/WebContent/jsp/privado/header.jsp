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
		      <a class="navbar-brand custombrand" href="indexlogged.jsp">Banco</a>
		    </div>
		
		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		        <li class="dropdown">
		          <a href="#" class="hoverblack" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Operaciones<span class="caret"></span></a>
		          <ul class="dropdown-menu">
					<li><a href="ingresar.jsp">Ingresar dinero</a></li>
					<li><a href="retirar.jsp">Retirar dinero</a></li>
					<li><a href="transferir.jsp">Transferencia bancaria</a></li>
		          </ul>
		        </li>
		        <li class="dropdown">
		          <a href="#" class="hoverblack" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Cuentas<span class="caret"></span></a>
		          <ul class="dropdown-menu">
					<li><a href="crearcuenta.jsp">Crear cuenta</a></li>
					<li><a href="eliminarcuenta.jsp">Eliminar cuenta</a></li>
		          </ul>
		        </li>
		      </ul>
		      <ul class="nav navbar-nav navbar-right">
		        <li class="dropdown">
		          <a href="#" class="hoverblack" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%= session.getAttribute("nombre") %> <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="preferencias.jsp">Preferencias</a></li>
		            <li><a href="ayuda.jsp">Ayuda</a></li>
		            <li><a href="../../logout.php">Cerrar sesión</a></li>
		          </ul>
		        </li>
		      </ul>
		      <!-- <form class="navbar-form navbar-right" action="/023_seguridad/Buscar" method="post">
		        <div class="form-group">
		          <input type="text" class="form-control" placeholder="Búsqueda">
		        </div>
		        <button type="submit" class="btn btn-default">Buscar</button>
		      </form>-->
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>