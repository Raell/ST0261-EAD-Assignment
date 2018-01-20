<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        
        String connURL      = "jdbc:mysql://localhost/spmovy?user=root&password=root";
        
        Connection conn     = DriverManager.getConnection(connURL);
        
        Statement stmt      = conn.createStatement();
        
        String getGenres    = "SELECT category FROM genre";
        ResultSet rs        = stmt.executeQuery(getGenres);
        
        if (rs.isBeforeFirst()) {
            while(rs.next()) {
                String genre     = rs.getString("category");
                out.println("<label class='checkbox'>"+ genre + "<input name='genre_category' type='checkbox' value='" + genre + "'/>" + "</label>");
                }
        } else {
            out.println("No stored genres! Please go to the add genre page to add at least one genre!");
        }

        conn.close();
    } catch(Exception e) {
        System.err.println("Error: " + e);
    }
%>