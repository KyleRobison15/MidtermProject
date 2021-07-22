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
		<table class="table table-striped">
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
		 		<td><a href="beerProfile.do?id=${beer.value.id}">${beer.value.name}</a></td>
		 		<td><a href="BreweryInfo.do?id=${beer.value.brewery.id}">${beer.value.brewery.name}</a></td>
		 		<td>${beer.value.description}</td>
				<td>${beer.value.subCategory.name}</td>
				<td>${beer.value.user.username}</td>
				<td>${beer.key}</td>
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