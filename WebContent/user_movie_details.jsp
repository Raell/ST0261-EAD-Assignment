<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@page import = "java.sql.*" %>
<%

try {
	
	String movieid = request.getParameter("movieid");
	
	Class.forName("com.mysql.jdbc.Driver");
	
	String connURL = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	
	Connection conn = DriverManager.getConnection(connURL);
	
	Statement stmt = conn.createStatement();
	
	String movie = "SELECT title, release_date, description FROM movie WHERE movie_id = ?";
	PreparedStatement mov = conn.prepareStatement(movie);
	mov.setString(1, movieid);

	String actor = "SELECT name FROM movie_actors WHERE movie_id = ?";
	PreparedStatement act = conn.prepareStatement(actor);
	act.setString(1, movieid);
	
	String comment = "SELECT commenter, comment_id, content, time FROM movie_comments WHERE movie_id = ?";
	PreparedStatement comm = conn.prepareStatement(comment);
	comm.setString(1, movieid);
	
	String genre = "SELECT genre FROM movie_genre WHERE movie_id = ?";
	PreparedStatement gen = conn.prepareStatement(genre);
	gen.setString(1, movieid);
	
	String timeslot = "SELECT timeslot FROM movie_timeslots WHERE movie_id = ?";
	PreparedStatement time = conn.prepareStatement(timeslot);
	time.setString(1, movieid);
	
	ResultSet mo = mov.executeQuery();
	ResultSet ac = act.executeQuery();
	ResultSet co = comm.executeQuery();
	ResultSet ge = gen.executeQuery();
	ResultSet ti = time.executeQuery();
	
	if(mo.next() && ac.next() && ge.next() && ti.next()) {
%>
	<table cellpadding='10' border='1' width='800'>
			<tr>
				<td rowspan="6">Add Picture Here</td>
				<td>Title:</td>
				<td><%=mo.getString("title")%></td>
			</tr>
			<tr>
				<td>Release Date:</td>
				<td><%=mo.getDate("release_date")%></td>
			</tr>
			<tr>
				<td>Timeslots:</td>
				<td><%=ti.getString("timeslot")%>
				
					<% while(ti.next()) { %>
					<br /><%=ti.getString("timeslot")%>
					<% } %>
				
				</td>
			</tr>
			<tr>
				<td>Genre:</td>
				<td><%=ge.getString("genre")%>
				
					<% while(ge.next()) { %>
					<br /><%=ge.getString("genre")%>
					<% } %>
				
				</td>
			</tr>
			<tr>
				<td>Actors:</td>
				<td><%=ac.getString("name")%>
				
					<% while(ac.next()) { %>
					<br /><%=ac.getString("name")%>
					<% } %>
				
				</td>
			</tr>
			<tr>
				<td>Description:</td>
				<td><%=mo.getString("description")%></td>
			</tr>
			<% while(co.next()) { %>
			<tr>
				<td colspan="3">
					"<%=co.getString("content")%>"
					<br /><br />
					<p style="float:left; font-weight:bold; font-style: italic">- <%=co.getString("commenter")%></p>
					<p style="float:right"><%=co.getDate("time")%> <%=co.getTime("time")%></p>
				</td>
			</tr>
			<% } %>
	</table>
	<br />
	<form action="user_add_comment.jsp" method="post">
		<input type="hidden" name="movieid" value="<%=movieid%>">
		<input type="hidden" name="refer" value="1">
		<table style="border:1px solid green;">
			<tr>
				<td colspan="2"><b>Add a comment</b></td>
			</tr>
			<tr>
				<td>Name: <input type="text" name="commenter"></td>
			</tr>
			<tr>
				<td colspan="2">Comments:<br /><textarea rows="4" cols="30" name="comments"></textarea></td>
			</tr>
			<tr>
				<td><input type="submit" value="Submit"></td>
			</tr>
		</table>
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
</body>
</html>