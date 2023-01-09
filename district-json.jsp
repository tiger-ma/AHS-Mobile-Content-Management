

<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<sql:query var="list" dataSource="jdbc/TestDB" scope="request">
  SELECT * FROM district WHERE status='1'
    ORDER BY create_time desc

</sql:query>


	
	

  <json:array>
	<c:forEach items="${list.rows}" var="row">
	<sql:query var="imageList" dataSource="jdbc/TestDB" scope="request">
  		SELECT * FROM image WHERE uniqueid = ? order by create_time asc
			<sql:param value="district ${fn:escapeXml(row.id)}" /> 
	</sql:query>
    <json:object>
		<json:property name="id" value="${fn:escapeXml(row.id)}"/>
		<json:property name="type" value="${fn:escapeXml(row.type)}"/>
		<json:property name="org" value="${fn:escapeXml(row.org)}"/>
		<json:property name="date" value="${fn:escapeXml(row.date)}"/>
	  	<json:property name="title" value="${fn:escapeXml(row.title)}"/>
	  	<json:property name="author" value="${fn:escapeXml(row.author)}"/>
	  	<json:property name="caption" value="${fn:escapeXml(row.caption)}"/>
      <json:property name="message" value="${fn:escapeXml(row.article)}"/>

		<json:array name="images">
		<c:forEach items="${imageList.rows}" var="smallRow">	
		<json:property>${fn:escapeXml(smallRow.link)}</json:property>
		</c:forEach>	
	  	</json:array>

		
    </json:object>
		</c:forEach>


  </json:array>










