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

	<div class="container">
		<h1 class="display-4">Your Beers:</h1>
		<ul class="list-group">
			<c:forEach items="${addedBeers }" var="addedBeer">
				<li class="list-group-item"> <a href="BreweryInfo.do?id=${addedBeer.key.brewery.id }">${addedBeer.key.brewery.name}</a> 
				&nbsp; <a href="beerProfile.do?id=${addedBeer.key.id}">${addedBeer.key.name}</a>Rating: ${addedBeer.value}</li> 
			</c:forEach>
		</ul>
	</div>

	<a class="btn btn-outline-dark" href="addBeerPage.do">Add a Beer</a>

</body>
</html>