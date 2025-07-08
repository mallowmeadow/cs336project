<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success! Welcome back</title>
</head>
<body>
usersystem sym = new username();
Connection con = sym.getConnection();

Statement stmt = con.createStatement();
String user = request.getParameter("username");
String pass = request.getParameter("password");
String op = "select * from Customer c where c.username = username";
String op2 = "select * from Customer c where c.pword = password";

You are now logged in.
</body>
</html>