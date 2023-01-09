<%--%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />--%>



<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8" language="java" import="java.sql.*"%>


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
  SELECT * FROM district WHERE status = '1'
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
  <li><a href="loggedin.jsp">Back</a></li>
  <li><a href="home-approval-system.jsp"> Home Page Approval System (includes both feed and district) </a></li>

  <li style="float:right"><a href="logout.jsp">Logout</a></li>
</ul>







<html>
<head>
	<META http-equiv="Content-Type" content="text/html;charset=UTF-8">
	
	<title> District </title></head>
<body>





<form action = "district-add-new.jsp">
	<h1>Add a New District Article/Post to the top of the Home Page.</h1>

	<font color="red">
	  ${fn:escapeXml(param.errorMsg)}
	</font>
	




<table border="1">
	<tr>
		
		<th></th>
		<th><font color="red">Title</font></th>
		<th><font color="red">Author</font></th>
		<th><font color="red">Date Published</font></th>
		<th><font color="red">Caption</font></th>
		<th><font color="red">Full Article</font></th>
		<th></th>
	</tr>
	<tr>
		
		
		<td>
		<select  style="color: red" name="org">
		    <option value="0" disabled="disabled" selected="selected">Please select an organization.</option>
				
				<option value="asb">ASB</option>
				<option value="powwow">POWWOW</option>
				<option value="apn">APN</option>
				<option value="dci">DCI</option>
		
		
		
		</td>
		<td><textarea name="title" cols="20" rows="5"></textarea></td>
		<td><textarea name="author" cols="20" rows="5"></textarea></td>
		<td><textarea name="date" cols="20" rows="5"></textarea></td>
		<td><textarea name="caption" cols="20" rows="5"></textarea></td>
		<td><textarea name="article" cols="40" rows="5"></textarea></td>
		<td>
			<input type="submit" style="color: red" value="Add to Home Page" />
		</td>	
	</tr>
</table>
</br>

</form>


<hr>

<h1>District</h1>

<font color="red">
  ${fn:escapeXml(param.reminderMsg)}
</font>

	<table border="1">
		<tr>
			
			<th></th>
			<th>List of Image Links</th>
			<th>Org</th>
			<th>Title</th>
			<th>Author</th>
			<th>Date</th>
			<th>Caption</th>
			<th>Full Article</th>
			<th></th>
			<th>Notifications</th>
			<th></th>

			
		</tr>
	
		<c:forEach items="${empList.rows}" var="row">	

		<sql:query var="imageList" dataSource="jdbc/TestDB" scope="request">
  		SELECT * FROM image WHERE uniqueid = ? order by create_time asc
			<sql:param value="district ${fn:escapeXml(row.id)}" /> 
		</sql:query>
		<sql:query var="notificationList" dataSource="jdbc/TestDB" scope="request">
  		SELECT * FROM notification2 WHERE uniqueid = ? ORDER BY create_time desc
			<sql:param value="district ${fn:escapeXml(row.id)}" />
		</sql:query>

			<tr>
					
					<td>
						
						<form action="district-image-add.jsp" method="post">
						<textarea placeholder="Enter an image link." name="link" cols="25" rows="2.5"></textarea>
						  <input type="hidden" name="districtid"
						    value="${fn:escapeXml(row.id)}">
						</br>
							<input type="submit" style="color: red" value="Add to List of Image Links">
					    </form>
					</td>
					<td>
						<form action="district-image-delete.jsp" method="post">
							<input type="hidden" name="districtid"
						    value="${fn:escapeXml(row.id)}">
							<input type="submit" style="color: red" value="Clear List">
						</form>
						
							<c:forEach items="${imageList.rows}" var="smallRow">	
								<li>${fn:escapeXml(smallRow.link)}</li>
								</br>
							</c:forEach>
							
							

					</td>
					<td><textarea readonly cols="10" rows="5">${fn:escapeXml(row.org)}</textarea></td>
					<td><textarea readonly cols="10" rows="5">${fn:escapeXml(row.title)}</textarea></td>
					<td><textarea readonly cols="10" rows="5">${fn:escapeXml(row.author)}</textarea></td>
					<td><textarea readonly cols="10" rows="5">${fn:escapeXml(row.date)}</textarea></td>
					<td><textarea readonly cols="10" rows="5">${fn:escapeXml(row.caption)}</textarea></td>
					<td><textarea readonly cols="30" rows="5">${fn:escapeXml(row.article)}</textarea></td>
					
					
					
					<td>
						

							<form action="district-add-notification.jsp" method="post">
						<textarea placeholder="Enter push notification message." name="message" cols="25" rows="2.5"></textarea>
						  <input type="hidden" name="districtid"
						    value="${fn:escapeXml(row.id)}">
						</br>
							<input type="submit" style="color: red" value="Add Notification">
					    </form>
					</td>
					<td>
							<form action="district-notification-delete.jsp" method="post">
							<input type="hidden" name="districtid"
						    value="${fn:escapeXml(row.id)}">
							<input type="submit" style="color: red" value="Clear List">
						</form>
						
							<c:forEach items="${notificationList.rows}" var="notificationRow">	
								<li>${fn:escapeXml(notificationRow.message)}</li>
								</br>
							</c:forEach>
					</td>
				
					<td>
						<form action="district-delete.jsp" method="post">
						  <input type="hidden" name="districtid"
						    value="${fn:escapeXml(row.id)}">
							<input type="submit" style="color: red" value="Delete Article/Post">
					    </form>
					</td>
			</tr>
		</c:forEach>
		</table>


	


</body>
</html>