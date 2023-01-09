<%@ page contentType="text/html" %>
<%@ taglib prefix ="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Verify that the user is logged in --%>
<c:if test="${validUser == null}">
  <jsp:forward page="login.jsp">
    <jsp:param name="origURL" value="${pageContext.request.requestURL}" />
    <jsp:param name="errorMsg" value="Please log in first." />
  </jsp:forward>
</c:if>


<c:if test="${ empty param.category || empty param.title || empty param.message}">
  <c:redirect url="bulletin.jsp" >
    <c:param name="errorMsg" 
      value="You must select a category and add a title and message." />
  </c:redirect>
</c:if>

  

	<c:set var="category" value="${param.category}"/>
	<jsp:useBean id="category" type="java.lang.String" /> 
	<c:set var="category" value="<%= Integer.parseInt(category) %>"/>
		
	<c:set var="title" value="${param.title}"/>
	<jsp:useBean id="title" type="java.lang.String" />
	
	<c:set var="message" value="${param.message}"/>
	<jsp:useBean id="message" type="java.lang.String" />
	
	<c:catch var="error">
	<sql:transaction dataSource="jdbc/TestDB">
		<sql:update >
		  insert into bulletin2 (category, title, message, create_time) values (?, ?, ?, sysdate())
		
		<sql:param value="${param.category}" />  
		<sql:param value="${param.title}" />
		  <sql:param value="${param.message}" />
		</sql:update>
		
		</sql:transaction>
	
    </c:catch>	
		





		<c:redirect url="bulletin.jsp" >
		<c:param name="reminderMsg" 
	      value="After you finish updating the bulletin, add a bulletin update notification to notification page (tab at the top)." />
            </c:redirect> 


