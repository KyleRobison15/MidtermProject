<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%>
<%@ include file="nav.jsp"%>
<%@ include file="footer.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Brewery Info</title>
</head>
<body>
<div class="container">
	<h2>${brewery.name}</h2>
<%-- 	<h3>Rating: ${average}</h3> --%>
	<h3>
							<c:choose>
						<c:when test="${average > 3.9 }"><td><span class="badge badge-success">${average}</span></td></c:when>
						<c:when test="${average <= 3.9 && average >= 2.5}"><td><span class="badge badge-warning">${average}</span></td></c:when>
						<c:when test="${average < 2.5}"><td><span class="badge badge-danger">${average}</span></td></c:when>
						</c:choose>
	</h3>
	<div class="breweryInfo">
		<%-- 		<li>Brewery ID: ${brewery.id}</li> --%>

		<table class="table">
			<tbody>
				<tr>
					<th>Description</th>
					<td>${brewery.description}</td>
				</tr>
				<tr>
					<th scope="row">Address</th>
				</tr>
				<tr>
					<th scope="row">Street</th>
					<td>${brewery.address.address}</td>
				</tr>
				<tr>
					<th>City</th>
					<td>${brewery.address.city}</td>
				</tr>
				<tr>
					<th>State</th>
					<td>${brewery.address.stateProvince}</td>
				</tr>
				<tr>
					<th>Postal Code</th>
					<td>${brewery.address.postalCode}</td>
				</tr>
			</tbody>
		</table>
		<%-- <ul>
		<li>Rating: ${average}</li>
		<li>Description: ${brewery.description}</li>
		<li>Address:</li>	
			<ul>
				<li>${brewery.address.address}</li>
				<li>${brewery.address.city}, 
					${brewery.address.stateProvince} 
					${brewery.address.postalCode}</li>
			</ul>
	</ul> --%>
	</div>
</div>
	<div class="container">
	<br>
	<h3>Beers in this Brewery's Icebox</h3>
	<br>
		<c:choose>
			<c:when test="${!empty beers}">
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">Name</th>
							<th scope="col">Description</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="beer" items="${beers}">
							<tr>
								<td><a href="beerProfile.do?id=${beer.id}">${beer.name}</a></td>
								<td>${beer.description}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<p>None Found!</p>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>