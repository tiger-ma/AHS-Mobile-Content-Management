<%@ page contentType="text/html" %>
<%@ taglib prefix ="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${empty param.username || empty param.password}">
  <c:redirect url="login.jsp" >
    <c:param name="errorMsg" 
      value="You must enter a User Name and Password." />
  </c:redirect>
</c:if>

	<c:set var="psCode" value="${param.password}"/>
	<jsp:useBean id="psCode" type="java.lang.String" />
	<c:set var="psCode" value="<%= Integer.toString(psCode.hashCode()) %>"/>
	
	<c:catch var="error">
		<sql:query var="empInfo" dataSource="jdbc/TestDB">
		  SELECT * FROM editor 
		    WHERE username = ? AND password = ? AND role='3'
		  <sql:param value="${param.username}" />
		  <sql:param value="${psCode}" />
		</sql:query>
    </c:catch>	
		

		<c:if test="${empInfo.rowCount == 0}">
		  <c:redirect url="login.jsp" >
		    <c:param name="errorMsg" value="The username or password you entered is not valid."/>
            </c:redirect>
		</c:if>
	

		<c:set var="validUser" value="${empInfo.rows[0].username}"  />	
		<jsp:useBean id="validUser" scope="session"
		  class="java.lang.String" />
		
		<%-- 
		  Redirect to the main page or to the original URL, if
		  invoked as a result of a access attempt to a protected
		  page.
		--%>
		<c:choose>
		  <c:when test="${!empty param.origURL}">
		    <c:redirect url="${param.origURL}" />
		  </c:when>
		  <c:otherwise>
		    <c:redirect url="loggedin.jsp" />
		  </c:otherwise>
		</c:choose>
			
	
