<%@ page language="java" contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- Verify that the user is logged in --%>
<c:if test="${validUser == null}">
  <jsp:forward page="login.jsp">
    <jsp:param name="origURL" value="${pageContext.request.requestURL}" />
    <jsp:param name="errorMsg" value="Please log in first." />
  </jsp:forward>
</c:if>

<sql:query var="empList" dataSource="jdbc/TestDB" scope="request">
  SELECT * FROM notification2 
    ORDER BY create_time desc 
</sql:query>
<style>
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333;
}

li {
    float: left;
}

li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

li a:hover {
    background-color: #111;
}
</style>



<ul>
  <li><a href="notification.jsp">Back</a></li>
<li style="float:right"><a href="logout.jsp">Logout</a></li>
</ul>

<html>
<head><title> Request Notification </title></head>
<body>
	<form action = "complex-notification-add-new.jsp">

	<h1>Request a Notification to Notification Page</h1>

	<font color="red">
	  ${fn:escapeXml(param.errorMsg)}
	</font>

	<table>
		<tr>
			<th>Preferred Send Date</th>
			<th>Preferred Send Time</th>
			<th>Summary</th>
			<th>Full Message</th>
		</tr>
		<tr>
			<td><textarea name="senddate" cols="30" rows="5"></textarea></td>
			<td><textarea name="sendtime" cols="30" rows="5"></textarea></td>
			<td><textarea name="summary" cols="60" rows="5"></textarea></td>
			<td><textarea name="message" cols="60" rows="5"></textarea></td>
			
		</tr>
		</table>
		<input type="submit" value="Request to Notification Page" />
		</form>
		
	</br>
	<hr>
	<h1>Notification Page</h1>



		<table>
			<tr>
				<th>Type</th>
				<th>Summary</th>
				<th>Message</th>
				<th>Delete</th>
			</tr>

			<c:forEach items="${empList.rows}" var="row">	
				<tr>
						<td><textarea readonly cols="20" rows="5">${fn:escapeXml(row.type)}</textarea></td>
						<td><textarea readonly cols="20" rows="5">${fn:escapeXml(row.summary)}</textarea></td>
						<td><textarea readonly cols="40" rows="5">${fn:escapeXml(row.message)}</textarea></td>
						<td>
							<form action="notification-delete.jsp" method="post">
							  <input type="hidden" name="notificationid"
							    value="${fn:escapeXml(row.id)}">
								<input type="submit" value="delete">
						    </form>
						</td>
				</tr>
			</c:forEach>
			</table>

	</body>
	</html>




