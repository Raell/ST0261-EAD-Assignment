<%@ page import="java.util.Properties" %>
<%@ page import="java.util.UUID" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.PasswordAuthentication" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.*" %>
<%
String username         = request.getParameter("username");
String email            = request.getParameter("email");
UUID random             = UUID.randomUUID();

try{
    Class.forName("com.mysql.jdbc.Driver");

    String connURL              = "jdbc:mysql://localhost/spmovy?user=root&password=root";
    Connection conn             = DriverManager.getConnection(connURL);

    String checkCredentials     = "SELECT password FROM admin_login WHERE username=? AND email=?";  
    PreparedStatement pstmt     = conn.prepareStatement(checkCredentials);
    
    pstmt.setString(1, username);
    pstmt.setString(2, email);
    
    ResultSet rs = pstmt.executeQuery();
    if (rs.isBeforeFirst()) {
        String newPassword           = BCrypt.hashpw(random+username, BCrypt.gensalt(12));
        String updateCredentials     = "UPDATE admin_login SET password=? WHERE username=?";  
        PreparedStatement updateCred = conn.prepareStatement(updateCredentials);
        
        updateCred.setString(1, newPassword);
        updateCred.setString(2, username);
        
        updateCred.executeUpdate();
        
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
 
        Session sessionx = Session.getDefaultInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("spmovy.authenticate@gmail.com","@uth3nt1c4t3d");
                }
            });
 
        try {
 
            Message message = new MimeMessage(sessionx);
            message.setFrom(new InternetAddress("spmovy.authenticate@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));
            message.setSubject("SPMovy Password Reset");
            message.setText("Dear " + username + ", " +
                    "\n\n Your new password is:" + random + 
                    "\n\n Please get it changed ASAP via the Admin Panel");
 
            Transport.send(message);
 
            response.sendRedirect("admin_reset_password.jsp?status=success");
 
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    } else {
    	response.sendRedirect("admin_reset_password.jsp?status=failure");
    }

} catch(Exception e) {
    System.err.println("Error: " + e);
}

        
%> 