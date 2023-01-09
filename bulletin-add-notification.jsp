<%@page pageEncoding="UTF-8" language="java" import="java.sql.*"%>
<html><head><META http-equiv="Content-Type" content="text/html;charset=UTF-8"></head><body>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix ="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--%><%@ page import="com.tiger.*" %>--%>


<%-- Verify that the user is logged in --%>
<c:if test="${validUser == null}">
  <jsp:forward page="login.jsp">
    <jsp:param name="origURL" value="${pageContext.request.requestURL}" />
    <jsp:param name="errorMsg" value="Please log in first." />
  </jsp:forward>
</c:if>

<c:if test="${empty param.message}">
  <c:redirect url="bulletin.jsp" >
    <c:param name="errorMsg" 
      value="You must add at least a link, title, author, date and message." />
  </c:redirect>
</c:if>







	<c:set var="message" value="${param.message}"/>
	<jsp:useBean id="message" type="java.lang.String" />
	
	
	
	<c:catch var="error">
	<sql:transaction dataSource="jdbc/TestDB">
		<sql:update >
		
		 
		
		  insert into notification2 (uniqueid, message, create_time) values (?, ?, sysdate())
		
		<sql:param value="bulletin ${param.bulletinid}" /> 
		<sql:param value="${param.message}" />  
		
		
		</sql:update>
		
		</sql:transaction>
	
    </c:catch>	

	
		





		<c:redirect url="bulletin.jsp" >
		<c:param name="reminderMsg" 
	      value="After you finish updating the home page, add a home update notification to notification page (tab at the top)." />
            </c:redirect> 


