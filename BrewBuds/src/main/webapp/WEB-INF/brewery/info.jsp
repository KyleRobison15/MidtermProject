<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
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
		<table>
			<thead> 
				<tr>
				<th>Beer</th>
				<th>Description</th>
				<th>Style</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				<c:forEach var="beer" items="${beers}">
		 		<td><a href="BeerInfo.do?id=${beer.id}">${beer.name}</a></td>
		 		<td>${beer.description}</td>
		 		
		 		<!--Beer Category Table Data here  -->
		 		
				</c:forEach>
			</tbody>
		</table>
</c:when>

<c:otherwise>
	<p>No Reviews Found</p>
</c:otherwise>

</c:choose>
</div>

</body>
</html>