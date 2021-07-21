<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username }Add</title>
</head>
<body>

	<div class="container"><h1 class="display-3">${rating }</h1></div>

	<div class="container">
		<h1 class="display-4">Your Beers</h1>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Brewery</th>
					<th scope="col">Beer</th>
					<th scope="col">Beer Rating</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${addedBeers }" var="addedBeer">
					<tr>
						<td><a href="BreweryInfo.do?id=${addedBeer.brewery.id }">${addedBeer.brewery.name}</a></td>
						<td><a href="beerProfile.do?id=${addedBeer.id}">${addedBeer.name}</a></td>
						<td></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<a class="btn btn-outline-dark" href="addBeerPage.do">Add a Beer</a>

</body>
</html>