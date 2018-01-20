<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Arrays"%>
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
						<form action="adminUpdateMovie.jsp" method="post">
							<fieldset>
								<h2>Update Movie Entry</h2>
								<%
    String movie_id     = request.getParameter("movie_id");
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        
        String connURL                 = "jdbc:mysql://localhost/spmovy?user=root&password=T0mc@tisoverrated";
        
        Connection conn                = DriverManager.getConnection(connURL);
        
        Statement fetchMovie           = conn.createStatement();
        
        String fetchMovieQuery         = "SELECT movie_id, title, description, DATE_FORMAT(release_date, '%d-%m-%Y'), timeslot, actor_list, genre, poster_directory FROM movie WHERE movie_id='" + movie_id + "'" ;
        ResultSet fetchMovieResults    = fetchMovie.executeQuery(fetchMovieQuery);

        while(fetchMovieResults.next()) {
            String oldTitle              = fetchMovieResults.getString("title");
            String oldDescription        = fetchMovieResults.getString("description");
            String oldReleaseDate        = fetchMovieResults.getString("DATE_FORMAT(release_date, '%d-%m-%Y')");
            String oldTimeslot           = fetchMovieResults.getString("timeslot");
            String oldActorList          = fetchMovieResults.getString("actor_list");
            String oldPosterPath         = fetchMovieResults.getString("poster_directory");
            String[] oldGenre            = StringUtils.split(fetchMovieResults.getString("genre"), ", ");
            
            HashSet<String> oldGenreList = new HashSet<String>(Arrays.asList(oldGenre));
            Statement getGenre                 = conn.createStatement();
            String getGenreQuery               = "SELECT category FROM genre";
            ResultSet getGenreResults          = getGenre.executeQuery(getGenreQuery);

            out.println("<label>Title</label><input class='span5' name='new_movie_title' type='text' value='" + oldTitle + "' required/> <br />");
            out.println("<label>Description</label><textarea class='span5' name='new_movie_description' rows='6' maxlength='1000' style='resize:none;''>" + oldDescription +"</textarea> <br />");
            out.println("<label>Release Date</label> <input class='span5' id='dpYears' type='text' name='new_movie_release_date' value='" + oldReleaseDate + "' data-date-format='dd-mm-yyyy' data-date-viewmod='years' size='16' required> <br />");
            out.println("<label>Movie Timeslots</label><input class='span5' type='text' name='new_movie_timeslot' value='" + oldTimeslot + "' pattern='^((([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]((, )||(,))?))*$' /> <br />");
            out.println("<label>Actor List</label> <input class='span5' type='text' name='new_movie_actor' value='" + oldActorList + "' /> <br />");
            out.println("<label>Genres</label>");
                while(getGenreResults.next()) {
                    String genre     = getGenreResults.getString("category");
                    
                    if(oldGenreList.contains(genre)){
                           out.println("<label class='checkbox'>" + genre + "<input name='genre_category' type='checkbox' value='" + genre + "' checked/></label>");
                           
                    } else {
                    out.println("<label class='checkbox'>" + genre + "<input name='genre_category' type='checkbox' value='" + genre + "'/></label>");
                }
              }
            out.println("<br />");     
            out.println("<label>Movie Poster</label>");  
            out.println("<img src='" + oldPosterPath + "' alt='NO IMAGE' style='width: 203.5px;' /> <br /> <br />"); 
            out.println("<iframe src='admin_file_uploader.jsp'  frameborder='0' style='overflow:hidden;' width='300px' height='50px'></iframe>");
            out.println("<input id='upload' name='upload_path' type='hidden' value='" + oldPosterPath +"'uploads/poster/default.jpg/>");
 %>

								<br /> <br /> <input type="hidden" name="movie_id"
									value="<%=movie_id %>">
								<button type="submit" class=" span4 btn btn-large btn-warning">
									Update Movie <i class="icon-edit icon-white"></i>
								</button>

							</fieldset>
							<%
}
conn.close();
} catch(Exception e) {
System.err.println("Error: " + e);
}
%>
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