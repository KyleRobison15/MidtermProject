<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username }</title>
</head>
<body>

<!-- Display User's Basic Information -->
<!-- Display User's Rating (getAverageUserRating method in RatingDAOImpl)-->
<!-- Display User's Rating (getAverageUserRating method in RatingDAOImpl)-->

	<div class="container">
		${user}
	</div>
	
	<a class="btn btn-outline-dark" href="addBeerPage.do">Add a Beer</a>
	
</body>
</html>