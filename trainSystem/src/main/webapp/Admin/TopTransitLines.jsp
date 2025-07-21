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
    <title>Top 5 Most Active Transit Lines (This Month)</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .container { max-width: 700px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
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
        <h2>Top 5 Most Active Transit Lines (This Month)</h2>
        <table>
            <tr>
                <th>Transit Line Name</th>
                <th>Transit Line ID</th>
                <th>Number of Reservations</th>
            </tr>
            <%
            try {
                String sql = "SELECT t.transit_name, t.transit_id, COUNT(r.res_num) AS num_reservations " +
                             "FROM TransitLine t JOIN Reservation r ON t.transit_id = (SELECT ts.transit_id FROM TrainSchedule ts WHERE ts.trainschedule_id = r.schedule_id) " +
                             "WHERE MONTH(r.res_date) = MONTH(CURDATE()) AND YEAR(r.res_date) = YEAR(CURDATE()) " +
                             "GROUP BY t.transit_id, t.transit_name " +
                             "ORDER BY num_reservations DESC LIMIT 5";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                boolean hasResults = false;
                while (rs.next()) {
                    hasResults = true;
            %>
            <tr>
                <td><%= rs.getString("transit_name") %></td>
                <td><%= rs.getString("transit_id") %></td>
                <td><%= rs.getInt("num_reservations") %></td>
            </tr>
            <%
                }
                if (!hasResults) {
            %>
            <tr><td colspan="3">No data found for this month.</td></tr>
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