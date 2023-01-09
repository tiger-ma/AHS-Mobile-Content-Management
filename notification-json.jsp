
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>









<sql:query var="list" dataSource="jdbc/TestDB" scope="request">
  SELECT uniqueid, message, TIMESTAMPDIFF(MINUTE, create_time, NOW()) as time FROM notification2 
    ORDER BY create_time desc
</sql:query>

<json:array>
	
	<c:forEach items="${list.rows}" var="row">
   <json:object>
      <json:property name="uniqueid" value="${fn:escapeXml(row.uniqueid)}"/> 
	    <json:property name="time" value="${fn:escapeXml(row.time)}"/>
      <json:property name="message" value="${fn:escapeXml(row.message)}"/>
   </json:object>
	</c:forEach>

 </json:array>









