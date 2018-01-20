<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@page import = "org.apache.commons.lang3.StringEscapeUtils" %>
<%
	if(session.getAttribute("superuser") == null) {
	    response.sendRedirect("401.html");
	} else {
	    String genre = StringEscapeUtils.escapeHtml4(request.getParameter("new_genre_category"));
	    if(!genre.equals("")){
		    try {
		        Class.forName("com.mysql.jdbc.Driver");
		        String connURL          = "jdbc:mysql://localhost/spmovy?user=root&password=root";
		        Connection conn         = DriverManager.getConnection(connURL);
		        Statement stmt          = conn.createStatement();  
		        String addGenre         = "INSERT INTO genre (category) VALUES (?)";  
		        PreparedStatement pstmt = conn.prepareStatement(addGenre);
		        
		        pstmt.setString(1, genre);
		        int count = pstmt.executeUpdate();
		        
		        if (count > 0) {
		        	response.sendRedirect("admin_modify_genres.jsp?status=success");
		        } else {
		        	response.sendRedirect("admin_modify_genres.jsp?status=failure");
		        }
		        conn.close();
		    } catch(Exception e) {
		        System.err.println("Error: " + e);
		    }
	    } else {
	    	response.sendRedirect("admin_modify_genres.jsp?status=failure");
	    }
	}
%>