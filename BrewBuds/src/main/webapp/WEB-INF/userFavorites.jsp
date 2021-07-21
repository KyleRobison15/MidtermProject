<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username }Find</title>
</head>
<body>
	<div class="container">
		<div class="row align-items-end">
			<div class="col">
				<div class="container">
					<form class="d-flex" action="findBeers.do" method="GET">
						<input class="form-control me-2" type="search"
							placeholder="Search Beers" name="keyword" aria-label="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</form>
				</div>
			</div>
			<div class="col">
				<div class="container">
					<form class="d-flex" action="findBreweries.do" method="GET">
						<input class="form-control me-2" type="search"
							placeholder="Search Breweries" name="keyword" aria-label="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- Stretch: Display list of user's favorite beers and breweries -->
	<!-- Stretch: Display list of user's added beers and breweries -->

	<div class="container">${user }</div>

</body>
</html>