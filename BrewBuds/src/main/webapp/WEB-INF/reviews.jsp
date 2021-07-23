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

<div class="container">
<h2>Beer Reviews:</h2>
 		<c:choose>
			<c:when test="${!empty message }">
				<div class="container">
					<div class="alert alert-primary" role="alert">
  						${message }
					</div>
				</div>
			</c:when>
		</c:choose> 
		
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
				<th>Action</th>
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
					<c:choose>
					<c:when test="${beer.key > 3.9 }"><td><span class="badge badge-success">${beer.key}</span></td></c:when>
					<c:when test="${beer.key < 3.9 && beer.key > 2.5}"><td><span class="badge badge-warning">${beer.key}</span></td></c:when>
					<c:when test="${beer.key < 2.5}"><td><span class="badge badge-danger">${beer.key}</span></td></c:when>
					</c:choose>
				<td>	
					<form action="AddFavoriteReviewsPage.do?id=${beer.value.id}" method="post">
					<input type="submit" value="Add to Favorites"/>
					</form>
				</td>
				</tr>
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

</body>
</html>