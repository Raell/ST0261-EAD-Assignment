<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Administration Panel</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<link href="css/bootstrap.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 60px;
	padding-bottom: 40px;
}

.sidebar-nav {
	padding: 9px 0;
}

@media ( max-width : 980px) {
	.navbar-text.pull-right {
		float: none;
		padding-left: 5px;
		padding-right: 5px;
	}
}
</style>
<link href="css/bootstrap-responsive.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="../assets/js/html5shiv.js"></script>
    <![endif]-->

</head>

<body>

	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="brand" href="#">SPMovy</a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">
						Logged in as
						<%=session.getAttribute("username")%><a></a>
					</p>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<%
			if (session.getAttribute("superuser") == null) {
				response.sendRedirect("401.html");
			} else {

				if (session.getAttribute("superuser").equals("1")) {
		%>
		<div class="row-fluid">
			<div class="span3">
				<div class="well sidebar-nav">
					<ul class="nav nav-list">
						<li class="nav-header">Administration</li>
						<li><a href="admin_modify_accounts.jsp">Manage Accounts</a></li>
						<li class="nav-header">Movies</li>
						<li><a href="admin_add_movie.jsp">Add Movie Entry</a></li>
						<li><a href="admin_modify_genres.jsp">Modify Genres</a></li>
						<li><a href="admin_search_movie.jsp">Search Movie
								Database</a></li>
						<li class="nav-header">Account</li>
						<li class="active"><a href="admin_change_password.jsp">Change
								password</a></li>
						<li><a href="adminLogOut.jsp">Logout</a></li>
					</ul>
				</div>
			</div>

			<%
				} else if (session.getAttribute("superuser").equals("0")) {
			%>

			<div class="row-fluid">
				<div class="span3">
					<div class="well sidebar-nav">
						<ul class="nav nav-list">
							<li class="nav-header">Movies</li>
							<li><a href="admin_add_movie.jsp">Add Movie Entry</a></li>
							<li><a href="admin_modify_genres.jsp">Modify Genres</a></li>
							<li><a href="admin_search_movie.jsp">Search Movie
									Database</a></li>
							<li class="nav-header">Account</li>
							<li class="active"><a href="admin_change_password.jsp">Change
									password</a></li>
							<li><a href="adminLogOut.jsp">Logout</a></li>
						</ul>
					</div>
				</div>
				<%
					} else {
							response.sendRedirect("401.html");
						}

					}
				%>
				<div class="span9">

					<div class="span12 container well">
						<form action="adminChangePassword.jsp" method="post">
							<fieldset>
								<h2>Change Password</h2>
								<label>Old Password</label> <input class="span5" type="password"
									name="old_password" placeholder="Enter Old Password" required>
								<label>New Password</label> <input class="span5" type="password"
									name="new_password" placeholder="Enter New Password" required>
								<br /> <br /> <input type="hidden" name="username"
									value=<%=session.getAttribute("username")%>>
								<button type="submit" class=" span4 btn btn-large btn-danger">
									Change Password <i class="icon-user icon-white"></i>
								</button>

							</fieldset>

						</form>
						<div id="notify-failure" align="center"
							class="span4 alert alert-error" style="display: none;">Oh
							Snap! Your credentials are invalid</div>
						<div id="notify-success" align="center"
							class="span4 alert alert-success" style="display: none;">
							Success! Password updated</div>
					</div>
				</div>

			</div>
		</div>


	</div>
</body>
<%
	String status = request.getParameter("status");
	if (status != null) {
		if (status.equals("success")) {
%>
<script type="text/javascript">
	document.getElementById('notify-success').setAttribute('style',
			'display: block;');
</script>
<%
	} else if (status.equals("failure")) {
%>
<script type="text/javascript">
	document.getElementById('notify-failure').setAttribute('style',
			'display: block;');
</script>
<%
	}
	}
%>
</html>

