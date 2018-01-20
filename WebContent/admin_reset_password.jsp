<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title></title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<link rel="stylesheet" href="css/bootstrap.min.css">
<style type="text/css">
body {
	padding-top: 10%;
	padding-left: 30%;
	align: center;
}
</style>
<link rel="stylesheet" href="css/bootstrap-responsive.min.css">
<link rel="stylesheet" href="css/main.css">

<script src="js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"
	type="text/javascript"></script>
</head>
<body>
	<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

	<div class="navbar navbar-inverse navbar-fixed-top">

		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="#">SPMovy</a>
			</div>
		</div>
	</div>

	<div class="span5 container well">
		<form action="adminResetPassword.jsp" method="post">
			<fieldset>
				<h2>Password Reset</h2>
				<label>Username</label> <input class="span5" type="text"
					name="username" placeholder="Enter Username" required> <label>Email</label>
				<input class="span5" type="email" name="email"
					placeholder="Enter Email" required> <br /> <br />
				<button type="submit" class="btn btn-large btn-block btn-danger">
					Reset Password <i class="icon-minus-sign icon-white"></i>
				</button>

			</fieldset>

		</form>

		<div id="notify-failure" align="center"
			class="span4 alert alert-error" style="display: none;">Oh Snap!
			Your credentials are invalid</div>

		<div id="notify-success" align="center"
			class="span4 alert alert-success" style="display: none;">
			Success! Please check email for new password</div>

		<ul class="pager">
			<li class="previous"><a href="admin_login.jsp">&larr; Return
					to login page</a></li>
		</ul>

	</div>
	<br />


	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"
		type="text/javascript"></script>
	<script type="text/javascript">window.jQuery || document.write('<script src="js/vendor/jquery-1.9.1.js"><\/script>')</script>

	<script src="js/vendor/bootstrap.min.js" type="text/javascript"></script>

	<script src="js/main.js" type="text/javascript"></script>
	<%
String status = request.getParameter("status");  
if (status != null) {
    if(status.equals("success")){
%>
	<script type="text/javascript">
       document.getElementById('notify-success').setAttribute('style', 'display: block;');
       </script>
	<%      
    } else if(status.equals("failure")) {
%>
	<script type="text/javascript">
        document.getElementById('notify-failure').setAttribute('style', 'display: block;');
        </script>
	<%      
    
    }
}
%>
</body>
</html>
