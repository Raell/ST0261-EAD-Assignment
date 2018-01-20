<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.*" %>
<%
String username         = request.getParameter("username");
String password         = request.getParameter("password");
String testPassword;

try{
    Class.forName("com.mysql.jdbc.Driver");

    String connURL              = "jdbc:mysql://localhost/spmovy?user=root&password=root";
    Connection conn             = DriverManager.getConnection(connURL);

    String checkCredentials     = "SELECT password, superuser FROM admin_login WHERE username=?";  
    PreparedStatement pstmt     = conn.prepareStatement(checkCredentials);
    
    pstmt.setString(1, username);
    
    ResultSet rs = pstmt.executeQuery();
    if (rs.isBeforeFirst()) {
        rs.next();
        testPassword = rs.getString("password");
        
        if (BCrypt.checkpw(password+username, testPassword)) {
            response.sendRedirect("admin_menu.jsp");
            session.setAttribute("superuser", rs.getString("superuser"));
            session.setAttribute("username", username);
        } else {
            response.sendRedirect("admin_login.jsp?status=failure");
        }
    }else {
        response.sendRedirect("admin_login.jsp?status=failure");
    }

} catch(Exception e) {
    System.err.println("Error: " + e);
}
%>