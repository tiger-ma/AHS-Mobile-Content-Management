<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>


<%-- Verify that the user is logged in --%>
<c:if test="${validUser == null}">
	<c:redirect url="../index.jsp" />
</c:if>

<%-- 
  Send unencrypted password by email.
--%>

<c:set var="mailsubject" value="AHS Mobile Content Request"/>

<c:set var="mailfrom" value="no_reply@ausd.net"/>

<c:set var="mailto" value="tigertengma@gmail.com"/>

<%-- 
  construct mail content.
    	String mailcontent= "Hi "+fname +
    	": \n\nAn account has been established for you. Your login name is your email address and your pass word is: "
	+ newPass 
	+ "\n\nPlease follow the link on the page of http://minerals.gps.caltech.edu/ to the online system."
	+ "\n\n- "+mailsubject;

--%>




<c:set var="mailcontent" value="TEST MESSAGE"/>
	
		      
<jsp:forward page="/PostMailServlet" >
	<jsp:param name="mailcontent" value="${mailcontent}" />
  	<jsp:param name="mailfrom" value="${mailfrom}" />
  	<jsp:param name="mailto" value="${mailto}" />
  	<jsp:param name="mailsubject" value="${mailsubject}" />
</jsp:forward>
