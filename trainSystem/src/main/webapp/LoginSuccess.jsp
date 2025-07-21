<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
Please<a href="index.jsp"> Login</a>
<%} else {
%>
<h2><div style="float: right;"><a href='../logoutpage.jsp'>Log out</a></div></h2>
<br>

Welcome <%=session.getAttribute("user")%>. Happy to have you as a customer.

<%
}
%>