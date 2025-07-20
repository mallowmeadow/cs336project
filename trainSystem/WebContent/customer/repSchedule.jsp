<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Edit / Delete Schedules</title></head>
<body>
<h2>Train Schedules</h2>

<table border="1" cellpadding="4">
<tr>
  <th>ID</th><th>Depart</th><th>Arrive</th><th>Fare</th><th>Actions</th>
</tr>
<c:forEach var="s" items="${allSchedules}">
<tr>
  <td>${s.trainschedule_id}</td>
  <td>${s.departure_datetime}</td>
  <td>${s.arrival_datetime}</td>
  <td>${s.train_fare}</td>
  <td>
     <!-- edit -->
     <form style="display:inline" action="${pageContext.request.contextPath}/editSchedule" method="post">
        <input type="hidden" name="id" value="${s.trainschedule_id}">
        New depart <input name="departure" size="16"
           placeholder="YYYY-MM-DD HH:MM:SS">
        New arrive <input name="arrival"  size="16">
        Fare <input name="fare" size="5">
        <button>Update</button>
     </form>

     <!-- delete -->
     <form style="display:inline" action="${pageContext.request.contextPath}/deleteSchedule" method="get">
        <input type="hidden" name="id" value="${s.trainschedule_id}">
        <button onclick="return confirm('Delete schedule?')">Delete</button>
     </form>
  </td>
</tr>
</c:forEach>
</table>
</body>
</html>
