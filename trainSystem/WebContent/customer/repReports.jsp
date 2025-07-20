<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Reports</title></head>
<body>
<h2>Quick Reports</h2>

<!-- Schedules for station -->
<form action="${pageContext.request.contextPath}/byStation" method="get">
  Station ID: <input name="station" size="6">
  <button>Show schedules</button>
</form>

<!-- Customers for line + date -->
<form action="${pageContext.request.contextPath}/custByLine" method="get" style="margin-top:15px;">
  Line: <input name="line" size="6">
  Date (YYYY-MM-DD): <input name="date" size="10">
  <button>Show customers</button>
</form>

<hr>

<!-- Results list (if servlet forwarded here) -->
<c:choose>
  <c:when test="${not empty list}">
    <h3>Results</h3>
    <table border="1" cellpadding="4">
      <c:forEach var="row" items="${list}">
        <tr>
          <c:forEach var="val" items="${row.values()}">
            <td>${val}</td>
          </c:forEach>
        </tr>
      </c:forEach>
    </table>
  </c:when>
  <c:otherwise>
    <p>No results loaded yet.</p>
  </c:otherwise>
</c:choose>
</body>
</html>
