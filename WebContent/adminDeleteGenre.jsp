<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
	if(session.getAttribute("superuser") == null) {
	    response.sendRedirect("401.html");
	} else {
	    String genre_id     = request.getParameter("genre_id");
	    
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        
	        String connURL          = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	        
	        Connection conn         = DriverManager.getConnection(connURL);
	        
	        Statement stmt          = conn.createStatement();
	        
	        String deleteGenre      = "DELETE FROM genre WHERE genre_id=?";
	        
	        PreparedStatement pstmt = conn.prepareStatement(deleteGenre);
	        
	        pstmt.setString(1, genre_id);
	        
	        int count               = pstmt.executeUpdate();
	        
	        if(count > 0) {
	            response.sendRedirect("admin_modify_genres.jsp?status=success");
	        } else {
	        	response.sendRedirect("admin_modify_genres.jsp?status=failure");
	        }
	        
	        conn.close();
	    } catch(Exception e) {
	        System.err.println("Error: " + e);
	    }
	}
%>