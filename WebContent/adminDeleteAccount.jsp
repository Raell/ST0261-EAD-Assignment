<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
	if(session.getAttribute("superuser") == null || session.getAttribute("superuser").equals("0")) {
	    response.sendRedirect("401.html");
	} else {
	    String admin_id     = request.getParameter("admin_id");
	    
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        
	        String connURL          = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	        
	        Connection conn         = DriverManager.getConnection(connURL);
	        
	        Statement stmt          = conn.createStatement();
	        
	        String deleteAdmin       = "DELETE FROM admin_login WHERE admin_id=?";
	      
	        PreparedStatement pstmt    = conn.prepareStatement(deleteAdmin);
	        
	        pstmt.setString(1, admin_id);
	        
	        int count               = pstmt.executeUpdate();
	        
	        if(count > 0) {
	            response.sendRedirect("admin_modify_accounts.jsp?status=success");
	        } else {
	            response.sendRedirect("admin_modify_accounts.jsp?status=failure");
	        }
	        
	        conn.close();
	    } catch(Exception e) {
	        System.err.println("Error: " + e);
	    }
	}
%>