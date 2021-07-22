<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BrewBuds</title>
</head>
<body>
	<div class="container-fluid">
		<div class="container-fluid">
			<h1>Cheers! Welcome to BrewBuds</h1>
		</div>

			<c:choose>
				<c:when test="${!empty beers}">

					<table class="table">
						<thead>
							<tr>
								<th scope="col">Rating</th>
								<th scope="col">User</th>
								<th scope="col">Brewery</th>
								<th scope="col">Beer</th>
								<th scope="col">Description</th>
								<th scope="col">Style</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${beers }" var="beer" begin="0" end="5">
								<tr>
									<td>${beer.key}</td>
									<td>${beer.value.user.username}</td>
									<td><a href="BreweryInfo.do?id=${beer.value.brewery.id }">${beer.value.brewery.name}</a></td>
									<td><a href="beerProfile.do?id=${beer.value.id }">${beer.value.name}</a></td>
									<td>${beer.value.description}</td>
									<td>${beer.value.subCategory.name}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:when>
			</c:choose>

		</div>

		<div class="container-fluid">
			<h1 class="display-6">Top 5 Breweries</h1>
			<table class="table">
				<thead>
					<tr>
						<th scope="col">Rating</th>
						<th scope="col">Name</th>
						<th scope="col">City</th>
						<th scope="col">State</th>
						<th scope="col">Country</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${breweries }" var="brewery" begin="0" end="5">
						<tr>
							<td>${brewery.key }</td>
							<td><a href="BreweryInfo.do?id=${brewery.value.id }">${brewery.value.name }</a></td>
							<td>${brewery.value.address.city }</td>
							<td>${brewery.value.address.stateProvince }</td>
							<td>${brewery.value.address.countryCode }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="container-fluid">
			<h1 class="display-6">Top 5 Users</h1>
			<table class="table">
				<thead>
					<tr>
						<th scope="col">Username</th>
						<th scope="col">Rating</th>
						<th scope="col">Merit</th>
						<th scope="col">Beers Posted</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${users }" var="user" begin="0" end="5">
						<tr>
							<td>${user.value.username }</td>
							<td>${user.key }</td>
							<td></td>
							<td></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>


		<form action="ShowAll.do" method="get">
			<input type="submit" value="Show all Reviews">
		</form>
</body>
</html>