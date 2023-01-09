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
  SELECT * FROM home WHERE status='1'
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
 
  <li style="float:right"><a href="logout.jsp">Logout</a></li>
</ul>







<html>
<head>
	<META http-equiv="Content-Type" content="text/html;charset=UTF-8">
	
	<title> Home Page </title></head>
<body>





<form action = "home-add-new.jsp">
	<h1>Request a New Article to Home Page</h1>

	<font color="red">
	  ${fn:escapeXml(param.errorMsg)}
	</font>
	


<table>
	<tr>
		<th>Image Link</th>
		<th>Title</th>
		<th>Author</th>
		<th>Date Published</th>
		<th>Caption</th>
		<th>Full Article</th>
	</tr>
	<tr>
		<td><textarea name="link" cols="20" rows="5"></textarea></td>
		<td><textarea name="title" cols="20" rows="5"></textarea></td>
		<td><textarea name="author" cols="20" rows="5"></textarea></td>
		<td><textarea name="date" cols="20" rows="5"></textarea></td>
		<td><textarea name="caption" cols="20" rows="5"></textarea></td>
		<td><textarea name="article" cols="40" rows="5"></textarea></td>
	</tr>
</table>

<input type="submit" value="Request to Home Page" />
</form>

<form action="requestEmail.jsp" method="post">
  <input type="submit" value="Send email to notify appteam to review request.">  
 </form>

<font color="red">
  ${fn:escapeXml(param.reminderMsg)}
</font>

</br>
<hr>

<h1>Home Page</h1>



	<table>
		<tr>
			<th>Image Link</th>
			<th>Title</th>
			<th>Author</th>
			<th>Date Published</th>
			<th>Caption</th>
			<th>Full Article</th>
		
		</tr>
	
		<c:forEach items="${empList.rows}" var="row">	
			<tr>
					<td><textarea readonly cols="20" rows="5">${fn:escapeXml(row.link)}</textarea></td>
					<td><textarea readonly cols="20" rows="5">${fn:escapeXml(row.title)}</textarea></td>
					<td><textarea readonly cols="20" rows="5">${fn:escapeXml(row.author)}</textarea></td>
					<td><textarea readonly cols="20" rows="5">${fn:escapeXml(row.date)}</textarea></td>
					<td><textarea readonly cols="20" rows="5">${fn:escapeXml(row.caption)}</textarea></td>
					<td><textarea readonly cols="40" rows="5">${fn:escapeXml(row.article)}</textarea></td>
					
			</tr>
		</c:forEach>
		</table>


	


</body>
</html>