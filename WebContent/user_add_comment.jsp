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
<%@page import = "java.util.Calendar" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%
if(!(request.getParameter("refer") == null)) {
	
	String movieid = request.getParameter("movieid");
	String commenter = request.getParameter("commenter");
	String comments = request.getParameter("comments");
	
	if(commenter.isEmpty() || comments.isEmpty()) {
		out.println("Form fields empty."); 
		response.setHeader("Refresh", "2; URL=user_movie_details.jsp?movieid=" + movieid);
	}
	
	else {
		try {
				
			//get current date and time
			final String DATE_FORMAT_NOW = "yyyy-MM-dd HH:mm:ss";
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
		
			String datetime = sdf.format(cal.getTime());
			
			Class.forName("com.mysql.jdbc.Driver");
			
			String connURL = "jdbc:mysql://localhost/spmovy?user=root&password=root";
			
			Connection conn = DriverManager.getConnection(connURL);
			
			Statement stmt = conn.createStatement();
			
			String sqlStr = "INSERT INTO movie_comments (content, movie_id, commenter, time) VALUES (?, ?, ?, ?)";
			PreparedStatement insertcomm = conn.prepareStatement(sqlStr);
			
			insertcomm.setString(1, comments);
			insertcomm.setString(2, movieid);
			insertcomm.setString(3, commenter);
			insertcomm.setString(4, datetime);
			
			insertcomm.executeUpdate();
		
			conn.close();
			
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		
		out.println("Comment added.");
		response.setHeader("Refresh", "2; URL=index.html");
	}
}
else {
	response.sendRedirect("index.html");
}
%>
</body>
</html>