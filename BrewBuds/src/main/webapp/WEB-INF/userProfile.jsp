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

	<div class="container-fluid">
		<div class="container-fluid">
			<div class="row d-flex align-items-center">
				<div class="col" align="center">
					<div class="container">
						<c:choose>
							<c:when test="${not empty user.imageURL}">
								<img src="${user.imageURL}" width="128" height="128"
									class="beer-img" alt="stockBeer" />
							</c:when>

							<c:otherwise>
								<li>Image: <img src="img/defaultProfileImage.png"
									width="128" height="128" class="beer-img" alt="stockBeer" />
								</li>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="col">
					<div class="container border border-dark rounded border-3">
						<div class="row">
							<div class="col" align="center">
								<h1 class="display-3">Rating</h1>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<h1 class="display-4" align="center">${rating }</h1>
							</div>
						</div>
					</div>
				</div>

				<div class="col">
					<div class="container">
						<div class="container border border-dark rounded border-3">
							<div class="row">
								<div class="col" align="center">
									<h1 class="display-3">Merit</h1>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<h1 class="display-4" align="center">${merit }</h1>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col" align="center">
					<div class="container">
						<c:choose>
							<c:when test="${rating < 1}">
								<img src="/img/apprentice.jpg" class="img-fluid" alt="">
							</c:when>
							<c:when test="${rating >= 1 && rating < 2}">
								<img src="/img/shiftBrewer.jpg" class="img-fluid" alt="">
							</c:when>
							<c:when test="${rating >= 2 && rating < 3}">
								<img src="/img/productionBrewer.jpg" class="img-fluid" alt="">
							</c:when>
							<c:when test="${rating >= 3 && rating < 4}">
								<img src="/img/headBrewer.jpg" class="img-fluid" alt="">
							</c:when>
							<c:when test="${rating >= 4}">
								<img src="/img/brewMaster.jpg" class="img-fluid" alt="">
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">
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
						<td><a href="BreweryInfo.do?id=${addedBeer.key.brewery.id }"
							class="link-dark">${addedBeer.key.brewery.name}</a></td>
						<td><a href="beerProfile.do?id=${addedBeer.key.id}"
							class="link-dark">${addedBeer.key.name}</a></td>
						<td>${addedBeer.value}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<a class="btn btn-outline-dark" href="addBeerPage.do">Add a Beer</a>
	</div>
</body>
</html>