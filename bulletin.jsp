

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



<%-- 
  Execute query, with wildcard characters added to the
  parameter values used in the search criteria
--%>
<sql:query var="empList" dataSource="jdbc/TestDB" scope="request">
  SELECT b.id, b.title, b.message, c.name  FROM bulletin2 b, category2 c 
    WHERE b.category=c.id 
    ORDER BY create_time desc

</sql:query>

<sql:query var="catList" dataSource="jdbc/TestDB" scope="request">
  SELECT * FROM category2 
    ORDER BY id

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
  <li><a href="loggedin.jsp">Back</a></li>
  

<li style="float:right"><a href="logout.jsp">Logout</a></li>
</ul>

<html>
<head><title> Bulletin </title></head>
<body>

<form action = "bulletin-add-new.jsp">
<h1>Add an Annoucement</h1>

<font color="red">
  ${fn:escapeXml(param.errorMsg)}
</font>

<table>
	<tr>
		<th>Category</th>
		<th>Title</th>
		<th>Message</th>
	</tr>
	<tr>
		<td>
			<select name="category">
			    <option value="0" disabled="disabled" selected="selected">Please select a category.</option>
			
			
			
			<c:forEach items="${catList.rows}" var="catrow">
				<option value=${fn:escapeXml(catrow.id)}>${fn:escapeXml(catrow.name)}</option>
			
			 </c:forEach>
			
			
			
			
			</select>
		</td>
		<td><textarea name="title" cols="40" rows="5"></textarea></td>
		<td><textarea name="message" cols="60" rows="5"></textarea></td>
	</tr>
</table>
<input type="submit" value="Add to Bulletin" />
</form>

</br>
<hr>

<h1>Bulletin</h1>
<font color="red">
  ${fn:escapeXml(param.reminderMsg)}
</font>

<table border="1">
	<tr>
		<th>Category</th>
		<th>Title</th>
		<th>Message</th>
		<th></th>
		<th>List of Notifications</th>
		<th>Delete</th>
	</tr>
	
<c:forEach items="${empList.rows}" var="row">	
<sql:query var="notificationList" dataSource="jdbc/TestDB" scope="request">
  		SELECT * FROM notification2 WHERE uniqueid = ? ORDER BY create_time desc
			<sql:param value="bulletin ${fn:escapeXml(row.id)}" /> 
		</sql:query>
	<tr>
		<td><textarea readonly cols="27" rows="5">${fn:escapeXml(row.name)}</textarea></td>
		
		
		<td><textarea readonly cols="40" rows="5">${fn:escapeXml(row.title)}</textarea></td>
		<td><textarea readonly cols="60" rows="5">${fn:escapeXml(row.message)}</textarea></td>
		

		<td>
						

							<form action="bulletin-add-notification.jsp" method="post">
						<textarea placeholder="Enter push notification message." name="message" cols="25" rows="2.5"></textarea>
						  <input type="hidden" name="bulletinid"
						    value="${fn:escapeXml(row.id)}">
						</br>
							<input type="submit" style="color: red" value="Add Notification">
					    </form>
					</td>
					<td>
							<form action="bulletin-notification-delete.jsp" method="post">
							<input type="hidden" name="bulletinid"
						    value="${fn:escapeXml(row.id)}">
							<input type="submit" style="color: red" value="Clear List">
						</form>
						
							<c:forEach items="${notificationList.rows}" var="notificationRow">	
								<li>${fn:escapeXml(notificationRow.message)}</li>
								</br>
							</c:forEach>
					</td>
					<td>
			<form action="bulletin-delete.jsp" method="post">
			  <input type="hidden" name="bulletinid"
			    value="${fn:escapeXml(row.id)}">
				<input type="submit" value="delete">
		    </form>
		</td>
	
	</tr>
</c:forEach>
</table>





	</body>
	</html>	



