<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.trainSystem.pkg.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
String message = "";
if (request.getMethod().equalsIgnoreCase("POST")) {
    String ssn = request.getParameter("ssn");
    String fname = request.getParameter("employee_firstname");
    String lname = request.getParameter("employee_lastname");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if (ssn != null && fname != null && lname != null && username != null && password != null) {
        try {
            usersystem sym = new usersystem();
            Connection con = sym.getConnection();
            String sql = "INSERT INTO Employee (ssn, employee_firstname, employee_lastname, username, pass, employee_role) VALUES (?, ?, ?, ?, ?, 'rep')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, ssn);
            ps.setString(2, fname);
            ps.setString(3, lname);
            ps.setString(4, username);
            ps.setString(5, password);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                message = "Customer Representative added successfully!";
            } else {
                message = "Failed to add representative.";
            }
            ps.close();
            con.close();
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    } else {
        message = "All fields are required.";
    }
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Customer Representative</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .form-container { max-width: 400px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; }
        label { display: block; margin-top: 15px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 8px; margin-top: 5px; border-radius: 4px; border: 1px solid #ccc; }
        input[type="submit"] { margin-top: 20px; width: 100%; padding: 10px; background: #1976d2; color: #fff; border: none; border-radius: 4px; font-size: 1em; cursor: pointer; }
        input[type="submit"]:hover { background: #125ea2; }
        .message { text-align: center; color: green; margin-top: 15px; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add Customer Representative</h2>
        <% if (!message.equals("")) { %>
            <div class="message <%= message.startsWith("Error") || message.startsWith("Failed") ? "error" : "" %>"><%= message %></div>
        <% } %>
        <form method="post" action="AddRep.jsp">
            <label for="ssn">SSN:</label>
            <input type="text" id="ssn" name="ssn" required />
            <label for="employee_firstname">First Name:</label>
            <input type="text" id="employee_firstname" name="employee_firstname" required />
            <label for="employee_lastname">Last Name:</label>
            <input type="text" id="employee_lastname" name="employee_lastname" required />
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required />
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required />
            <input type="submit" value="Add Representative" />
        </form>
        <div style="text-align:center; margin-top:20px;">
            <a href="AdminDashboard.jsp">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
