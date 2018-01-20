<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    session.setAttribute("username", null);
    session.setAttribute("superuser", null);
    session.invalidate();
    response.sendRedirect("admin_login.jsp");
%>