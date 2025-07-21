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
    <title>Monthly Sales Report</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .table-container { max-width: 600px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #1976d2; color: #fff; }
        tr:nth-child(even) { background: #f9f9f9; }
        .back-link { display: block; text-align: center; margin-top: 25px; }
    </style>
</head>
<body>
    <div class="table-container">
        <h2>Monthly Sales Report</h2>
        <table>
            <tr>
                <th>Year</th>
                <th>Month</th>
                <th>Total Revenue</th>
            </tr>
            <%
            try {
                String sql = "SELECT YEAR(res_date) AS year, MONTH(res_date) AS month, SUM(total_fare) AS revenue FROM Reservation GROUP BY YEAR(res_date), MONTH(res_date) ORDER BY year DESC, month DESC";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("year") %></td>
                <td><%= rs.getInt("month") %></td>
                <td>$<%= rs.getDouble("revenue") %></td>
            </tr>
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