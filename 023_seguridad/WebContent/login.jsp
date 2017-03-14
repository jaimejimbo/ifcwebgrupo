<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
	<link rel="stylesheet" href="custom.css">
    <title>Iniciar Sesión</title>
  </head>
  <body onload="loadlogin()">
  	<div class="col-lg-3 col-md-2 col-sm-1 col-xs-1"></div>
  	<div class="col-lg-6 col-md-8 col-sm-10 col-xs-10 main-bg" id="login">
	</div>
	
	<script>
		function loadlogin(){
			var msg = '<h2 class="text-center">Inicio de sesión</h2>';
		        msg +=   '<form action="login.php" method="post">';
	        	msg +='			<div class="form-group">';
	        	msg +='				<label for="email" class="fill-width">';
	        	msg +='						<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">Email</div>';
	        	msg +='									<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12"><input onclick="checkmail()" class="fill-width" oninput="checkmail()" type="email" id="email" name="email" placeholder="Introduzca su email" /></div>';
	        	msg +='		</label>';
	        	msg +='		<div id="emailcheckinfo"></div>';
	        	msg +='	</div>';
	        	msg +='	<div class="form-group" >';
	        	msg +='		<label for="pwd" class="fill-width">';
	        	msg +='			<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">Contraseña</div>';
	        	msg +='			<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12"><input onclick="" class="fill-width" oninput="" type="password" id="pwd" name="pwd" /></div>';
	        	msg +='		</label>';
	        	msg +='		<div id="pwdcheckinfo"></div>';
	        	msg +='	</div>';
	        	msg +='	<div class="form-group text-right">';
	        	msg +='	       <a href="#" onclick="loadreg()">Registrarme</a>';
	        	msg +='				<input type="submit" value="enviar" onclick="onclick()" class="btn btn-info" id="loginbtn" />';
	        	msg +='			</div>';
	        	msg +='		</form>';
			$("#login").html(msg);
		}
		
		function loadreg(){
			var msg = '<h2 class="text-center">Registro</h2>';
		        msg +=   '<form action="registrar.php" method="post">';
	        	msg +='			<div class="form-group">';
	        	msg +='				<label for="email" class="fill-width">';
	        	msg +='						<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">Email</div>';
	        	msg +='									<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12"><input onclick="checkmail()" class="fill-width" oninput="checkmail()" type="email" id="email" name="email" placeholder="Introduzca su email" /></div>';
	        	msg +='		</label>';
	        	msg +='		<div id="emailcheckinfo"></div>';
	        	msg +='	</div>';
	        	msg +='	<div class="form-group">';
	        	msg +='		<label for="pwd" class="fill-width">';
	        	msg +='			<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">Contraseña</div>';
	        	msg +='			<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12"><input onclick="checkpwd()" class="fill-width" oninput="checkpwd()" type="password" id="pwd" name="pwd" /></div>';
	        	msg +='		</label>';
	        	msg +='		<div id="pwdcheckinfo"></div>';
	        	msg +='	</div>';
	        	msg +='	<div class="form-group">';
	        	msg +='		<label for="pwd2" class="fill-width">';
	        	msg +='			<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">Repita contraseña</div>';
	        	msg +='			<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12"><input onclick="checkpwd2()" class="fill-width" oninput="checkpwd2()" type="password" id="pwd2" name="pwd2" /></div>';
	        	msg +='		</label>';
	        	msg +='		<div id="pwdcheckinfo2"></div>';
	        	msg +='	</div>';
	        	msg +='	<div class="form-group text-right">';
	        	msg +='	       <a href="#" onclick="loadlogin()">Ya tengo cuenta</a>';
	        	msg +='				<input type="submit" value="enviar" onclick="onclick()" class="btn btn-info" id="loginbtn" />';
	        	msg +='			</div>';
	        	msg +='		</form>';
			$("#login").html(msg);
		}
	
		function checkmail(){
			var email = $("#email").val();
			var regmail = /^[a-z0-9\._+-]*@[a-z0-9\.-]+\.[a-z0-9]{1,4}/;
			$("#loginbtn").disabled=true;
			if (!regmail.test(email)){
				$("#emailcheckinfo").html("<h5>Introduza un email válido</h5>");
			} else {
				$("#emailcheckinfo").html("");
				$("#loginbtn").disabled=false;
			}
		}
		function checkpwd(){
			var pwd = $("#pwd").val();
			var minusc = /.*[a-z]+.*/;
			var mayusc = /.*[A-Z]+.*/;
			var numer = /.*[0-9]+.*/;
			var special = /.*[^a-zA-Z0-9]+.*/;
			var msg = "";
			$("#loginbtn").disabled=true;
			if (pwd.length<6){
				msg += "<h5>Introduza una contraseña de más de 6 caracteres</h5>";
			}
			if (!minusc.test(pwd)){
				msg += "<h5>Introduza una contraseña con al menos una minúscula</h5>";
			}
			if (!mayusc.test(pwd)){
				msg += "<h5>Introduza una contraseña con al menos una mayúscula</h5>";
			}
			if (!numer.test(pwd)){
				msg += "<h5>Introduza una contraseña con al menos un número</h5>";
			}
			if (!special.test(pwd)){
				msg += "<h5>Introduza una contraseña con al menos un carácter especial</h5>";
			}
			if (msg==""){
				$("#loginbtn").disabled=false;
			}
			$("#pwdcheckinfo").html(msg);
		}
		function checkpwd2(){
			checkpwd();
			var pwd = $("#pwd").val();
			var pwd2 = $("#pwd2").val();
			var msg="";
			if (pwd!=pwd2){
				msg += "<h5>Las contraseñas no coinciden</h5>";
			}
			if (msg==""){
				$("#loginbtn").disabled=false;
			}
			$("#pwdcheckinfo2").html(msg);
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