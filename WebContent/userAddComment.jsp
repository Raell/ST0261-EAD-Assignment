<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "java.sql.*" %>
<%@page import = "java.util.Calendar" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%@page import = "org.apache.commons.lang3.StringEscapeUtils" %>

<%
if(!(request.getParameter("refer") == null)) {

    String movieid      = request.getParameter("movieid");
    String commenter    = request.getParameter("commenter");
    String comments     = request.getParameter("comments");

    if(commenter.isEmpty() || comments.isEmpty()) {
        out.println("Form fields empty."); 
        response.setHeader("Refresh", "2; URL=user_movie_details.jsp?movieid=" + movieid);
    }

    else {

        try {

            final String DATE_FORMAT_NOW    = "yyyy-MM-dd HH:mm:ss";
            Calendar cal                    = Calendar.getInstance();
            SimpleDateFormat sdf            = new SimpleDateFormat(DATE_FORMAT_NOW);

            String datetime = sdf.format(cal.getTime());

            Class.forName("com.mysql.jdbc.Driver");

            String connURL                  = "jdbc:mysql://localhost/spmovy?user=root&password=root";

            Connection conn                 = DriverManager.getConnection(connURL);

            Statement stmt                  = conn.createStatement();

            String sqlStr                   = "INSERT INTO movie_comments (content, movie_id, commenter, time) VALUES (?, ?, ?, ?)";
            PreparedStatement insertcomm = conn.prepareStatement(sqlStr);

            insertcomm.setString(1, StringEscapeUtils.escapeHtml4(comments));
            insertcomm.setString(2, movieid);
            insertcomm.setString(3, StringEscapeUtils.escapeHtml4(commenter));
            insertcomm.setString(4, datetime);

            insertcomm.executeUpdate();

            conn.close();

        } catch (Exception e) {
            System.err.println("Error :" + e);
        }

        response.sendRedirect(response.encodeRedirectURL(("user_movie_details.jsp?movie_id=" + movieid)));
        
    }
}
else {
    response.sendRedirect("index.html");
}
%>