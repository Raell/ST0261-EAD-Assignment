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
	
	String searchtag = request.getParameter("searchtag");
	
	Class.forName("com.mysql.jdbc.Driver");
	
	String connURL = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	
	Connection conn = DriverManager.getConnection(connURL);
	
	Statement stmt = conn.createStatement();
	
	String sqlStr = "SELECT DISTINCT m.movie_id, m.title, m.release_date, m.description FROM movie m, movie_genre g WHERE m.movie_id = g.movie_id AND (m.title LIKE ? OR g.genre LIKE ?)";
	PreparedStatement state = conn.prepareStatement(sqlStr);
	
	state.setString(1, "%" + searchtag + "%");
	state.setString(2, "%" + searchtag + "%");
	
	ResultSet rs = state.executeQuery();
%>
<form action="index.html" method="post">
	<input type="submit" value="Back">
</form>
<br />
<table cellpadding='0' border='1' width='800'>
	<tr bgcolor='grey'><td width='200'></td><td><b>Title</b></td><td><b>Release Date</b></td><td><b>Description</b></td><td width='100'></td></tr>
<%	while(rs.next()) { %>
		<tr>
			<td>Add picture here</td>
			<td><%=rs.getString("title")%></td>
			<td><%=rs.getString("release_date")%></td>
			<td><%=rs.getString("description")%></td>
			<td>
				<form action='user_movie_details.jsp' method='post'>
					<input type="hidden" name="movieid" value='<%=rs.getString("movie_id")%>'>
					<input type='submit' value='Details'>
				</form>
			</td>
		</tr>
<%	} %>
</table>
<%
	conn.close();
	
} catch (Exception e) {
	System.err.println("Error :" + e);
}
	
%>
</body>
</html>