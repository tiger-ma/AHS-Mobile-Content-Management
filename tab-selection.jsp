<%@ page contentType="text/html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<c:set var = "tabValue" value ="${param.tab}" />
<jsp:useBean id="tabValue" type="java.lang.String" />


<%	
	if (tabValue.equals("feed"))
	{
	%>
		<c:redirect url="feed.jsp" >
		</c:redirect>
   <%
	} else if (tabValue.equals("district"))
	{
	%>
		<c:redirect url="district.jsp" >
		</c:redirect>
   <%
	} else if (tabValue.equals("bulletin")) 
	{
	%>
		<c:redirect url="bulletin.jsp" >
		</c:redirect>
	<%
	}
%>






