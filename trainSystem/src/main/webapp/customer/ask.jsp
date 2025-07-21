<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Ask a Question</title></head>
<body>
<h2>Contact Customer Service</h2>

<form action="${pageContext.request.contextPath}/ask" method="post">
    <input type="hidden" name="customer"
           value="${sessionScope.userId /* set at login */}">
    Subject: <input name="subject" size="40"><br><br>
    Question:<br>
    <textarea name="question" rows="6" cols="60"></textarea><br><br>
    <button type="submit">Send</button>
</form>

<a href="faq.jsp">Back to FAQ</a>
</body>
</html>
