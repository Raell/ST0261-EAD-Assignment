<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@page import = "org.apache.commons.lang3.StringEscapeUtils" %>
<%
	if(session.getAttribute("superuser") == null) {
	    response.sendRedirect("401.html");
	} else {
	    String title                = StringEscapeUtils.escapeHtml4(request.getParameter("new_movie_title"));
	    String description          = StringEscapeUtils.escapeHtml4(request.getParameter("new_movie_description"));
	    String release_date         = StringEscapeUtils.escapeHtml4(request.getParameter("new_movie_release_date"));
	    String timeslot             = StringEscapeUtils.escapeHtml4(request.getParameter("new_movie_timeslot"));
	    String actor_list           = StringEscapeUtils.escapeHtml4(request.getParameter("new_movie_actor"));
	    String genre                = StringEscapeUtils.escapeHtml4(StringUtils.join(request.getParameterValues("genre_category"), ", "));
	    String username             = (String) session.getAttribute("username");
	    String poster_directory     = StringEscapeUtils.escapeHtml4(request.getParameter("upload_path"));
	    
	    if (title == "") {
	        response.sendRedirect("admin_add_movie.jsp");
	    } else {
	        
	        if (description == "") {description = "TBC";}
	        if (actor_list == "") {actor_list = "TBC";}
	        if (timeslot == "") {timeslot = "TBC";}
	        if (genre == null) {genre = "TBC";}
	    
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        String connURL          = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	        Connection conn         = DriverManager.getConnection(connURL);
	        Statement stmt          = conn.createStatement();  
	        String addMovie         = "INSERT INTO movie (title, description, release_date, timeslot, actor_list, genre, poster_directory, added_by) VALUES ( ? , ?, STR_TO_DATE(?, '%d-%m-%Y'), ?, ?, ?, ?, ?)";  
	        PreparedStatement pstmt = conn.prepareStatement(addMovie);
	        
	        pstmt.setString(1, title);
	        pstmt.setString(2, description);
	        pstmt.setString(3, release_date);
	        pstmt.setString(4, timeslot);
	        pstmt.setString(5, actor_list);
	        pstmt.setString(6, genre);
	        pstmt.setString(7, poster_directory);
	        pstmt.setString(8, username);
	        
	        int count = pstmt.executeUpdate();
	        
	        if (count > 0) {
	            
	            response.sendRedirect("admin_add_movie.jsp?status=success");
	        } else {
	        	response.sendRedirect("admin_add_movie.jsp?status=failure");
	        }
	        conn.close();
	    } catch(Exception e) {
	        System.err.println("Error: " + e);
	    }
	    }
	}
%>