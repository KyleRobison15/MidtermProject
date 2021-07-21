<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="userProfileNav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username } Find</title>
</head>
<body>

<!-- Stretch: Display list of user's favorite beers and breweries -->
<!-- Stretch: Display list of user's added beers and breweries -->

	<div class="container">
		${user.username}
	</div>
	
	<div class="favorites_list">
	
<c:choose>
<c:when test="${!empty beers}">
		<table>
			<thead> 
				<tr>
				<th>Beer</th>
				<th>Brewery</th>
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
				<td>${beer.subCategory.name}</td>
				<td>${beer.user.username}</td>
				
					<c:forEach var="rating" items="${ratings}">
					<td>${beer.rating.rating}
					</c:forEach>
					
				</c:forEach>
			</tbody>
		</table>
		<p>${beers.size()} on your list. Cheers to that!</p>
</c:when>

<c:otherwise>
	<p>0 on your list. Consider adding some!</p>
</c:otherwise>

</c:choose>
	
	
	</div>

</body>
</html>