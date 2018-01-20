<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        
        String connectURL       = "jdbc:mysql://localhost/spmovy?user=root&password=root;
        
        Connection conn         = DriverManager.getConnection(connectURL);
        
        Statement getGenreStmt  = conn.createStatement();
        
        String getGenres        = "SELECT category FROM genre";
        ResultSet rs            = getGenreStmt.executeQuery(getGenres);
        
        if (rs.isBeforeFirst()) {
            out.println("<select name='search_genre' style='margin-left: 10px;'>");
            out.println("<option></option>");
            while(rs.next()) {
                String genre     = rs.getString("category");
                out.println("<option>"+ genre + "</option>");
                }
        }
        out.println("</select>");
        conn.close();
    } catch(Exception e) {
        System.err.println("Error: " + e);
    }
%>
