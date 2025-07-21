<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
session.invalidate();
response.sendRedirect("index.jsp");
%>
<title>You have been logged out</title>
</head>
<body>
	<h2>You have been logged out. Thank you for your business.</h2>
	<a href="index.jsp">Return to login page</a>
</body>
</html>
