<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="styles.jsp"%> 
<%@ include file="nav.jsp"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Brewery Info</title>
</head>
<body>
<h2>${brewery.name}</h2>
<div class = "breweryInfo">
	<ul>
		<li>Brewery ID: ${brewery.id}</li>
		<li>Rating: ${average}</li>
		<li>Description: ${brewery.description}</li>
		<li>Address:</li>	
			<ul>
				<li>${brewery.address.address}</li>
				<li>${brewery.address.city}, 
					${brewery.address.stateProvince} 
					${brewery.address.postalCode}</li>
			</ul>
	</ul>
</div>
<br>
<h3>Beers in this Brewery's Icebox</h3>
<br>
<div class = "beerTable">
<c:choose>
<c:when test="${!empty beers}">
		<table class="table">
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