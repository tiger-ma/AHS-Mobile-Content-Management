<%@ page contentType="text/html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<c:set var = "tabValue" value ="${param.tab}" />
<jsp:useBean id="tabValue" type="java.lang.String" />


<%	
	if (tabValue.equals("home"))
	{
	%>
		<c:redirect url="home.jsp" >
		</c:redirect>
   <%
	
	} else if (tabValue.equals("notification"))
	{
	%>
		<c:redirect url="notification.jsp" >
		</c:redirect>
	<%
	}
%>






