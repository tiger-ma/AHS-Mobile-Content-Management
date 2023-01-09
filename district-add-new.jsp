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

<c:if test="${ empty param.org || empty param.title || empty param.author || empty param.date || empty param.article}">
  <c:redirect url="district.jsp" >
    <c:param name="errorMsg" 
      value="You must add at least a type, organiztion, title, author, date, and message." />
  </c:redirect>
</c:if>

  

	
	<c:set var="org" value="${param.org}"/>
	<jsp:useBean id="org" type="java.lang.String" />
	
	<c:set var="title" value="${param.title}"/>
	<jsp:useBean id="title" type="java.lang.String" />
		
	<c:set var="author" value="${param.author}"/>
	<jsp:useBean id="author" type="java.lang.String" />
	
	<c:set var="date" value="${param.date}"/>
	<jsp:useBean id="date" type="java.lang.String" />
	
	<c:set var="caption" value="${param.caption}"/>
	<jsp:useBean id="caption" type="java.lang.String" />
	
	<c:set var="article" value="${param.article}"/>
		<jsp:useBean id="article" type="java.lang.String" />
	 <%--       <c:set var="article" value="<%= SpecialCharUtils.replaceSpecialChar(article) %>"/> --%>
	
	<c:catch var="error">
	<sql:transaction dataSource="jdbc/TestDB">
		<sql:update >
		  insert into district (org, title, author, date, caption, article, create_time, status) values (?, ?, ?, ?, ?, ?, sysdate(), '1')
		
		<sql:param value="${param.org}" />  
		<sql:param value="${param.title}" />
		<sql:param value="${param.author}" />
		<sql:param value="${param.date}" />  
		<sql:param value="${param.caption}" />  
		<sql:param value="${param.article}" />  
		
		</sql:update>
		
		</sql:transaction>
	
    </c:catch>	
		





		<c:redirect url="district.jsp" >
		<c:param name="reminderMsg" 
	      value="After you finish updating the home page, add a home update notification to notification page (tab at the top)." />
            </c:redirect> 


