<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${empty param.category}">
  <c:redirect url="login.jsp" >
    <c:param name="errorMsg" 
      value="You must provide a category." />
  </c:redirect>
</c:if>


<sql:query var="list" dataSource="jdbc/TestDB" scope="request">
  SELECT * FROM bulletin2 
    WHERE category=?
    ORDER BY create_time desc

<sql:param value="${param.category}" />

</sql:query>

  <json:array>


	<c:set var="hasRow" value="<%= false %>" />
	<jsp:useBean id="hasRow"  class="java.lang.Object" />
	<c:set var="hasRow" value="<%= false %>" />
	
	<c:forEach items="${list.rows}" var="row">
	<c:set var="hasRow" value="<%= true %>" />
    <json:object>
	  <json:property name="id" value="${fn:escapeXml(row.id)}"/>
      <json:property name="title" value="${fn:escapeXml(row.title)}"/>
      <json:property name="message" value="${fn:escapeXml(row.message)}"/>
    </json:object>
	</c:forEach>
	
	
	<c:if test="${hasRow == false}">
	<json:object>
		<json:property name="topic" value=""/>
	    <json:property name="title" value="None"/>
	    <json:property name="message" value="None"/>
	</json:object>
	</c:if>
	
  </json:array>




