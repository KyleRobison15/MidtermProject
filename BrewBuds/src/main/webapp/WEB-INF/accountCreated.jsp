<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>
<%-- <%@ include file="footer.jsp"%> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success!</title>
</head>
<body>
	
	<div class="container">
		<h1 class="display-4">Success! Welcome to BrewBuds ${newUser.username }.</h1>
		<a class="btn btn-outline-dark" href="loginPage.do">Log In</a>
	</div>
	
</body>
</html>