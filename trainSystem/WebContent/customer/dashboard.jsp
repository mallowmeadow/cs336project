<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Service Dashboard</title>
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
    <br>
    Welcome to work, <% session.getAttribute("user");%>
        <h1>Customer Service Dashboard</h1>
        <div class="admin-links">
            <a href="ask.jsp">Ask</a>
            <a href="faq.jsp">FAQs</a>
            <a href="inbox.jsp">Inbox</a>
            <a href="repReports.jsp">Reports</a>
            <a href="repSchedule.jsp">Schedule</a>
        </div>
    </div>
</body>
</html>