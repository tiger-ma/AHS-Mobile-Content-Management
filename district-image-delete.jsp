<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Verify that the user is logged in --%>
<c:if test="${validUser == null}">
  <jsp:forward page="login.jsp">
    <jsp:param name="origURL" value="${pageContext.request.requestURL}" />
    <jsp:param name="errorMsg" value="Please log in first." />
  </jsp:forward>
</c:if>

<sql:update dataSource="jdbc/TestDB" >
  DELETE FROM image 
    WHERE uniqueid = ?
  <sql:param value="district ${param.districtid}" />
</sql:update>

<c:redirect url="district.jsp">
  <%--<c:param name="userName" 
    value="${param.userName}" />  --%>
</c:redirect>
