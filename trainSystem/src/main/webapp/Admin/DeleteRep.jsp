<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.trainSystem.pkg.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
String message = "";
usersystem sym = new usersystem();
Connection con = sym.getConnection();


// Handle delete action
String deleteSSN = request.getParameter("deleteSSN");
if (deleteSSN != null && !deleteSSN.isEmpty()) {
    try {
        // First, delete all replies for this employee
        String delReplies = "DELETE FROM EmployeeReply WHERE employee_ssn = ?";
        PreparedStatement delRepPs = con.prepareStatement(delReplies);
        delRepPs.setString(1, deleteSSN);
        delRepPs.executeUpdate();
        delRepPs.close();


        // Then, delete the employee
        String delSql = "DELETE FROM Employee WHERE ssn = ? AND (employee_role = 'Employee' OR employee_role = 'Manager')";
        PreparedStatement delPs = con.prepareStatement(delSql);
        delPs.setString(1, deleteSSN);
        int rows = delPs.executeUpdate();
        if (rows > 0) {
            message = "Representative deleted successfully.";
        } else {
            message = "Failed to delete representative.";
        }
        delPs.close();
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Customer Representative</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .table-container { max-width: 800px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #1976d2; color: #fff; }
        tr:nth-child(even) { background: #f9f9f9; }
        .delete-btn { padding: 6px 14px; background: #d32f2f; color: #fff; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .delete-btn:hover { background: #a31515; }
        .back-link { display: block; text-align: center; margin-top: 25px; }
        .message { text-align: center; margin-bottom: 15px; color: green; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="table-container">
        <h2>Delete Customer Representatives</h2>
        <% if (!message.equals("")) { %>
            <div class="message <%= message.startsWith("Error") || message.startsWith("Failed") ? "error" : "" %>"><%= message %></div>
        <% } %>
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
                    <form method="post" action="DeleteRep.jsp" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this representative?');">
                        <input type="hidden" name="deleteSSN" value="<%= rs.getString("ssn") %>" />
                        <input type="submit" value="Delete" class="delete-btn" />
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