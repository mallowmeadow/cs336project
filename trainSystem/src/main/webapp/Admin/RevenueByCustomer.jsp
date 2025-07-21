<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.trainSystem.pkg.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
usersystem sym = new usersystem();
Connection con = sym.getConnection();
String searchName = request.getParameter("customer_name");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reservations by Customer</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .container { max-width: 900px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; }
        form { text-align: center; margin-bottom: 30px; }
        input[type="text"] { padding: 8px; font-size: 1em; width: 250px; }
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
        <h2>Reservations by Customer</h2>
        <form method="get" action="ReservationsByCustomer.jsp">
            <label for="customer_name">Enter Customer Name (First or Last):</label>
            <input type="text" name="customer_name" id="customer_name" value="<%= searchName != null ? searchName : "" %>" required />
            <input type="submit" value="Search" />
        </form>
        <%
        if (searchName != null && !searchName.trim().isEmpty()) {
            try {
                String sql = "SELECT r.res_id, r.transit_id, r.origin_id, r.dest_id, r.departure_datetime, r.arrival_datetime, r.total_fare, c.first_name, c.last_name, c.username " +
                             "FROM Reservation r JOIN Customer c ON r.customer_id = c.customer_id " +
                             "WHERE c.first_name LIKE ? OR c.last_name LIKE ? ORDER BY r.departure_datetime DESC";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, "%" + searchName + "%");
                ps.setString(2, "%" + searchName + "%");
                ResultSet rs = ps.executeQuery();
        %>
        <table>
            <tr>
                <th>Reservation #</th>
                <th>Customer Name</th>
                <th>Username</th>
                <th>Transit Line ID</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
                <th>Total Fare</th>
            </tr>
            <%
                boolean hasResults = false;
                while (rs.next()) {
                    hasResults = true;
            %>
            <tr>
                <td><%= rs.getString("res_id") %></td>
                <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("transit_id") %></td>
                <td><%= rs.getString("origin_id") %></td>
                <td><%= rs.getString("dest_id") %></td>
                <td><%= rs.getString("departure_datetime") %></td>
                <td><%= rs.getString("arrival_datetime") %></td>
                <td>$<%= rs.getDouble("total_fare") %></td>
            </tr>
            <%
                }
                if (!hasResults) {
            %>
            <tr><td colspan="9">No reservations found for this customer.</td></tr>
            <%
                }
                rs.close();
                ps.close();
            } catch (Exception e) {
            %>
            <tr><td colspan="9" style="color:red;">Error: <%= e.getMessage() %></td></tr>
            <%
            }
        }
        %>
        </table>
        <a class="back-link" href="AdminDashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>