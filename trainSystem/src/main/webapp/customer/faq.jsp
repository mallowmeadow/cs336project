<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>FAQ</title></head>
<body>
<h2>Frequently Asked Questions</h2>

<!-- search bar -->
<form action="${pageContext.request.contextPath}/searchFAQ" method="get">
    <input name="kw" placeholder="keyword">
    <button type="submit">Search</button>
</form>
<a href="ask.jsp">Ask a new question</a>
<hr>

<!-- answered questions -->
<c:if test="${empty list}">
    <p>No results.</p>
</c:if>
<c:forEach var="q" items="${list}">
    <h3>${q.question}</h3>
    <p><b>Answer:</b> ${q.reply}</p>
    <hr>
</c:forEach>
</body>
</html>
