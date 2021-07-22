<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%> 
<%@ include file="nav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<link href="css/reviewsPage.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Beer Reviews</title>
</head>
<body>
<h2>Beer Reviews:</h2>

<div class="container">
<c:choose>
<c:when test="${!empty beers}">
		<table class="table">
			<thead> 
				<tr>
				<th>Beer</th>
				<th>Brewery</th>
				<th>Description</th>
				<th>Style</th>
				<th>User</th>
				<th>Rating</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="beer" items="${beers}">
				<tr>
		 		<td><a href="beerProfile.do?id=${beer.id}">${beer.name}</a></td>
		 		<td><a href="BreweryInfo.do?id=${beer.brewery.id}">${beer.brewery.name}</a></td>
		 		<td>${beer.description}</td>
				<td>${beer.subCategory.name}</td>
				<td>${beer.user.username}</td>
				
					<c:forEach var="rating" items="${ratings}">
					<td>${beer.rating.rating}</td>
					</c:forEach>
					
				</c:forEach>
			</tbody>
		</table>
</c:when>

<c:otherwise>
	<p>No Reviews Found</p>
</c:otherwise>

</c:choose>
</div>

<p>${beers.size()} Reviews Found</p>

<br>
<form action="home.do" method="get"><input class="input-button" type="submit" value="Go to Home"></form>
	


</body>
</html>