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
<link rel="stylesheet" href="css/datepicker.css">

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
						<%=session.getAttribute("username") %><a></a>
					</p>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<%
    if(session.getAttribute("superuser") == null) {
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
						<li class="active"><a href="admin_add_movie.jsp">Add
								Movie Entry</a></li>
						<li><a href="admin_modify_genres.jsp">Modify Genres</a></li>
						<li><a href="admin_search_movie.jsp">Search Movie
								Database</a></li>
						<li class="nav-header">Account</li>
						<li><a href="admin_change_password.jsp">Change password</a></li>
						<li><a href="adminLogOut.jsp">Logout</a></li>
					</ul>
				</div>
			</div>

			<%        } else if(session.getAttribute("superuser").equals("0")) { %>

			<div class="row-fluid">
				<div class="span3">
					<div class="well sidebar-nav">
						<ul class="nav nav-list">
							<li class="nav-header">Movies</li>
							<li class="active"><a href="admin_add_movie.jsp">Add
									Movie Entry</a></li>
							<li><a href="admin_modify_genres.jsp">Modify Genres</a></li>
							<li><a href="admin_search_movie.jsp">Search Movie
									Database</a></li>
							<li class="nav-header">Account</li>
							<li><a href="admin_change_password.jsp">Change password</a></li>
							<li><a href="adminLogOut.jsp">Logout</a></li>
						</ul>
					</div>
				</div>
				<%        } else {
            response.sendRedirect("401.html");
        }
        
    }
%>
				<div class="span9">

					<div class="span12 container well">
						<form action="adminAddMovie.jsp" method="post">
							<fieldset>
								<h2>New Movie Entry</h2>
								<label>Title</label> <input class="span5" type="text"
									name="new_movie_title" placeholder="Enter Movie Title" required>
								<label>Description</label>
								<textarea class="span5" name="new_movie_description" rows="6"
									maxlength="1000" style="resize: none;" cols=""></textarea>
								<br /> <label>Release Date</label> <input class="span5"
									id="dpYears" type="text" name="new_movie_release_date"
									value="01-01-2013" data-date-format="dd-mm-yyyy"
									data-date-viewmod="years" size="16" required> <label>Movie
									Timeslots</label> <input class="span5" type="text"
									name="new_movie_timeslot"
									placeholder="10:30, 15,45, 23:59 etc..."
									pattern="^((([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]((, )||(,))?))*$">
								<label>Actor List</label> <input class="span5" type="text"
									name="new_movie_actor"
									placeholder="Angelina Jolie, Brad Pitt, etc..."> <label>Genres</label>
								<%@ include file="globalGetGenreCheckbox.jsp"%>
								<br /> <label>Movie Poster</label>
								<iframe src="admin_file_uploader.jsp" frameborder="0"
									style="overflow: hidden;" width="300px" height="50px"></iframe>
								<input id="upload" name="upload_path" type="hidden"
									value="uploads/poster/default.jpg" /> <br /> <br />
								<button type="submit" class=" span4 btn btn-large btn-success">
									Add Movie <i class="icon-plus-sign icon-white"></i>
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
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"
	type="text/javascript"></script>
<script type="text/javascript">window.jQuery || document.write('<script src="js/vendor/jquery-1.9.1.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="js/vendor/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
    $('#dpYears').datepicker();
});
</script>
</html>