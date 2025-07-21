<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Here</title>
</head>

<body>
	<h2>Login</h2>
    

    <form method="post" action="LoginCheck.jsp">
        Username: <input type="text" name="username" required /><br>
        Password: <input type="password" name="password" required /><br>
        <input type="submit" value="Login" />
    </form>
    
    Not registered? Register 
    <a href="registerpage.jsp">here</a>.
    
    <a href="Admin/AdminDashboard.jsp">admin</a>
</body>
</html>