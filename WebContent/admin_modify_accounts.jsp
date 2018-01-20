<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
						<li class="active"><a href="admin_modify_accounts.jsp">Manage
								Accounts</a></li>
						<li class="nav-header">Movies</li>
						<li><a href="admin_add_movie.jsp">Add Movie Entry</a></li>
						<li><a href="admin_modify_genres.jsp">Modify Genres</a></li>
						<li><a href="admin_search_movie.jsp">Search Movie
								Database</a></li>
						<li class="nav-header">Account</li>
						<li><a href="admin_change_password.jsp">Change password</a></li>
						<li><a href="adminLogOut.jsp">Logout</a></li>
					</ul>
				</div>
			</div>

			<%        } else if(session.getAttribute("superuser").equals("0")) {

            response.sendRedirect("403.html");
            } else {
            response.sendRedirect("401.html");
        }
        
    }
%>
			<div class="span9 well">
				<h2>Manage Accounts</h2>
				<a href="admin_add_account.jsp">
					<button type="submit" class="btn btn-success"
						style="margin-bottom: 10px;">
						Add Account<i class="icon-plus icon-white"></i>
					</button>
				</a> <br />
				<div id="notify-failure" align="center"
					class="span4 alert alert-error" style="display: none;">Oh
					Snap! Action not performed</div>
				<div id="notify-success" align="center"
					class="span4 alert alert-success" style="display: none;">
					Success! Action performed</div>
				<br />
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>Admin</th>
						<th>Actions</th>
					</tr>
					<%
try{
    Class.forName("com.mysql.jdbc.Driver");
    String connURL              = "jdbc:mysql://localhost/spmovy?user=root&password=T0mc@tisoverrated";
    Connection conn             = DriverManager.getConnection(connURL);
    
    String searchAccounts       = "SELECT admin_id, username FROM admin_login";
    PreparedStatement pstmt     = conn.prepareStatement(searchAccounts);
    
    ResultSet rs                = pstmt.executeQuery();
    
    if(rs.isBeforeFirst()){
        int rowCount = 0;
        while(rs.next()) {
            String admin_id         = rs.getString("admin_id");
            String username         = rs.getString("username");

%>
					<tr>
						<td><%=rowCount+1 %></td>
						<td><%=username %></td>
						<td>
							<form action="adminDeleteAccount.jsp" method="post"
								style="display: inline;">
								<button name="delete_button" type="submit"
									class=" btn btn-danger">
									Delete <i class="icon-remove icon-white"></i>
								</button>
								<input type="hidden" name="admin_id" value="<%=admin_id %>">
							</form> <% 

rowCount++;
        }
        
        }
%>
						</td>
					</tr>
					<%
    
} catch(Exception e) {
    System.err.println("Error: " + e);
}
%>
				</table>

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