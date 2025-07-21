<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .dashboard-container {
            max-width: 500px;
            margin: 60px auto;
            background: #fff;
            padding: 40px 30px 30px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .admin-links {
            display: flex;
            flex-direction: column;
            gap: 18px;
            margin-top: 30px;
        }
        .admin-links a, .admin-links button {
            display: block;
            padding: 14px;
            background: #1976d2;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background 0.2s;
        }
        .admin-links a:hover, .admin-links button:hover {
            background: #125ea2;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
    <a href='../logoutpage.jsp'>Log out</a>
        <h1>Admin Dashboard</h1>
        <div class="admin-links">
            <a href="AddRep.jsp">Add Customer Representative</a>
            <a href="EditRep.jsp">Edit Customer Representative</a>
            <a href="DeleteRep.jsp">Delete Customer Representative</a>
            <a href="SalesReport.jsp">Monthly Sales Report</a>
            <a href="ReservationsByTransitLine.jsp">Reservations by Transit Line</a>
            <a href="ReservationsByCustomer.jsp">Reservations by Customer</a>
            <a href="RevenueByTransitLine.jsp">Revenue by Transit Line</a>
            <a href="RevenueByCustomer.jsp">Revenue by Customer</a>
            <a href="BestCustomer.jsp">Best Customer</a>
            <a href="TopTransitLines.jsp">Top 5 Most Active Transit Lines</a>
        </div>
    </div>
</body>
</html>