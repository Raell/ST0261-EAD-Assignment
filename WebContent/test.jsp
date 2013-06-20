<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@page import = "java.util.*" %>
<% 
session.setAttribute("blah", 1);

Enumeration e = session.getAttributeNames();
while (e.hasMoreElements()) {
String name = (String)e.nextElement();
String value = session.getAttribute(name).toString();
out.println("name is: " + name + " value is: " + value);
}
%>
</body>
</html>