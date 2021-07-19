<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username }</title>
</head>
<body>

	<div class="container">
		${user}
		<a class="btn btn-outline-dark" href="logout.do">Log Out</a>
	</div>
	
</body>
</html>