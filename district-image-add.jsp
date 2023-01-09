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

<c:if test="${empty param.link}">
  <c:redirect url="district.jsp" >
    <c:param name="errorMsg" 
      value="You must add at least a link, title, author, date and message." />
  </c:redirect>
</c:if>







	<c:set var="link" value="${param.link}"/>
	<jsp:useBean id="link" type="java.lang.String" />
	
	
	
	<c:catch var="error">
	<sql:transaction dataSource="jdbc/TestDB">
		<sql:update >
		
		 
		
		  insert into image (uniqueid, link, create_time) values (?, ?, sysdate())
		
		<sql:param value="district ${param.districtid}" /> 
		<sql:param value="${param.link}" />  
		
		
		</sql:update>
		
		</sql:transaction>
	
    </c:catch>	

	
		





		<c:redirect url="district.jsp" >
		<c:param name="reminderMsg" 
	      value="After you finish updating the home page, add a home update notification to notification page (tab at the top)." />
            </c:redirect> 


