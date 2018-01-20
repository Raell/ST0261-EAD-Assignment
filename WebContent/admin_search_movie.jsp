<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import = "org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="java.sql.*"%>
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
						<!--               <li class="active"><a href="#">Manage Accounts</a></li> -->
						<li><a href="admin_modify_accounts.jsp">Manage Accounts</a></li>
						<li class="nav-header">Movies</li>
						<li><a href="admin_add_movie.jsp">Add Movie Entry</a></li>
						<li><a href="admin_modify_genres.jsp">Modify Genres</a></li>
						<li class="active"><a href="admin_search_movie.jsp">Search
								Movie Database</a></li>
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
							<li><a href="admin_add_movie.jsp">Add Movie Entry</a></li>
							<li><a href="admin_modify_genres.jsp">Modify Genres</a></li>
							<li class="active"><a href="admin_search_movie.jsp">Search
									Movie Database</a></li>
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
				<div class="span9 well">

					<% 
String searchString     = StringEscapeUtils.escapeHtml4(request.getParameter("search_string")); 
String displaySearch;

if(request.getParameter("search_string") == null) {
    displaySearch = "";
} else {
    displaySearch = searchString;
}
%>
					<h2>
						Currently searching for:
						<%=displaySearch %></h2>
					<form class="form-search" action="admin_search_movie.jsp"
						method="get">
						<div class="input-append">
							<input type="text" class="span16 search-query"
								name="search_string" />
							<button type="submit" class="btn btn-inverse">
								<i class="icon-search icon-white"></i>
							</button>
						</div>
					</form>
					<div id="notify-failure" align="center"
						class="span4 alert alert-error" style="display: none;">Oh
						Snap! Action not performed</div>
					<div id="notify-success" align="center"
						class="span4 alert alert-success" style="display: none;">
						Success! Action performed</div>
					<table class="table table-hover">
						<tr>
							<th>#</th>
							<th>Title</th>
							<th>Release Date</th>
							<th>Actions</th>
						</tr>
						<%
try{
    Class.forName("com.mysql.jdbc.Driver");
    String connURL              = "jdbc:mysql://localhost/spmovy?user=root&password=T0mc@tisoverrated";
    Connection conn             = DriverManager.getConnection(connURL);
    
    String searchMovie          = "SELECT movie_id, title, release_date, poster_directory, added_by FROM movie WHERE title LIKE ?";
    PreparedStatement pstmt     = conn.prepareStatement(searchMovie);
    
    pstmt.setString(1, "%" + searchString + "%");
    
    ResultSet rs                = pstmt.executeQuery();
    
    if(rs.isBeforeFirst()){
        int rowCount = 0;
        while(rs.next()) {
            String movie_id         = rs.getString("movie_id");
            String title            = rs.getString("title");
            String release_date     = rs.getString("release_date");
            String poster_path      = rs.getString("poster_directory");
            String username         = rs.getString("added_by");
%>
						<tr>
							<td><%=rowCount+1 %></td>
							<td><%=title %></td>
							<td><%=release_date %></td>
							<td>
								<%
        if(((String)session.getAttribute("username")).equals(username) || 
                ((String)session.getAttribute("superuser")).equals("1")) {
        
%>
								<form action="adminDeleteMovie.jsp" method="post"
									style="display: inline;">
									<button name="delete_button" type="submit"
										class=" btn btn-danger">
										Delete <i class="icon-remove icon-white"></i>
									</button>
									<input type="hidden" name="movie_id" value="<%=movie_id %>">
								</form>

								<form action="admin_update_movie.jsp" method="post"
									style="display: inline;">
									<button name="update_button" type="submit"
										class=" btn btn-warning">
										Update <i class="icon-edit icon-white"></i>
									</button>
									<input type="hidden" name="movie_id" value="<%=movie_id %>">
								</form> <% 
        } else {
        
        
%>
								<form action="adminDeleteMovie.jsp" method="post"
									style="display: inline;">
									<button name="delete_button" type="submit"
										class=" btn btn-danger" disabled>
										Delete <i class="icon-remove icon-white"></i>
									</button>
<!--  							<input type="hidden" name="movie_id" value="<%=movie_id %>">-->        
								</form>

								<form action="admin_update_movie.jsp" method="post"
									style="display: inline;">
									<button name="update_button" type="submit"
										class=" btn btn-warning" disabled>
										Update <i class="icon-edit icon-white"></i>
									</button>
<!--									<input type="hidden" name="movie_id" value="<%=movie_id %>">--> 
								</form> <%
        }
        rowCount++;
        }
%>
							</td>
						</tr>
						<%
    }
} catch(Exception e) {
    System.err.println("Error: " + e);
}
%>
					</table>
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
</html>

