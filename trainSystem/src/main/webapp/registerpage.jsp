<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer registration</title>
</head>
<body>
	<form method="post" action="registerResult.jsp">
        First name: 	<input type="text" name="first_name" required /><br>
        Family name: 	<input type="text" name="last_name" required /><br>
        Username: 	<input type="text" name="username" required /><br>
        Password: 	<input type="password" name="password" required /><br>
        Email: 	<input type="text" name="email" required /><br>
        <input type="submit" value="Register" />
    </form>
</body>
</html>