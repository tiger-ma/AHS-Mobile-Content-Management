<%@ page contentType="text/html" %>
<%@ taglib prefix ="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
		<title>Arcadia High Mobile Request System Login</title>
	</head>
<body>

	<h1>Arcadia High Mobile Request System Login</h1>
	
<p>
    <font color="red">
      ${fn:escapeXml(param.errorMsg)}
    </font>

    

			

<form action = "authenticate.jsp">
	
	<input type="hidden" name="origURL"
		value ="${fn:escapeXml(param.origURL)}"/>
	
	username: <input type="text" name="username"/>
	
	<br/><br/>

	password: 
	
	<input type="password" name="password" />
	
	<br/><br/>

	<input type="submit" value="Submit" />
</form>
<hr>
© 2018 Tiger Ma. All rights reserved.
</body>
</html>
