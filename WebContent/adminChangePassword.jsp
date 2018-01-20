<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.*" %>
<%
String username         = request.getParameter("username");
String oldPassword      = request.getParameter("old_password");
String newPassword      = request.getParameter("new_password");
if(session.getAttribute("superuser") == null) {
    response.sendRedirect("401.html");
} else {
	try{
	    Class.forName("com.mysql.jdbc.Driver");
	
	    String connURL              = "jdbc:mysql://localhost/spmovy?user=root&password=root";
	    Connection conn             = DriverManager.getConnection(connURL);
	
	    String getCredentials     = "SELECT password FROM admin_login WHERE username=?";  
	    PreparedStatement pstmt     = conn.prepareStatement(getCredentials);
	    
	    pstmt.setString(1, username);
	    
	    ResultSet rs = pstmt.executeQuery();
	    if (rs.isBeforeFirst()) {
	        rs.next();
	        String password = rs.getString("password");
	        if (BCrypt.checkpw(oldPassword+username, password)) {
	            String newHashedPassword   = BCrypt.hashpw(newPassword+username, BCrypt.gensalt(12));
	            String updateCredentials     = "UPDATE admin_login SET password=? WHERE username=?";  
	            PreparedStatement updateCred = conn.prepareStatement(updateCredentials);
	            updateCred.setString(1, newHashedPassword);
	            updateCred.setString(2, username);
	            updateCred.executeUpdate();
	            response.sendRedirect("admin_change_password.jsp?status=success");
	        } else {
	            response.sendRedirect("admin_change_password.jsp?status=failure");
	        }
	        
	
	    } else {
	    	response.sendRedirect("admin_change_password.jsp?status=failure");
	    }
	
	} catch(Exception e) {
	    System.err.println("Error: " + e);
	}
}

%> 