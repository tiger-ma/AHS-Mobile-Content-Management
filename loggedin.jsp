<%@ page language="java" contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--<ora:ifUserInRole value="admin" var="isAdmin" /> --%>

<%-- Verify that the user is logged in --%>
<c:if test="${validUser == null}">
  <jsp:forward page="login.jsp">
    <jsp:param name="origURL" value="${pageContext.request.requestURL}" />
    <jsp:param name="errorMsg" value="Please log in first." />
  </jsp:forward>
</c:if>



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
	<li><a href="home-approval-system.jsp"> Home Page Approval System </a></li>
  	<li style="float:right"><a href="logout.jsp">Logout</a></li>
</ul>




<html>
<head><title>Arcadia High Mobile Content Editing System</title></head>
<body>

	
<h1>Arcadia High Mobile Content Editing System</h1>



<form action = "tab-selection.jsp">
	Select a tab to edit. 
	

	
</br>
</br>
  <input type="radio" name="tab" value="feed" checked /> Feed 
</br>
	<input type="radio" name="tab" value="district" /> District
</br>
	<input type="radio" name="tab" value="bulletin" /> Bulletin
</br>
</br>
	<input type="submit" value ="Select"/>
</form>

<hr>

</body>
</html>