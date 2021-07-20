<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="userProfileNav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username } Add</title>
</head>
<body>

	<div class="container">
		${rating }
	</div>

	<a class="btn btn-outline-dark" href="addBeerPage.do">Add a Beer</a>

</body>
</html>