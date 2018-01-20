<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

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
	padding-top: 5%;
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
				<a class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse"> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span>
				</a> <a class="brand" href="#">SPMovy</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li><a href="index.html">Home</a></li>
						<li><a href="user_process_search.jsp">Search</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<ul class="pager">
			<li class="previous"><a href="user_process_search.jsp">&larr;
					Return to search</a></li>
		</ul>
		<h1>Movie Details</h1>
		<%

try {

    String movie_id = request.getParameter("movie_id");

    Class.forName("com.mysql.jdbc.Driver");

    String connURL = "jdbc:mysql://localhost/spmovy?user=root&password=root";

    Connection conn = DriverManager.getConnection(connURL);

    Statement stmt = conn.createStatement();
    
    String fetchDetailsStatement = "SELECT * FROM movie WHERE movie_id = ?";
    PreparedStatement fetchDetails = conn.prepareStatement(fetchDetailsStatement);
    fetchDetails.setString(1, movie_id);

    String fetchCommentStatement = "SELECT commenter, comment_id, content, time FROM movie_comments WHERE movie_id = ?";
    PreparedStatement fetchComment = conn.prepareStatement(fetchCommentStatement);
    fetchComment.setString(1, movie_id);


    ResultSet getDetails = fetchDetails.executeQuery();
    ResultSet getComment = fetchComment.executeQuery();
    
    if(getDetails.next()) {
%>
		<table class='well table'>
			<tr>
				<td rowspan="6" align="center"><img
					src='uploads/<% 
						String poster_path = getDetails.getString("poster_directory"); 
						out.print(poster_path.substring(poster_path.lastIndexOf('/')+1)); 
					%>' alt="NO IMAGE" style="width: 339px; max-width:339px;" class="img-polaroid" /></td>
				<td>Title:</td>
				<td><%=getDetails.getString("title")%></td>
			</tr>
			<tr>
				<td>Release Date:</td>
				<td><%=getDetails.getDate("release_date")%></td>
			</tr>
			<tr>
				<td>Timeslots:</td>
				<td><%=getDetails.getString("timeslot")%></td>
			</tr>
			<tr>
				<td>Genre:</td>
				<td><%=getDetails.getString("genre")%></td>
			</tr>
			<tr>
				<td>Actors:</td>
				<td><%=getDetails.getString("actor_list")%></td>
			</tr>
			<tr>
				<td>Description:</td>
				<td><%=getDetails.getString("description")%></td>
			</tr>
			<tr>
				<td colspan="3">
					<% while(getComment.next()) { %>

					<blockquote>
						<p>
							"<%=getComment.getString("content")%>"
						</p>
						<br /> <small><%=getComment.getString("commenter")%></small>
						<p style="float: right; font-size: 12px;"><%=getComment.getDate("time")%>
							<%=getComment.getTime("time")%></p>
					</blockquote> <% } %>
				</td>
			</tr>
		</table>
		<br />
		<form class="well" action="userAddComment.jsp" method="post">
			<fieldset>
				<legend>Voice your opinion!</legend>
				<label>Name</label> <input type="text" name="commenter"
					placeholder="Identify yourself" required> <label>Leave
					your comment...</label>
				<textarea class="span11" name="comments" style="resize: none;"
					required cols="" rows=""></textarea>
				<input type="hidden" name="movieid" value="<%=movie_id%>"> <input
					type="hidden" name="refer" value="1"> <br /> <br />
				<button type="submit" class=" btn btn-inverse">Submit</button>
			</fieldset>
		</form>
		<%
    }

    else {
        out.println("Details not available.");
        response.setHeader("Refresh", "2; URL=index.html");
    }
    conn.close();

} catch (Exception e) {
    System.err.println("Error :" + e);
}

%>

	</div>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"
		type="text/javascript"></script>
	<script type="text/javascript">window.jQuery || document.write('<script src="js/vendor/jquery-1.9.1.js"><\/script>')</script>

	<script src="js/vendor/bootstrap.min.js" type="text/javascript"></script>

	<script src="js/main.js" type="text/javascript"></script>
</body>
</html>
