<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.trainSystem.pkg.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
usersystem sym = new usersystem();
Connection con = sym.getConnection();
String selectedLine = request.getParameter("transit_id");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reservations by Transit Line</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .container { max-width: 800px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; }
        form { text-align: center; margin-bottom: 30px; }
        select { padding: 8px; font-size: 1em; }
        input[type="submit"] { padding: 8px 18px; background: #1976d2; color: #fff; border: none; border-radius: 4px; font-size: 1em; cursor: pointer; margin-left: 10px; }
        input[type="submit"]:hover { background: #125ea2; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #1976d2; color: #fff; }
        tr:nth-child(even) { background: #f9f9f9; }
        .back-link { display: block; text-align: center; margin-top: 25px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reservations by Transit Line</h2>
        <form method="get" action="ReservationsByTransitLine.jsp">
            <label for="transit_id">Select Transit Line:</label>
            <select name="transit_id" id="transit_id" required>
                <option value="">--Select--</option>
                <%
                try {
                    String sql = "SELECT transit_id, transit_name FROM TransitLine";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        String lineId = rs.getString("transit_id");
                        String lineName = rs.getString("transit_name");
                %>
                <option value="<%= lineId %>" <%= (selectedLine != null && selectedLine.equals(lineId)) ? "selected" : "" %>><%= lineName %></option>
                <%
                    }
                    rs.close();
                    ps.close();
                } catch (Exception e) {
                %>
                <option disabled>Error loading lines</option>
                <%
                }
                %>
            </select>
            <input type="submit" value="Show Reservations" />
        </form>
        <%
        if (selectedLine != null && !selectedLine.isEmpty()) {
            try {
                String sql = "SELECT r.res_num, c.first_name, c.last_name, r.origin_id, r.dest_id, r.departure_datetime, r.total_fare " +
                             "FROM Reservation r JOIN Customer c ON r.customer_id = c.customer_id " +
                             "JOIN TrainSchedule ts ON r.schedule_id = ts.trainschedule_id " +
                             "WHERE ts.transit_id = ? ORDER BY r.departure_datetime DESC";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, selectedLine);
                ResultSet rs = ps.executeQuery();
        %>
        <table>
            <tr>
                <th>Reservation #</th>
                <th>Customer Name</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>Departure Time</th>
                <th>Total Fare</th>
            </tr>
            <%
                boolean hasResults = false;
                while (rs.next()) {
                    hasResults = true;
            %>
            <tr>
                <td><%= rs.getString("res_num") %></td>
                <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
                <td><%= rs.getString("origin_id") %></td>
                <td><%= rs.getString("dest_id") %></td>
                <td><%= rs.getString("departure_datetime") %></td>
                <td>$<%= rs.getDouble("total_fare") %></td>
            </tr>
            <%
                }
                if (!hasResults) {
            %>
            <tr><td colspan="6">No reservations found for this transit line.</td></tr>
            <%
                }
                rs.close();
                ps.close();
            } catch (Exception e) {
            %>
            <tr><td colspan="6" style="color:red;">Error: <%= e.getMessage() %></td></tr>
            <%
            }
        }
        %>
        </table>
        <a class="back-link" href="AdminDashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>