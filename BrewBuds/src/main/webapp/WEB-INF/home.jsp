<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%> 
<%@ include file="nav.jsp"%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BrewBuds</title>
</head>
<body>

	<div class="container">
		<h1>Cheers! Welcome to BrewBuds</h1>
	</div>
	
<div class = "Beer_Table">
<c:choose>
<c:when test="${!empty beers}">
		<table>
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
				<td>${beer.key.name}</td>
				<td>${beer.key.brewery.name}</td>
				<td>${beer.key.description}</td>
				<td>${beer.key.subCategory.name}</td>
				<td>${beer.key.user.username}</td>
				<td>${beer.value}</td> <!--Average Rating of the Beer -->
				</tr>
				</c:forEach>
<%-- 				<c:forEach var="beer" items="${beers}">
				<tr>
		 		<td><a href="beerProfile.do?id=${beer.id}">${beer.beer.name}</a></td>
		 		<td><a href="BreweryInfo.do?id=${beer.brewery.id}">${beer.brewery.name}</a></td>
		 		<td>${beer.description}</td>
				<td>${beer.subCategory.name}</td>
				<td>${beer.user.username}</td>
				<td>${beer.beerRating}</td>
				</c:forEach> --%>
			</tbody>
		</table>
</c:when>

<c:otherwise>
	<p>No Reviews Found</p>
</c:otherwise>

</c:choose>
</div>
<br>
<div class = "Brewery_Table">
<c:choose>
<c:when test="${!empty breweries}">
		<table>
			<thead> 
				<tr>
				<th>Brewery</th>
				<th>Description</th>
				<th>Rating</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="brewery" items="${breweries}">
				<tr>
		 		<td><a href="BreweryInfo.do?id=${brewery.id}">${brewery.name}</a></td>
				<td>${brewery.description}</td>
				<td>
					<c:forEach var="rating" items="${ratings}">
					<td>${brewery.rating.rating}
					</c:forEach>
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
	
	
<form action="ShowAll.do" method="get">
<input type="submit" value="Show all Reviews">
</form>
	
</body>
</html>