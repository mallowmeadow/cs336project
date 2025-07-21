<%@ page import ="java.sql.*" %>
<%
String usern = request.getParameter("username");
String pass = request.getParameter("password");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336projectdb","root",
"password");
Statement stmt = con.createStatement();
ResultSet rs;
rs = stmt.executeQuery("select * from customer where username='" + usern + "' and pass='" + pass + "'");
if (rs.next()) {
	session.setAttribute("user", usern);
	session.setAttribute("role", "customer");
	out.println("welcome " + usern);
	out.println("<a href='logout.jsp'>Log out</a>");
	response.sendRedirect("LoginSuccess.jsp");
}
else {
	String sql = "SELECT employee_role FROM employee WHERE username = ? AND pass = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, usern);
	ps.setString(2, pass);
	ResultSet res = ps.executeQuery();
	if (res.next()){
		String role = res.getString("employee_role");
		session.setAttribute("user", usern);
		session.setAttribute("role", role);
		if ("Manager".equals(role)) response.sendRedirect("Admin/AdminDashboard.jsp");
		
		//This is waiting on a customer representative landing page.
		else response.sendRedirect("customer/dashboard.jsp");
		//if session.getAttribute("role").equals("Manager") response.sendRedirect("adminDashboard.jsp");
		//else if session.getAttribute("role").equals("Employee") response.sendRedirect("");
	}
	else {
		out.println("Invalid username or password <a href='login.jsp'>try again</a>");
	}
}
%>