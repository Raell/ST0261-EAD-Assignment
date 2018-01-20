<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%
	if(session.getAttribute("superuser") == null) {
	    response.sendRedirect("401.html");
	} else {
	    String movie_id             = request.getParameter("movie_id");
	    String title                = request.getParameter("new_movie_title");
	    String description          = request.getParameter("new_movie_description");
	    String release_date         = request.getParameter("new_movie_release_date");
	    String timeslot             = request.getParameter("new_movie_timeslot");
	    String actor_list           = request.getParameter("new_movie_actor");
	    String genre                = StringUtils.join(request.getParameterValues("genre_category"), ", ");
	    String poster_directory     = request.getParameter("upload_path");
	    
	    if (title == "") {
	        response.sendRedirect("admin_add_movie.jsp");
	    } else {
	        
	        if (description == "")  {description = "TBC";}
	        if (actor_list == "")   {actor_list = "TBC";}
	        if (timeslot == "")     {timeslot = "TBC";}
	        if (genre == null)      {genre = "TBC";}
	    
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        String connURL          = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	        Connection conn         = DriverManager.getConnection(connURL);
	        Statement stmt          = conn.createStatement();  
	        String updateMovie      = "UPDATE movie SET title=?, description=?, release_date=STR_TO_DATE(?, '%d-%m-%Y'), timeslot=?, actor_list=?, genre=?, poster_directory=? WHERE movie_id=?";
	        PreparedStatement pstmt = conn.prepareStatement(updateMovie);
	        
	        pstmt.setString(1, title);
	        pstmt.setString(2, description);
	        pstmt.setString(3, release_date);
	        pstmt.setString(4, timeslot);
	        pstmt.setString(5, actor_list);
	        pstmt.setString(6, genre);
	        pstmt.setString(7, poster_directory);
	        pstmt.setString(8, movie_id);
	        
	        int count = pstmt.executeUpdate();
	        
	        if (count > 0) {
	            response.sendRedirect("admin_search_movie.jsp?status=success&search_string=");
	        } else {
	            response.sendRedirect("admin_search_movie.jsp?status=failure&search_string=");
	        }
	        conn.close();
	    } catch(Exception e) {
	        System.err.println("Error: " + e);
	    }
	    }
	}
%>