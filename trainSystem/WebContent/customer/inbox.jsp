<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Open Questions</title></head>
<body>
<h2>Representative Inbox</h2>

<c:if test="${empty open}">
    <p>No open questions.</p>
</c:if>

<c:forEach var="q" items="${open}">
  <div style="border:1px solid #ccc;padding:8px;margin:8px 0;">
    <p><b>ID:</b> ${q.ques_id}</p>
    <p>${q.question}</p>
    <form action="${pageContext.request.contextPath}/reply" method="post">
        <input type="hidden" name="ques_id" value="${q.ques_id}">
        <textarea name="reply" rows="3" cols="60"
                  placeholder="Type your reply…"></textarea><br>
        <button>Send Reply</button>
    </form>
  </div>
</c:forEach>
</body>
</html>
