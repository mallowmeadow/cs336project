<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.trainSystem.pkg.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
usersystem sym = new usersystem();
Connection con = sym.getConnection();
String message = "";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer Representative</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .table-container { max-width: 800px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #1976d2; color: #fff; }
        tr:nth-child(even) { background: #f9f9f9; }
        .edit-btn { padding: 6px 14px; background: #1976d2; color: #fff; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .edit-btn:hover { background: #125ea2; }
        .back-link { display: block; text-align: center; margin-top: 25px; }
    </style>
</head>
<body>
    <div class="table-container">
        <h2>Edit Customer Representatives</h2>
        <table>
            <tr>
                <th>SSN</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Username</th>
                <th>Password</th>
                <th>Action</th>
            </tr>
            <%
            try {
                String sql = "SELECT ssn, employee_firstname, employee_lastname, username, pass FROM Employee WHERE employee_role = 'Employee' OR employee_role = 'Manager'";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("ssn") %></td>
                <td><%= rs.getString("employee_firstname") %></td>
                <td><%= rs.getString("employee_lastname") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("pass") %></td>
                <td>
                    <form method="get" action="EditRepForm.jsp" style="display:inline;">
                        <input type="hidden" name="ssn" value="<%= rs.getString("ssn") %>" />
                        <input type="submit" value="Edit" class="edit-btn" />
                    </form>
                </td>
            </tr>
            <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
            %>
            <tr><td colspan="6" style="color:red;">Error: <%= e.getMessage() %></td></tr>
            <% }
            %>
        </table>
        <a class="back-link" href="AdminDashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>