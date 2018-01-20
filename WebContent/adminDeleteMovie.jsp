<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
	if(session.getAttribute("superuser") == null) {
	    response.sendRedirect("401.html");
	} else {
	    String movie_id     = request.getParameter("movie_id");
	    
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        
	        String connURL          = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	        
	        Connection conn         = DriverManager.getConnection(connURL);
	        
	        Statement stmt          = conn.createStatement();
	        
	        String deleteMovie      = "DELETE FROM movie WHERE movie_id=?";
	        
	        PreparedStatement pstmt = conn.prepareStatement(deleteMovie);
	        
	        pstmt.setString(1, movie_id);
	        
	        int count               = pstmt.executeUpdate();
	        
	        if(count > 0) {
	        	response.sendRedirect("admin_search_movie.jsp?search_string=&status=success");
	        } else {
	        	response.sendRedirect("admin_search_movie.jsp?search_string=&status=failure");
	        }
	        
	        conn.close();
	    } catch(Exception e) {
	        System.err.println("Error: " + e);
	    }
	}
%>