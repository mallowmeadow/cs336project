<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.trainSystem.pkg.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
usersystem sym = new usersystem();
Connection con = sym.getConnection();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Best Customer</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .container { max-width: 500px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #1976d2; color: #fff; }
        tr:nth-child(even) { background: #f9f9f9; }
        .back-link { display: block; text-align: center; margin-top: 25px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Best Customer</h2>
        <table>
            <tr>
                <th>Full Name</th>
                <th>Username</th>
                <th>Total Revenue</th>
            </tr>
            <%
            try {
                String sql = "SELECT c.first_name, c.last_name, c.username, SUM(r.total_fare) AS revenue " +
                             "FROM Customer c JOIN Reservations r ON c.id = r.customer_id " +
                             "GROUP BY c.id, c.first_name, c.last_name, c.username " +
                             "ORDER BY revenue DESC LIMIT 1";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
                <td><%= rs.getString("username") %></td>
                <td>$<%= rs.getDouble("revenue") %></td>
            </tr>
            <%
                } else {
            %>
            <tr><td colspan="3">No customer data found.</td></tr>
            <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
            %>
            <tr><td colspan="3" style="color:red;">Error: <%= e.getMessage() %></td></tr>
            <% }
            %>
        </table>
        <a class="back-link" href="AdminDashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
