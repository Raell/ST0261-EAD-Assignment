<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.*" %>
<%@page import = "org.apache.commons.lang3.StringEscapeUtils" %>
<%
    String username         = StringEscapeUtils.escapeHtml4(request.getParameter("new_username"));
    String password         = request.getParameter("new_password");
    String hashedPassword   = BCrypt.hashpw(password+username, BCrypt.gensalt(12));
    String email            = request.getParameter("new_email");
    String superuser;
    
    if(session.getAttribute("superuser") == null) {
        response.sendRedirect("401.html");
    } else {
	    if(request.getParameter("superuser") == null) {
	        superuser = "0";
	    } else {
	        superuser = "1";
	    }
	    
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        String connURL          = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	        Connection conn         = DriverManager.getConnection(connURL);
	        Statement stmt          = conn.createStatement();  
	        String createAccount    = "INSERT INTO admin_login (username, password, email, superuser) VALUES ( ? , ?, ?, ? )";  
	        PreparedStatement pstmt = conn.prepareStatement(createAccount);
	        
	        pstmt.setString(1, username);
	        pstmt.setString(2, hashedPassword);
	        pstmt.setString(3, email);
	        pstmt.setString(4, superuser);
	        
	        int count = pstmt.executeUpdate();
	        
	        if (count > 0) {
	        	response.sendRedirect("admin_add_account.jsp?status=success");
	        } else {
	        	response.sendRedirect("admin_add_account.jsp?status=failure");
	        }
	        conn.close();
	    } catch(Exception e) {
	        System.err.println("Error: " + e);
	    }
    }
%>